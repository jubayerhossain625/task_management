import 'package:get/get.dart';

import '../controller/spash_screen_controller.dart';

class SplashScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashScreenController());
  }
}
