import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cashback/view/imports.dart';
class CustomButton extends StatefulWidget {
  String title;

  CustomButton({required this.title});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 70.sp, right: 70.sp),
      alignment: Alignment(0.0, -0.08),
      width: 202.0,
      height: 45.0.sp,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.0.sp),
        color: const Color(0xFFFC4F08),
      ),
      child: Center(
        child: CustomText(
          widget.title,
          style: GoogleFonts.roboto(
            fontSize: 14.0,
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
