import 'package:get/get.dart';
import 'package:task_management/core/data/local_data/local_storage_source.dart';

import '../../features/splash/controller/spash_screen_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(LocalStorage(), permanent: true);
    Get.put(SplashScreenController(), permanent: true);
  }
}
