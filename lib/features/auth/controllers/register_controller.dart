import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/common/widgets/custom_toast.dart';

import '../../../core/functions.dart';
import '../model/register_response_model.dart';
import '../repository/auth_respository.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;
  var imageController = "".obs;

  /// Function to handle profile picture selection
  profilePic(BuildContext context) async {
    chooseImage(context, (imagePath) {
      imageController.value = imagePath;
    });
    print("imageController ${imageController.value}");
  }

  /// Function to handle form submission
  submit() async {
    if (formKey.currentState!.validate()) {
      isLoading(true);

      // Prepare form data
      var body = {
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'address': addressController.text,
      };

      // Prepare file data
      List<Map<String, String>>? files;
      if (imageController.value.isNotEmpty) {
        files = [
          {'file': imageController.value}
        ];
      }

      // Make the API call
      RegisterResponseModel? response = await AuthRepository().register(body, files);

      // Handle the response
      if (response != null && response.message == null) {
        CustomToast.showSuccess("Registration complete!");
      } else {
        CustomToast.showFailed(response?.message ?? "Something went wrong.");
      }
      isLoading(false);
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
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}