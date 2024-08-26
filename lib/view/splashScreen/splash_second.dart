import 'dart:developer';
import 'package:cashback/controller/services/apis.dart';
import 'package:cashback/controller/shared_preferences.dart';
import 'package:cashback/controller/testserver.dart';
import 'package:cashback/view/bottom_navigation_screen.dart';
import 'package:cashback/view/custom_widgets/app_color.dart';
import 'package:cashback/view/custom_widgets/custom_button.dart';
import 'package:cashback/view/auth/login_screen.dart';
import 'package:cashback/view/auth/register_screen.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:cashback/view/splashScreen/splash_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cashback/view/imports.dart';
class SplashSecond extends StatefulWidget {
  const SplashSecond({Key? key}) : super(key: key);

  @override
  State<SplashSecond> createState() => _SplashSecondState();
}

class _SplashSecondState extends State<SplashSecond> {
  String countryId = "";
  @override
  void initState() {
    //getServer();
    getCountryId();
    // NotificationConfig().notificationPayload(context);
    super.initState();
  }

  getCountryId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await SharePrefs.init();
    var id = await prefs.getString("country_id") ?? "";
    var email= await prefs.getString("email");
    var checkServer = id == "1" ? BaseUrl : cyprusBaseUrl;
    //finalServer= email=="test@gmail.com"?testUrl:checkServer;
    finalServer=checkServer;
    setState(() {
      countryId = id;
    });
    log("Country Id $countryId");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffEFEEEE),
        body: ListView(
          children: [
            SizedBox(
              width: 1.sw,
              height: 1.sh,
              child: Stack(
                children: [
                  Positioned(
                    top: -160.sp,
                    left: -60.sp,
                    child: Container(
                      padding: EdgeInsets.only(right: 1.23.sw),
                      width: 720.0,
                      height: 467.0.sp,
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(360.0, 233.5)),
                        color: Color(0xFFFC4F08),
                      ),
                    ),
                  ),

                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0.17.sh,
                    child: Container(
                      margin: EdgeInsets.only(left: 0.05.sw, right: 0.05.sw),
                      width: 341.0.sp,
                      height: 651.0.sp,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: Colors.white,
                      ),
                      child: ListView(
                        children: [
                          Image.asset(
                            "images/register_vector.png",
                            height: .32.sh,
                          ),
                          SizedBox(
                            height: 30.sp,
                          ),
                          CustomText(
                            'Get Cashback\n from 50,000+ Brands'.tr(),
                            style: Styles.robotoStyle(
                              FontWeight.w700,
                              20.0.sp,
                             const Color(0xFF363636),
                              context,
                              height: 1.1,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 15.sp,
                          ),
                          CustomText(
                            'Amazing platforms, Enjoy the Cashbacks\nand enjoy deals on every shopping'
                                .tr(),
                            style: Styles.robotoStyle(
                              FontWeight.w500,
                              16.0.sp,
                              const Color(0xFF363636),
                              context,

                              height: 1.13,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 0.05.sh,
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterScreen()));
                              },
                              child: CustomButton(title: "Register Now".tr())),
                          SizedBox(
                            height: 0.02.sh,
                          ),
                          Center(
                            child: RichText(
                              textScaleFactor: 1.0,
                              text: TextSpan(
                                text: 'Already Member?'.tr(),
                                style: Styles.robotoStyle(
                                  FontWeight.w500,
                                  17.0.sp,
                                  const Color(0xFF363636),
                                  context,

                                  height: 1.06,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' Sign In'.tr(),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginScreen()));
                                      },
                                    style: Styles.robotoStyle(
                                      FontWeight.w900,
                                      16.0.sp,
                                     Colors.black,
                                      context,

                                      letterSpacing: 0.192,
                                  //    fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 0.01.sh,
                          ),
                          Center(
                            child: InkWell(
                              onTap: () async {
                                await SharePrefs.init();
                                SharePrefs.activateHomeTabController();

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BottomNavigationScreen(
                                                guest: true, isPremium: false,)));
                              },
                              child: CustomText(
                                "Περιήγηση ως Επισκέπτης",
                                // "Login as a guest".tr(),
                                style: Styles.robotoStyle(
                                  FontWeight.w900,
                                  17.0.sp,
                                  AppColor.primaryColor,
                                  context,
                                  // fontSize: 17.0.sp,
                                  // color: AppColor.primaryColor,
                                  // fontWeight: FontWeight.w900,
                                  height: 1.06,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  // ? arrow back button
                  Positioned(
                      top: 0.06.sh,
                      left: .04.sw,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SplashScreen()));
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 30.sp,
                            ),
                          ),
                          Container(
                            width: 40.w,
                            height: 26.h,
                            margin: const EdgeInsets.only(left: 5).r,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12).r,
                            ),
                            child: countryId == "1"
                                ? Center(
                                    child: Image.network(
                                    "https://apopou.gr/images/greece.jpg",
                                    width: 25.w,
                                    height: 12,
                                  ))
                                : Center(
                                    child: Image.network(
                                    "https://apopou.gr/images/cyprus.jpg",
                                    width: 25.w,
                                    height: 12,
                                  )),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ],
        ));
  }
}
