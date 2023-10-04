// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:masterapp/entity/filePickerNavigate.dart';
// import 'package:kartal/kartal.dart';

// class FilePickerSheet {
//   final BuildContext context;

//   FilePickerSheet(this.context);

//   Future<FilePickerNavigateModel?> show() async {
//     return await showModalBottomSheet<FilePickerNavigateModel>(
//       context: context,
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(top: context.border.lowRadius)),
//       builder: (context) => const FilePickerSheetView(),
//     );
//   }
// }

// class FilePickerSheetView extends StatelessWidget {
//   const FilePickerSheetView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           ListTile(
//             leading: const Icon(Icons.file_copy),
//             title: const Text('Choose File'),
//             // onTap: () async {
//             //   final result = await FilePicker.platform.pickFiles(
//             //       allowMultiple: true,
//             //       type: FileType,
//             //       allowedExtensions: ['pdf']);

//             //   Navigator.of(context).pop(result);
//             onTap: () async {
//               final result = await FilePicker.platform
//                   .pickFiles(allowMultiple: true, allowedExtensions: ['pdf']);

//               Navigator.of(context)
//                   .pop(FilePickerNavigateModel(filePickerResults: result));
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.photo),
//             title: const Text('Choose Image'),
//             onTap: () async {
//               final _image = await ImagePicker().pickMultiImage();
//               Navigator.of(context).pop(_image);
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.videocam),
//             title: const Text('Take a Photo'),
//             onTap: () async {
//               final _image =
//                   await ImagePicker().pickImage(source: ImageSource.camera);
//               Navigator.of(context).pop(_image);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
