import 'package:cashback/view/custom_widgets/app_color.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget prefixIcon;
  final bool obscureText;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final Color? borderColor;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? textSize;

  TextFieldWidget({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    required this.obscureText,
    required this.textInputType,
    required this.validator,
    this.borderColor = AppColor.greyColor,
    this.textColor = AppColor.lightBlackColor,
    this.fontWeight = FontWeight.normal,
    this.textSize = 15,
  }) : super(key: key);

  final double borderRadius = 28.0;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      keyboardType: textInputType,
      obscureText: obscureText,
      controller: controller,
      style: Styles.robotoStyle(fontWeight!, textSize!, textColor!,context),
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        hintStyle:
            Styles.robotoStyle(FontWeight.normal, 15, AppColor.greyColor,context),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
          borderSide: const BorderSide(color: AppColor.blackColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
          borderSide: BorderSide(color: borderColor!),
        ),
      ),
    );
  }
}
