import 'package:cashback/view/custom_widgets/app_color.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:easy_localization/easy_localization.dart' ;
import 'package:cashback/view/imports.dart';

class AppBarWidget extends StatelessWidget {
  final String text;
  const AppBarWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 10,
            ).r,
            child: Icon(
              Icons.arrow_back,
              size: 32.r,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 25).r,
          child: CustomText(
            text.tr(),
            style: Styles.robotoStyle(
              FontWeight.bold,
              26,
              AppColor.blackColor,context,
            ),
          ),
        ),
      ],
    );
  }
}
