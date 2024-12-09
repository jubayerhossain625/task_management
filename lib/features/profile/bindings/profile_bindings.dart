

import 'package:get/get.dart';
import 'package:task_management/features/home/controllers/home_controller.dart';

import '../controllers/edit_profile_controller.dart';

class ProfileBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<EditProfileController>(() => EditProfileController());
    Get.lazyPut<HomeController>(() => HomeController());
  }

}