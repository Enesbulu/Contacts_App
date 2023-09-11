/*
 * Copyright 2019 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.gradle.plugin.devel.tasks.internal;

import com.google.common.base.Charsets;
import com.google.common.base.Joiner;
import com.google.common.collect.ImmutableList;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.google.common.io.Files;
import org.gradle.api.Task;
import org.gradle.api.UncheckedIOException;
import org.gradle.api.artifacts.transform.CacheableTransform;
import org.gradle.api.artifacts.transform.TransformAction;
import org.gradle.api.file.ConfigurableFileCollection;
import org.gradle.api.file.EmptyFileVisitor;
import org.gradle.api.file.FileVisitDetails;
import org.gradle.api.file.RegularFileProperty;
import org.gradle.api.internal.DocumentationRegistry;
import org.gradle.api.logging.Logger;
import org.gradle.api.logging.Logging;
import org.gradle.api.provider.Property;
import org.gradle.api.tasks.CacheableTask;
import org.gradle.api.tasks.UntrackedTask;
import org.gradle.internal.classanalysis.AsmConstants;
import org.gradle.internal.reflect.DefaultTypeValidationContext;
import org.gradle.internal.reflect.problems.ValidationProblemId;
import org.gradle.internal.reflect.validation.Severity;
import org.gradle.internal.reflect.validation.TypeProblemBuilder;
import org.gradle.work.DisableCachingByDefault;
import org.gradle.workers.WorkAction;
import org.gradle.workers.WorkParameters;
import org.objectweb.asm.ClassReader;
import org.objectweb.asm.ClassVisitor;
import org.objectweb.asm.Opcodes;

import java.io.File;
import java.io.IOException;
import java.lang.annotation.Annotation;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import static org.gradle.internal.reflect.validation.Severity.ERROR;

public abstract class ValidateAction implements WorkAction<ValidateAction.Params> {
    private final static Logger LOGGER = Logging.getLogger(ValidateAction.class);
    public static final String PROBLEM_SEPARATOR = "--------";

    public interface Params extends WorkParameters {
        ConfigurableFileCollection getClasses();
        RegularFileProperty getOutputFile();
        Property<Boolean> getEnableStricterValidation();
    }

    @Override
    public void execute() {
        ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
        Map<String, Boolean> taskValidationProblems = Maps.newTreeMap();

        Params params = getParameters();

        params.getClasses().getAsFileTree().visit(new EmptyFileVisitor() {
            @Override
            public void visitFile(FileVisitDetails fileDetails) {
                if (!fileDetails.getPath().endsWith(".class")) {
                    return;
                }
                ClassReader reader;
                try {
                    reader = new ClassReader(Files.asByteSource(fileDetails.getFile()).read());
                } catch (IOException e) {
                    throw new UncheckedIOException(e);
                }
                List<String> classNames = Lists.newArrayList();
                reader.accept(new TaskNameCollectorVisitor(classNames), ClassReader.SKIP_CODE);
                for (String className : classNames) {
                    Class<?> clazz;
                    try {
                        clazz = classLoader.loadClass(className);
                    } catch (IncompatibleClassChangeError | NoClassDefFoundError | VerifyError | ClassNotFoundException e) {
                        LOGGER.debug("Could not load class: " + className, e);
                        continue;
                    }
                    collectValidationProblems(clazz, taskValidationProblems, params.getEnableStricterValidation().get());
                }
            }
        });
        List<String> problemMessages = toProblemMessages(taskValidationProblems);
        storeResults(problemMessages, params.getOutputFile());
    }

    private static void collectValidationProblems(Class<?> topLevelBean, Map<String, Boolean> problems, boolean enableStricterValidation) {
        DefaultTypeValidationContext validationContext;
        if (Task.class.isAssignableFrom(topLevelBean)) {
            validationContext = createValidationContextAndValidateCacheableAnnotations(topLevelBean, CacheableTask.class, enableStricterValidation);
        } else if (TransformAction.class.isAssignableFrom(topLevelBean)) {
            validationContext = createValidationContextAndValidateCacheableAnnotations(topLevelBean, CacheableTransform.class, enableStricterValidation);
        } else {
            validationContext = createValidationContext(topLevelBean, enableStricterValidation);
        }
        PropertyValidationAccess.collectValidationProblems(topLevelBean, validationContext);

        validationContext.getProblems()
            .forEach((message, severity) -> problems.put(message, severity == ERROR));
    }

    private static DefaultTypeValidationContext createValidationContextAndValidateCacheableAnnotations(Class<?> topLevelBean, Class<? extends Annotation> cacheableAnnotationClass, boolean enableStricterValidation) {
        boolean cacheable = topLevelBean.isAnnotationPresent(cacheableAnnotationClass);
        DefaultTypeValidationContext validationContext = createValidationContext(topLevelBean, cacheable || enableStricterValidation);
        if (enableStricterValidation) {
            validateCacheabilityAnnotationPresent(topLevelBean, cacheable, cacheableAnnotationClass, validationContext);
        }
        return validationContext;
    }

    private static DefaultTypeValidationContext createValidationContext(Class<?> topLevelBean, boolean reportCacheabilityProblems) {
        return DefaultTypeValidationContext.withRootType(new DocumentationRegistry(), topLevelBean, reportCacheabilityProblems);
    }

    private static void validateCacheabilityAnnotationPresent(Class<?> topLevelBean, boolean cacheable, Class<? extends Annotation> cacheableAnnotationClass, DefaultTypeValidationContext validationContext) {
        if (topLevelBean.isInterface()) {
            // Won't validate interfaces
            return;
        }
        if (!cacheable
            && topLevelBean.getAnnotation(DisableCachingByDefault.class) == null
            && topLevelBean.getAnnotation(UntrackedTask.class) == null
        ) {
            boolean isTask = Task.class.isAssignableFrom(topLevelBean);
            String cacheableAnnotation = "@" + cacheableAnnotationClass.getSimpleName();
            String disableCachingAnnotation = "@" + DisableCachingByDefault.class.getSimpleName();
            String untrackedTaskAnnotation = "@" + UntrackedTask.class.getSimpleName();
            String workType = isTask ? "task" : "transform action";
            validationContext.visitTypeProblem(problem -> {
                    TypeProblemBuilder builder = problem.reportAs(Severity.WARNING)
                        .withId(ValidationProblemId.NOT_CACHEABLE_WITHOUT_REASON)
                        .forType(topLevelBean)
                        .withDescription("must be annotated either with " + cacheableAnnotation + " or with " + disableCachingAnnotation)
                        .happensBecause("The " + workType + " author should make clear why a " + workType + " is not cacheable")
                        .documentedAt("validation_problems", "disable_caching_by_default")
                        .addPossibleSolution("Add " + disableCachingAnnotation + "(because = ...)")
                        .addPossibleSolution("Add " + cacheableAnnotation);
                    if (isTask) {
                        builder.addPossibleSolution("Add " + untrackedTaskAnnotation + "(because = ...)");
                    }
                }
            );
        }
    }

    private static void storeResults(List<String> problemMessages, RegularFileProperty outputFile) {
        if (outputFile.isPresent()) {
            File output = outputFile.get().getAsFile();
            try {
                //noinspection ResultOfMethodCallIgnored
                output.createNewFile();
                Files.asCharSink(output, Charsets.UTF_8).write(Joiner.on("\n" + PROBLEM_SEPARATOR + "\n").join(problemMessages));
            } catch (IOException ex) {
                throw new java.io.UncheckedIOException(ex);
            }
        }
    }

    private static List<String> toProblemMessages(Map<String, Boolean> problems) {
        ImmutableList.Builder<String> builder = ImmutableList.builder();
        for (Map.Entry<String, Boolean> entry : problems.entrySet()) {
            String problem = entry.getKey();
            Boolean error = entry.getValue();
            builder.add(String.format("%s: %s",
                Boolean.TRUE.equals(error) ? "Error" : "Warning",
                problem
            ));
        }
        return builder.build();
    }

    private static class TaskNameCollectorVisitor extends ClassVisitor {
        private final Collection<String> classNames;

        public TaskNameCollectorVisitor(Collection<String> classNames) {
            super(AsmConstants.ASM_LEVEL);
            this.classNames = classNames;
        }

        @Override
        public void visit(int version, int access, String name, String signature, String superName, String[] interfaces) {
            if ((access & Opcodes.ACC_PUBLIC) != 0) {
                classNames.add(name.replace('/', '.'));
            }
        }
    }
}
