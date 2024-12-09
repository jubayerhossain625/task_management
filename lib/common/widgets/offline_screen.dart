import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OfflineScreen extends StatelessWidget {
  const OfflineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // This will prevent the back button from working normally
        // and will exit the app instead
        SystemNavigator.pop(); // or use Navigator.pop(context);
        return false; // Return false to indicate that you don't want to pop
      },
      child:  const Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 15.0,left: 20),
                    child: Icon(
                      FontAwesomeIcons.globe, // World icon
                      size: 120.0, // Adjust the size as needed
                      color: Colors.black54, // Adjust the color as needed
                    ),
                  ),
                  Icon(
                    FontAwesomeIcons.triangleExclamation, // World icon
                    size: 50.0, // Adjust the size as needed
                    color: Colors.red, // Adjust the color as needed
                  ),
                ],
              ),
              SizedBox(height: 25,),
              Text("You are Offline!",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w900),),
              SizedBox(height: 10,),
              Text("Please check your internet connection.",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
            ],
          ),
        ),
      ),
    );
  }
}
