import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/common/widgets/custom_material_button.dart';
import 'package:task_management/common/widgets/custom_text_view.dart';
import '../../../../common/widgets/text_field_widget.dart';
import 'controllers/edit_profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProfileController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: const Icon(Icons.arrow_back_ios,color: Colors.black,)),
      title: const CustomTextView(text: "Edit Profile",textViewStyle: CustomTextViewStyle.large,),
      ),
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
                  titleName: "Address",
                  maxLines: 2,
                  controller: controller.addressController,
                  hintText: 'Enter your address',
                  inputType: TextInputType.streetAddress,
                  isRequired: true,
                  validator: (value) => value == null || value.isEmpty ? "Address is required" : null,
                ),
                const SizedBox(height: 18),

                Obx(
                    ()=>

                        controller.isLoading.value ? const CircularProgressIndicator() :
                        CustomMaterialButton(
                    onPressed: () => controller.submit(),
                    title: "Update",
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
