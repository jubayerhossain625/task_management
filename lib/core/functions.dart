import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';

import '../common/widgets/custom_image_upload_bottomsheet.dart';


// Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
// //Get external storage directory
//   Directory directory = await getApplicationSupportDirectory();
// //Get directory path
//   String path = directory.path;
// //Create an empty file to write PDF data
//   File file = File('$path/$fileName');
// //Write PDF data
//   await file.writeAsBytes(bytes, flush: true);
// //Open the PDF document in mobile
//   OpenFile.open('$path/$fileName');
// }

Future<XFile?> chooseImageMultipart({fromCamera = false}) async {
  final pickedFile = await ImagePicker().pickImage(
    source: fromCamera ? ImageSource.camera : ImageSource.gallery,
    maxWidth: 1800,
    maxHeight: 1800,
  );
  if (pickedFile != null) {
    return XFile(pickedFile.path);
  }
  return null;
}

void showCustomImageUploadBottomSheet(
    context, Function() onSelectCamera, Function() onSelectGallery) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.r),
        topRight: Radius.circular(20.r),
      ),
    ),
    builder: (context) {
      return CustomImageUploadBottomSheet(onSelectCamera, onSelectGallery);
    },
  );
}

chooseImage(BuildContext context, Function(String imagePath) onChooseImage) {
  showCustomImageUploadBottomSheet(context, () async {
    XFile? selectedImage = await chooseImageMultipart(fromCamera: true);
    onChooseImage(selectedImage!.path);
  }, () async {
    XFile? selectedImage = await chooseImageMultipart();
    onChooseImage(selectedImage!.path);
  });
}

