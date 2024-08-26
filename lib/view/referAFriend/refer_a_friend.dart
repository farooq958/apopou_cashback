import 'dart:async';
import 'package:cashback/controller/services/setting_service.dart';
import 'package:cashback/controller/services/user_referral_service.dart';
import 'package:cashback/controller/services/user_service.dart';
import 'package:cashback/controller/shared_preferences.dart';
import 'package:cashback/model/user_model.dart';
import 'package:cashback/view/custom_widgets/app_color.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:cashback/view/custom_widgets/custom_button.dart';
import 'package:cashback/view/referAFriend/my_referrals.dart';
import 'package:cashback/view/web_view/web_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:cashback/view/imports.dart';

class ReferAFriendScreen extends StatefulWidget {
  const ReferAFriendScreen({super.key});

  @override
  State<ReferAFriendScreen> createState() => _ReferAFriendScreenState();
}

class _ReferAFriendScreenState extends State<ReferAFriendScreen> {
  String currency = "";
  List<dynamic> referList = [];
  bool isShare = false;

  @override
  void initState() {
    currencyGet();
    getReferValue();
    super.initState();
  }

  Future currencyGet() async {
   await CurrencyPrefs.setCurrency();
    var c = await CurrencyPrefs.getCurrency();
    setState(() {
      currency = c;
    });
  }

  Future getReferValue() async {
    var data = await SettingService.getReferAFriend();
    setState(() {
      referList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColor.secondaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            upperBody(height),
            SizedBox(height: 40.h),
            referList.isNotEmpty
                ? lowerBody()
                : Padding(
                    padding: const EdgeInsets.only(top: 100).r,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColor.primaryColor,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget upperBody(double height) {
    return Container(
      height: height * 0.4,
      width: double.infinity,
      color: AppColor.primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 55, left: 15).r,
            child: Align(
              alignment: Alignment.centerLeft,
              child: CustomText(
                "Refer a Friend".tr(),
                style: Styles.robotoStyle(
                  FontWeight.bold,
                  26,
                  AppColor.whiteColor,context
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              "images/referFriend.png",
            ),
          ),
        ],
      ),
    );
  }

  Widget myReferralButton() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MyReferralsScreen()));
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: EdgeInsets.only(left: 70.sp, right: 70.sp),
        width: 202.0,
        height: 45.0.sp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5).r,
          border: Border.all(
            color: AppColor.primaryColor,
            width: 3.w,
          ),
        ),
        child: Center(
          child: CustomText(
            "My Referral".tr(),
            style: Styles.robotoStyle(
              FontWeight.w900,
              14.0.sp,
              AppColor.primaryColor,
              context

            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget lowerBody() {
    return Column(
      children: [
        CustomText(
          'Invite your friends and get bonus points!'.tr(),
          textAlign: TextAlign.center,
          style: Styles.robotoStyle(
            FontWeight.bold,
            21,
            AppColor.lightBlackColor,context
          ),
        ),
        SizedBox(height: 20.h),

        ///todo working
        RichText(
          textScaleFactor: 1.0,
          textAlign: TextAlign.center,
          text: TextSpan(
            text: "Earn".tr(),
            style: Styles.robotoStyle(
              FontWeight.w500,
              16,
              AppColor.lightBlackColor,context
            ),
            children: [
              TextSpan(
                text:
                    " $currency ${referList.isEmpty ? "" : referList[0]['setting_value']} ",
                style: Styles.robotoStyle(
                  FontWeight.w900,
                  16,
                  AppColor.primaryColor,context
                ),
              ),
              TextSpan(text: "for every friend you refer to Apopou!".tr()),
            ],
          ),
        ),
        SizedBox(height: 50.h),
        GestureDetector(
            onTap: () async {
              setState(() => isShare = true);
              Map<String, dynamic>? referrals =
                  await UserReferralService().getInviteReferralCode();
              if (referrals!.isNotEmpty) {
                String url = referrals['data'].first['setting_value'];

                UserModel user = await UserService().getUserData();
                if (user.identifier != null) {
                  print(user.identifier);
                  if (isShare) await Share.share("$url${user.identifier}");
                  setState(() => isShare = false);
                  Timer(const Duration(seconds: 10), () {
                    setState(() => isShare = true);
                  });
                }
              }
            },
            behavior: HitTestBehavior.opaque,
            child: CustomButton(title: "Invite Friends".tr())),
        SizedBox(height: 20.h),
        myReferralButton(),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InAppWebView(
                          url: referList[1]['setting_value'].toString(),
                        )));
          },
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18).r,
            child: CustomText(
              "Read the Terms & Conditions here".tr(),
              style: Styles.robotoStyle(
                FontWeight.w400,
                12.sp,
                Colors.black,context
              ),
            ),
          ),
        ),
      ],
    );
  }
}
