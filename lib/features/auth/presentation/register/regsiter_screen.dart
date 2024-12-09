import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/common/widgets/custom_material_button.dart';
import 'package:task_management/common/widgets/custom_text_view.dart';
import '../../../../common/widgets/text_field_widget.dart';
import '../../../../core/routes/routes.dart';
import '../../controllers/register_controller.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 40),
                const CustomTextView(
                    text: "Create a new account",
                    textColor: Colors.indigo,
                    textViewStyle: CustomTextViewStyle.large,
                    fontWeight: FontWeight.w600),
                const SizedBox(height: 20),
                Obx(
                      () => InkWell(
                    onTap: () {
                      controller.profilePic(context);
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: controller.imageController.value != ""
                          ? FileImage(File(controller.imageController.value))
                          : null,
                      child: controller.imageController.value == ""
                          ? IconButton(
                          onPressed: () {
                            controller.profilePic(context);
                          },
                          icon: const Icon(
                            Icons.add_circle,
                            color: Colors.blue,
                            size: 30,
                          ))
                          : const SizedBox(),
                    ),
                  ),
                ),
                const CustomTextView(text: "Choose a profile picture*"),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWidget(
                        title: true,
                        titleName: "First Name",
                        controller: controller.firstNameController,
                        hintText: 'Enter here',
                        inputType: TextInputType.name,
                        isRequired: true,
                        validator: (value) => value == null || value.isEmpty ? "First name is required" : null,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFieldWidget(
                        title: true,
                        titleName: "Last Name",
                        controller: controller.lastNameController,
                        hintText: 'Enter here',
                        inputType: TextInputType.name,
                        isRequired: true,
                        validator: (value) => value == null || value.isEmpty ? "Last name is required" : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                TextFieldWidget(
                  title: true,
                  titleName: "Email",
                  controller: controller.emailController,
                  hintText: 'Enter your email',
                  inputType: TextInputType.emailAddress,
                  isRequired: true,
                  validator: (value) =>
                  value == null || !GetUtils.isEmail(value) ? "Enter a valid email address" : null,
                ),
                const SizedBox(height: 18),
                TextFieldWidget(
                  title: true,
                  titleName: "Address",
                  maxLines: 2,
                  controller: controller.addressController,
                  hintText: 'Enter your address',
                  inputType: TextInputType.streetAddress,
                  isRequired: true,
                  validator: (value) => value == null || value.isEmpty ? "Address is required" : null,
                ),
                const SizedBox(height: 18),
                TextFieldWidget(
                  title: true,
                  titleName: "Password",
                  controller: controller.passwordController,
                  hintText: 'Enter your password',
                  inputType: TextInputType.visiblePassword,
                  isPassword: true,
                  isRequired: true,
                  validator: (value) =>
                  value == null || value.length < 6 ? "Password must be at least 6 characters long" : null,
                ),
                const SizedBox(height: 50),

                Obx(
                    ()=>

                        controller.isLoading.value ? const CircularProgressIndicator() :
                        CustomMaterialButton(
                    onPressed: () => controller.submit(),
                    title: "Register",
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomTextView(text: "Already have an account?"),
                    InkWell(
                        onTap: () {
                          Get.offAndToNamed(Routes.login);
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 3),
                          child: CustomTextView(
                            text: "Login",
                            textColor: Colors.black,
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
