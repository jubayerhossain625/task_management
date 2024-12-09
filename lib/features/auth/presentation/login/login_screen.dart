import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/common/widgets/custom_material_button.dart';
import 'package:task_management/common/widgets/custom_text_view.dart';
import '../../../../common/widgets/text_field_widget.dart';
import '../../../../core/routes/routes.dart';
import '../../controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
final controller = Get.put(LoginController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 40,),
              SizedBox(height: 200, child: Image.asset('assets/tms_logo-removebg-preview.png')),
               Text(
                "Task Management System",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 40,),
              TextFieldWidget(
                title: true,titleName: "Email",
                controller: controller.emailController,
                hintText: 'Enter your email',
                inputType: TextInputType.emailAddress,
                isRequired: true,
              ),
              const SizedBox(height: 18,),
              TextFieldWidget(
                title: true,titleName: "Password",
                controller: controller.passwordController,
                hintText: 'Enter your password',
                inputType: TextInputType.visiblePassword,
                isPassword: true,
                isRequired: true,
              ),
              const SizedBox(height: 50,),
              Obx(
                  ()=>
                      controller.isLoading.value? const CircularProgressIndicator():
                      CustomMaterialButton(
                    onPressed: (){
                      controller.login();
                    },
                    title: "Login"),
              ),
              const SizedBox(height: 30,),
               Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomTextView(text: "Don't have an account?",),
                  InkWell(
                      onTap: (){
                        Get.offAndToNamed(Routes.register);
                      },
                      child:  const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 3),
                        child: CustomTextView(text: "Register",textColor:Colors.black,),
                      )),
                ],
              ),


            ],
          ),
        ),
      ),
    );
  }
}
