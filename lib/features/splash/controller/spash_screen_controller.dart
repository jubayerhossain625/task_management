import 'dart:async';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/routes/routes.dart';
import '../../../util/app_constants.dart';


class SplashScreenController extends GetxController {

  @override
  void onInit() {
    super.onInit();
   _initialized();
  }

  Future<void> _initialized() async {
    dynamic token = await GetStorage().read(AppConstants.token);
    print("token+++++++++++ ${token}");
    Timer(
      const Duration(seconds: 3),
      () {
        if (token != null && token != "" && token != "null") {
          Get.offNamedUntil(Routes.home, (route) => false);
        }else{
          Get.offNamedUntil(Routes.login, (route) => false);
        }
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
