import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../custom_widgets/custom_button.dart';
import '../custom_widgets/app_color.dart';
import 'package:cashback/view/imports.dart';

class SuccessfullyPasswordChangeScreen extends StatelessWidget {
  const SuccessfullyPasswordChangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: double.infinity,
                height: 650.h,
                margin: const EdgeInsets.symmetric(horizontal: 15).r,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 30).r,
                decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.circular(8).r,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Image.asset("images/passwordChanged.png"),
                        space(10),
                        CustomText(
                          "Password Changed!".tr(),
                          textAlign: TextAlign.center,
                          style: Styles.robotoStyle(
                            FontWeight.bold,
                            25,
                            AppColor.lightBlackColor,context
                          ),
                        ),
                        space(5),
                        CustomText(
                          "Password is Changed Successfully".tr(),
                          textAlign: TextAlign.center,
                          style: Styles.robotoStyle(
                            FontWeight.w400,
                            19,
                            AppColor.greyColor,context
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: CustomButton(title: "Done".tr()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget space(double height) {
    return SizedBox(
      height: height.h,
    );
  }
}
