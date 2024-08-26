import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_color.dart';
import 'package:cashback/view/imports.dart';
// ignore: must_be_immutable
class CustomDropDownWidget extends StatefulWidget {
  final String hintText;
  dynamic value;
  final String validationText;
  final ValueChanged onChanged;
  final List<DropdownMenuItem<Object>> itemsMap;
  CustomDropDownWidget({
    super.key,
    required this.hintText,
    required this.value,
    required this.validationText,
    required this.onChanged,
    required this.itemsMap,
  });

  @override
  State<CustomDropDownWidget> createState() => _CustomDropDownWidgetState();
}

class _CustomDropDownWidgetState extends State<CustomDropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null) {
          return widget.validationText;
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        errorMaxLines: 1,
        contentPadding:
            const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15).r,
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28).r,
            borderSide: BorderSide(
              color: Colors.red,
              width: 1.w,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28).r,
            borderSide: BorderSide(
              color: AppColor.greyColor,
              width: 1.w,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28).r,
            borderSide: BorderSide(
              color: AppColor.greyColor,
              width: 1.w,
            )),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28).r,
            borderSide: BorderSide(
              color: AppColor.blackColor,
              width: 1.w,
            )),
      ),
      hint: CustomText(widget.hintText,
          style:
              Styles.robotoStyle(FontWeight.normal, 14.sp, AppColor.greyColor,context)),
      dropdownColor: Colors.white,
      icon: const Icon(
        Icons.keyboard_arrow_down,
        color: AppColor.blackColor,
      ),
      iconSize: 28.r,
      isExpanded: true,
      style: Styles.robotoStyle(FontWeight.normal, 14.sp, AppColor.blackColor,context),
      value: widget.value,
      onChanged: widget.onChanged,
      items: widget.itemsMap,
    );
  }
}
