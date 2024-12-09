import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomToast {
  static void showToast(String message, Color bgColor, Color textColor) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: bgColor,
      textColor: textColor,
      fontSize: 14.0,
    );
  }

  // Warning toast
  static void showWarning(String message) {
    showToast(message, const Color(0xFF1D1F00), const Color(0xFFEDCA56));
  }

  // Failed toast
  static void showFailed(String message) {
    showToast(message, const Color(0xFF2D0607), const Color(0xFFF8999C));
  }

  // Success toast
  static void showSuccess(String message) {
    showToast(message, const Color(0xFF001F0F), const Color(0xFF57EDA2));
  }
}
