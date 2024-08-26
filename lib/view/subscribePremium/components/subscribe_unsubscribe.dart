import 'package:cashback/view/custom_widgets/app_color.dart';
import 'package:cashback/view/custom_widgets/custom_button.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cashback/view/imports.dart';
class SubscribeAndUnsubscribe extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;
  final VoidCallback onTap;
  const SubscribeAndUnsubscribe({
    Key? key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.symmetric(horizontal: 10).r,
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 100,
      ).r,
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 4,
            blurRadius: 10,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25).r,
                child: Image.asset(
                  image,
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 35,
                  bottom: 5,
                ).r,
                child: CustomText(
                  title,
                  textAlign: TextAlign.center,
                  style: Styles.robotoStyle(
                    FontWeight.bold,
                    23.sp,
                    AppColor.blackColor,context
                  ),
                ),
              ),
              CustomText(
                subTitle,
                textAlign: TextAlign.center,
                style: Styles.robotoStyle(
                  FontWeight.w400,
                  15.sp,
                  Colors.grey,context
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: onTap,
            behavior: HitTestBehavior.opaque,
            child: CustomButton(title: "Done"),
          ),
        ],
      ),
    );
  }
}
