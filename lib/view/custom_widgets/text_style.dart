import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  // static double _textScale(
  //     BuildContext context,
  //     ) {
  //   print(MediaQuery.of(context).textScaleFactor);
  //   return MediaQuery.of(context).textScaleFactor > 1.0
  //       ? 1.0
  //       : MediaQuery.of(context).textScaleFactor;
  // }
  static robotoStyle(FontWeight fontWeight, double fontSize, Color color,context,{double? height,double? letterSpacing}) {
    return GoogleFonts.roboto(
      fontSize: fontSize.sp ,
      color: color,

      fontWeight: fontWeight,
      height: height??1,
      letterSpacing: letterSpacing??0
    );
  }


  static robotoStyle2({FontWeight? fontWeight, double? fontSize, Color? color,required BuildContext context,double? height,double? letterSpacing}) {
    return GoogleFonts.roboto(
        fontSize: (fontSize??14).sp ,
        color: color??Colors.black,
        fontWeight: fontWeight??FontWeight.normal,
        height: height??1,
        letterSpacing: letterSpacing??0
    );
  }




}
