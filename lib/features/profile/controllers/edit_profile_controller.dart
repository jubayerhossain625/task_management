import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_management/common/widgets/custom_toast.dart';
import 'package:task_management/features/home/controllers/home_controller.dart';
import '../../../core/functions.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/common/widgets/custom_toast.dart';
import 'package:task_management/features/home/controllers/home_controller.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../core/functions.dart';
import '../../../util/app_constants.dart';

class EditProfileController extends GetxController {

  GetStorage storage = GetStorage();

  HomeController homeController = Get.put(HomeController());
  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final addressController = TextEditingController();

  var isLoading = false.obs;
  var imageController = "".obs;

  /// Function to handle profile picture selection
  profilePic(BuildContext context) async {
    chooseImage(context, (imagePath) {
      imageController.value = imagePath;
    });
    print("imageController ${imageController.value}");
  }

  loadData() {
    firstNameController.text = homeController.myProfile.value?.data?.firstName ?? "";
    lastNameController.text = homeController.myProfile.value?.data?.lastName ?? "";
    addressController.text = homeController.myProfile.value?.data?.address ?? "";
    update();
  }

  /// Function to handle form submission
  submit() async {
    if (formKey.currentState!.validate()) {
      isLoading(true);

      try {
        // API endpoint
        var url = Uri.parse('http://206.189.138.45:8052/user/update-profile');

        // Prepare headers
        var headers = {
          'Authorization': 'Bearer ${storage.read(AppConstants.token)}',
        };

        // Prepare form fields
        var request = http.MultipartRequest('PATCH', url);
        request.fields.addAll({
          'firstName': firstNameController.text,
          'lastName': lastNameController.text,
          'address': addressController.text,
        });

        // Attach file if selected
        if (imageController.value.isNotEmpty) {
          request.files.add(await http.MultipartFile.fromPath('file', imageController.value));
        }

        // Add headers
        request.headers.addAll(headers);

        // Send request
        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          var responseBody = await response.stream.bytesToString();
          print(responseBody);
          CustomToast.showSuccess("Profile updated successfully!");
          Get.back();
          homeController.getMyProfile();
        } else {
          print(response.reasonPhrase);
          CustomToast.showFailed("Failed to update profile: ${response.reasonPhrase}");
        }
      } catch (e) {
        print("Error: $e");
        CustomToast.showFailed("An error occurred. Please try again.");
      } finally {
        isLoading(false);
      }
    } else {
      CustomToast.showFailed("Please fill all required fields.");
    }
  }

  /// Clean up controllers when not in use
  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    loadData();
    super.onInit();
  }
}