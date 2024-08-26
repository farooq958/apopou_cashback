import 'package:cashback/view/custom_widgets/app_color.dart';
import 'package:cashback/view/custom_widgets/custom_button.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cashback/view/imports.dart';
class UnSubscribeDialogue extends StatelessWidget {
  const UnSubscribeDialogue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 30,
      ).r,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset("images/sad_icon.svg"),
          Padding(
            padding: const EdgeInsets.only(
              top: 25,
              bottom: 35,
            ).r,
            child: CustomText(
              "Are you sure you want to\nunsubscribe?",
              textAlign: TextAlign.center,
              style: Styles.robotoStyle(
                FontWeight.w500,
                18.sp,
                AppColor.lightBlackColor,context
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ActionButton(
                title: "Cancel",
                buttonColor: Color(0xffa7a7a7),
                onTap: () => Navigator.pop(context),
              ),
              ActionButton(
                title: "Yes",
                onTap: () async {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color? buttonColor;
  final Color? textColor;
  const ActionButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.buttonColor = AppColor.primaryColor,
    this.textColor = AppColor.whiteColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.35,
        padding: const EdgeInsets.symmetric(vertical: 13).r,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(4).r,
        ),
        child: Center(
          child: CustomText(
            title,
            style: Styles.robotoStyle(
              FontWeight.w900,
              14.0,
              AppColor.whiteColor,context
            ),
          ),
        ),
      ),
    );
  }
}
