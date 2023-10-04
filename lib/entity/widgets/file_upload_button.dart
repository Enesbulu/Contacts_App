// import 'package:flutter/material.dart';
// import 'package:kartal/kartal.dart';
// import 'package:masterapp/entity/filePickerNavigate.dart';
// import 'package:masterapp/pages/filePickerView.dart';

// class FileUploadButton extends StatelessWidget {
//   const FileUploadButton({Key? key, required this.onResult}) : super(key: key);
//   final void Function(FilePickerNavigateModel result) onResult;
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//         style: ElevatedButton.styleFrom(foregroundColor: Colors.yellow),
//         onPressed: () async {
//           final result = await FilePickerSheet(context).show();
//           if (result != null) {
//             onResult(result);
//           }
//         },
//         child: Text('Yükle',
//             style: context.general.textTheme.titleLarge
//                 ?.copyWith(color: context.general.colorScheme.background)));
//   }
// }
