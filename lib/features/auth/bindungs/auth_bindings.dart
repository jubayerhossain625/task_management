
import 'package:get/get.dart';
import 'package:task_management/features/auth/controllers/login_controller.dart';
import 'package:task_management/features/auth/controllers/register_controller.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => RegisterController());

  }
}