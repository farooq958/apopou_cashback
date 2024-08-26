import 'package:cashback/view/custom_widgets/app_color.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MultiLineTextField extends StatelessWidget {
  final TextEditingController controller;
  final int? maxline;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  const MultiLineTextField({
    super.key,
    required this.controller,
    this.maxline = 3,
    this.validator,
    this.textInputType = TextInputType.multiline,
  });
  final double borderRadius = 10.0;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      keyboardType: textInputType,
      controller: controller,
      maxLines: maxline,
      cursorColor: AppColor.primaryColor,
      style:
          Styles.robotoStyle(FontWeight.normal, 16, AppColor.lightBlackColor,context),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColor.MultiLineTextFieldColor,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16).r,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
          borderSide: const BorderSide(color: AppColor.blackColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
          borderSide: const BorderSide(color: AppColor.greyColor),
        ),
      ),
    );
  }
}
