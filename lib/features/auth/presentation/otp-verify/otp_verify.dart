import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/common/widgets/custom_material_button.dart';
import 'package:task_management/common/widgets/custom_text_view.dart';
import '../../../../common/widgets/text_field_widget.dart';
import '../../../../core/routes/routes.dart';
import '../../controllers/login_controller.dart';

class OTPVerify extends StatelessWidget {
  const OTPVerify({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F7F7),
        leading: IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back_ios,color: Colors.black,)),
      ),
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
              const SizedBox(height: 40,),
              Text(
                "Activate your account",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 40,),

              TextFieldWidget(
                title: true,titleName: "Activation Code",
                controller: controller.codeController,
                hintText: 'Enter your activation code',
                inputType: TextInputType.number,
                isRequired: true,
              ),
              const SizedBox(height: 50,),
              Obx(
                  ()=>
                      controller.isLoading.value? const CircularProgressIndicator():
                      CustomMaterialButton(
                    onPressed: (){
                      controller.verify();
                    },
                    title: "Verify"),
              ),



            ],
          ),
        ),
      ),
    );
  }
}
