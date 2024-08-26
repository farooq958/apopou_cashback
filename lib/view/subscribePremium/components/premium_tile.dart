import 'package:cashback/view/custom_widgets/app_color.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cashback/view/imports.dart';
class PremiumTile extends StatelessWidget {
  final String text;
  final double? bPadding;
  const PremiumTile({
    Key? key,
    required this.text,
    this.bPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bPadding ?? 10).r,
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: AppColor.primaryColor,
            size: 22.r,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 6).r,
              child: CustomText(
                text.tr(),
                softWrap: true,
                maxLines: 5,
                style: Styles.robotoStyle(
                  FontWeight.w400,
                  15.sp,
                  AppColor.blackColor,context
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
