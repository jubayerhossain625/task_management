import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_management/common/widgets/custom_text_view.dart';

class CustomMaterialButton extends StatelessWidget {
  //Jubayer
  final Color backgroundColor;
  final Function() onPressed;
  final String title;
  final double fontSize;
  final Color textColor;
  final double? height;
  final double width;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final Color? borderColor;
  final FontWeight fontWeight;
  final Gradient? containerGradient;
  final double borderWidth;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final double spaceBetweenIconAndText;
  const CustomMaterialButton({
    super.key,
    this.backgroundColor = Colors.indigo,

    /// todo Primary Color
    required this.onPressed,
    required this.title,
    this.fontSize = 16,
    this.textColor = Colors.white,
    this.height,
    this.width = double.maxFinite,
    this.padding = const EdgeInsets.fromLTRB(10, 10, 10, 10),
    this.borderRadius = 10.0,
    this.fontWeight = FontWeight.normal,
    this.containerGradient,
    this.borderWidth = 1.0,
    this.borderColor = Colors.transparent,
    this.prefixWidget,
    this.suffixWidget,
    this.spaceBetweenIconAndText = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          gradient: containerGradient,
          borderRadius: BorderRadius.circular(borderRadius)),
      child: TextButton(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(Size.zero),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          backgroundColor: MaterialStatePropertyAll(backgroundColor),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              side: BorderSide(
                color: borderColor ?? Colors.white, // your color here
                width: borderWidth,
              ),
              borderRadius: BorderRadius.circular(borderRadius))),
        ),
        onPressed: () {
          onPressed();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (prefixWidget != null) prefixWidget!,
            Padding(
              padding: padding,
              child: CustomTextView(text: title, fontSize: fontSize, textColor: textColor, fontWeight: fontWeight),
            ),
            if (suffixWidget != null) suffixWidget!,
          ],
        ),
      ),
    );
  }
}
