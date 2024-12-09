import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_management/features/auth/repository/auth_respository.dart';

import '../../../core/routes/routes.dart';
import '../../../util/app_constants.dart';
import '../model/loginresponsemodel.dart';
import '../model/otp_verify_response_model.dart';

 class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final codeController = TextEditingController();

  var isLoading = false.obs;
  var isLoadingOTP = false.obs;

GetStorage getStorage = GetStorage();
  login()async{
    isLoading(true);
   var body={
     "email":emailController.text,
     "password":passwordController.text
   };
   LoginResponseModel? response = await AuthRepository().login(body);
   if(response!=null){
    await getStorage.write(AppConstants.token, response.data!.token);
    codeController.text=response.data!.user!.activationCode.toString();
    isLoading(false);
    Get.toNamed(Routes.otpVerify);
   }
    isLoading(false);
  }

  verify()async{
    isLoadingOTP(true);
    var body={
      "email":emailController.text,
      "code":codeController.text
    };
    OtpVerifyResponseModel? response = await AuthRepository().verify(body);
    if(response!=null){
      isLoading(false);
if(response.message.toString().toLowerCase()=="Account activated".toLowerCase()){
  Get.offNamedUntil(Routes.home, (route) => false);
}
      isLoading(false);
    }
    isLoading(false);

  }
}