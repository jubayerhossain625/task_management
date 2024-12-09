
import 'package:flutter/material.dart';
class SplashScreenView extends StatelessWidget {
  const SplashScreenView({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset('assets/tms_logo.png')),
        const Text("Task Management System",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}
