import 'dart:developer';
import 'package:cashback/controller/product_types_page_index_cubit.dart';
import 'package:cashback/controller/shared_preferences.dart';
import 'package:cashback/controller/signup_cubit.dart';
import 'package:cashback/view/bottom_navigation_screen.dart';
import 'package:cashback/view/custom_widgets/custom_button.dart';
import 'package:cashback/view/custom_widgets/snack_bar.dart';
import 'package:cashback/view/imports.dart';
import 'package:cashback/view/custom_widgets/text_field.dart';
import 'package:cashback/view/auth/login_screen.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:cashback/view/splashScreen/splash_second.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  String countryId = "";

  getCountryId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = await prefs.getString("country_id") ?? "";
    setState(() {
      countryId = id;
    });
    log("Country Id $countryId");
  }

  @override
  void initState() {
    getCountryId();
    super.initState();
    SharePrefs.activateHomeTabController();
    context.read<ProductTypesPageIndexCubit>().setTabIndex(index: 0);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        debugPrint("popping from route 2 disabled");
        return false;
      },
      child: Scaffold(
          backgroundColor: Color(0xffEFEEEE),
          body: SingleChildScrollView(
            child: SizedBox(
              width: 1.sw,
              height: 1.sh,
              child: Stack(
                children: [
                  Positioned(
                    top: -160.sp,
                    left: -60.sp,
                    child: Container(
                      padding: EdgeInsets.only(right: 1.26.sw),
                      width: 720.0,
                      height: 467.0.sp,
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(360.0, 233.5)),
                        color: Color(0xFFFC4F08),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SplashSecond()));
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
                        padding: EdgeInsets.only(
                            left: 20.sp, right: 20.sp, top: 20.sp),
                        children: [
                          Center(
                            child: CustomText(
                              'Register'.tr(),
                              style: Styles.robotoStyle(
                                FontWeight.w900,
                               32.0.sp,
                          const Color(0xFF363636),
                                context,

                                height: 1.22,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          SizedBox(
                            height: 20.sp,
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Icon(
                                      Icons.person,
                                      color: Color(0xffFC4F08),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: CustomText(
                                      'Full Name'.tr(),
                                      style: GoogleFonts.lato(
                                        fontSize: 14.0.sp,
                                        color: Colors.black,
                                        letterSpacing: 0.168,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          CustomTextField(
                            hintText: "Full Name".tr(),
                            controller: name,
                            obscureText: false,
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          SizedBox(
                            height: 20.sp,
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Icon(
                                      Icons.email_outlined,
                                      color: Color(0xffFC4F08),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: CustomText(
                                      'Email'.tr(),
                                      style: GoogleFonts.lato(
                                        fontSize: 14.0.sp,
                                        color: Colors.black,
                                        letterSpacing: 0.168,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          CustomTextField(
                            hintText: "Email".tr(),
                            controller: email,
                            obscureText: false,
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          SizedBox(
                            height: 20.sp,
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Icon(
                                      Icons.lock_open_outlined,
                                      color: Color(0xffFC4F08),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: CustomText(
                                      'Password',
                                      style: GoogleFonts.lato(
                                        fontSize: 14.0.sp,
                                        color: Colors.black,
                                        letterSpacing: 0.168,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          CustomTextField(
                            hintText: "Password".tr(),
                            controller: password,
                            obscureText: true,
                          ),
                          SizedBox(
                            height: 40.sp,
                          ),
                          SizedBox(
                            height: 20.sp,
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Icon(
                                      Icons.lock_open_outlined,
                                      color: Color(0xffFC4F08),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: CustomText(
                                      'Confirm Password'.tr(),
                                      style: GoogleFonts.lato(
                                        fontSize: 14.0.sp,
                                        color: Colors.black,
                                        letterSpacing: 0.168,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          CustomTextField(
                            hintText: "Confirm Password".tr(),
                            controller: confirmPassword,
                            obscureText: true,
                          ),
                          SizedBox(
                            height: 0.10.sh,
                          ),
                          BlocBuilder<SignupCubit, SignupState>(
                            builder: (context, state) {
                              return InkWell(
                                  onTap: () async {
                                    Pattern pattern =
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                                    RegExp regExp = RegExp(pattern.toString());

                                    final Connectivity connectivity =
                                        Connectivity();
                                    ConnectivityResult result =
                                        await connectivity.checkConnectivity();
                                    if (result == ConnectivityResult.mobile ||
                                        result == ConnectivityResult.wifi) {
                                      if (name.text.isEmpty ||
                                          email.text.isEmpty ||
                                          password.text.isEmpty ||
                                          confirmPassword.text.isEmpty) {
                                        Snackbar.showSnack(
                                            context: context,
                                            message:
                                                "username, email and password cannot be empty"
                                                    .tr());
                                      } else {
                                        if (password.text ==
                                            confirmPassword.text) {
                                          if (password.text.length > 7 ||
                                              confirmPassword.text.length > 7) {
                                            if (email.text.isNotEmpty) {
                                              bool res = await context
                                                  .read<SignupCubit>()
                                                  .signUp(
                                                    name.text,
                                                    email.text,
                                                    password.text,
                                                    // countryId == "1"
                                                    //     ? "83"
                                                    //     : "56",
                                                    // "1", // Referral ID
                                                    context,
                                                  );

                                              if (res == true) {
                                                // Snackbar.showSnack(
                                                //     context: context,
                                                //     message:
                                                //         "Registerd Successfully ..."
                                                //             .tr());

                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            BottomNavigationScreen(
                                                              guest: false, isPremium: false,
                                                            )));
                                              }
                                            } else if (!regExp
                                                .hasMatch(email.text)) {
                                              Snackbar.showSnack(
                                                  context: context,
                                                  message:
                                                      "Please Enter a Valid Email"
                                                          .tr());
                                            }
                                            // else {
                                            //   Snackbar.showSnack(
                                            //       context: context,
                                            //       message:
                                            //           "Please Enter a Valid Email"
                                            //               .tr());
                                            // }
                                          } else {
                                            Snackbar.showSnack(
                                                context: context,
                                                message:
                                                    "Password Length should be greater than 7"
                                                        .tr());
                                          }
                                        } else {
                                          Snackbar.showSnack(
                                              context: context,
                                              message:
                                                  "Password and Confirm Password doesn't match"
                                                      .tr());
                                        }
                                      }
                                    } else {
                                      Snackbar.showSnack(
                                          context: context,
                                          message:
                                              'No Internet Connection'.tr());
                                    }
                                  },
                                  child: state is SignupLoading
                                      ? Container(
                                          margin: EdgeInsets.only(
                                              left: 70.sp, right: 70.sp),
                                          alignment: Alignment(0.0, -0.08),
                                          width: 202.0,
                                          height: 45.0.sp,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(2.0.sp),
                                            color: const Color(0xFFFC4F08),
                                          ),
                                          child: Center(
                                              child:
                                                  CircularProgressIndicator()),
                                        )
                                      : CustomButton(title: "SIGNUP".tr()));
                            },
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          //Social Login//
                          // CustomText(
                          //   'Get Register with'.tr(),
                          //   style: GoogleFonts.roboto(
                          //     fontSize: 14.0.sp,
                          //     color: const Color(0xFF363636),
                          //     fontWeight: FontWeight.w500,
                          //     height: 1.07,
                          //   ),
                          //   textAlign: TextAlign.center,
                          // ),
                          // SizedBox(
                          //   height: 20.sp,
                          // ),
                          // SizedBox(
                          //   height: 40.sp,
                          //   child: Row(
                          //     children: [
                          //       Expanded(
                          //         child: Image.asset("images/google.png"),
                          //       ),
                          //       Expanded(
                          //         child: Image.asset("images/facebook.png"),
                          //       ),
                          //       Expanded(
                          //         child: Image.asset("images/apple.png"),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          SizedBox(
                            height: 20.sp,
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
                                                    LoginScreen()));
                                      },
                                    style: Styles.robotoStyle(
                                        FontWeight.w900,
                                        16.0.sp,
                                        Colors.black,
                                      context,

                                      letterSpacing: 0.192,

                                    ),
                                  )..recognizer
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
