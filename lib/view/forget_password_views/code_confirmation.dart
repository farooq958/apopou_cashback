import 'package:cashback/controller/LoginCubit/login_cubit.dart';
import 'package:cashback/controller/product_types_page_index_cubit.dart';
import 'package:cashback/controller/shared_preferences.dart';
import 'package:cashback/view/custom_widgets/custom_button.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:cashback/view/forget_password_views/forget_password.dart';
import 'package:cashback/view/forget_password_views/set_your_password.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:cashback/view/imports.dart';

class CodeConfirmation extends StatefulWidget {
  const CodeConfirmation({Key? key}) : super(key: key);

  @override
  State<CodeConfirmation> createState() => _CodeConfirmationState();
}

class _CodeConfirmationState extends State<CodeConfirmation> {
  ScrollController _scroll = ScrollController();
  FocusNode _focus = new FocusNode();

  @override
  void initState() {
    SharePrefs.activateHomeTabController();
    context.read<ProductTypesPageIndexCubit>().setTabIndex(index: 0);
    super.initState();
    _focus.addListener(() {
      print("running");
    });
  }

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).viewInsets.bottom == 0
        ? _scroll.animateTo(0,
            duration: Duration(milliseconds: 400), curve: Curves.easeIn)
        : _scroll.animateTo(500,
            duration: Duration(milliseconds: 400), curve: Curves.easeIn);

    return WillPopScope(
      onWillPop: () async {
        debugPrint("popping from route 2 disabled");
        return false;
      },
      child: Scaffold(
          backgroundColor: Color(0xffEFEEEE),
          body: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
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
                      height: .6.sh,
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(360.0, 233.5)),
                        color: Color(0xFFFC4F08),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ForgetPasswordScreen()));
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 30.sp,
                        ),
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
                      height: .81.sh,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: Colors.white,
                      ),
                      child: ListView(
                        controller: _scroll,
                        physics: AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.only(
                            left: 20.sp, right: 20.sp, top: 0.1.sh),
                        children: [
                          Image.asset(
                            "images/code_confrim.png",
                            height: 110.sp,
                          ),
                          SizedBox(
                            height: 0.03.sh,
                          ),
                          Center(
                            child: CustomText(
                              'Code Confirmation',
                              style: Styles.robotoStyle(
                                FontWeight.w900,
                                26.0.sp,
                                const Color(0xFF363636),
                                context,


                                height: 1.08,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 0.1.sh,
                          ),
                          SizedBox(
                            height: 20.sp,
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Icon(
                                      Icons.lock_outline_rounded,
                                      color: Color(0xffFC4F08),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: CustomText(
                                      'Confirmation Code'.tr(),
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
                          SizedBox(
                            height: 8.sp,
                          ),
                          Focus(
                            onFocusChange: (x) {
                              print("ali khan");
                            },
                            child: Pinput(
                              focusNode: _focus,
                              focusedPinTheme: PinTheme(
                                width: 56,
                                height: 56,
                                textStyle: GoogleFonts.poppins(
                                  fontSize: 22,
                                  color: Color(0xffFC4F08),
                                ),
                                decoration: BoxDecoration(),
                              ),
                              submittedPinTheme: PinTheme(
                                width: 56,
                                height: 56,
                                textStyle: GoogleFonts.poppins(
                                  fontSize: 22,
                                  color: Color(0xffFC4F08),
                                ),
                                decoration: BoxDecoration(),
                              ),
                              defaultPinTheme: PinTheme(
                                width: 56,
                                height: 56,
                                textStyle: GoogleFonts.poppins(
                                  fontSize: 22,
                                  color: Color.fromRGBO(30, 60, 87, 1),
                                ),
                                decoration: BoxDecoration(),
                              ),
                              pinputAutovalidateMode:
                                  PinputAutovalidateMode.onSubmit,
                              showCursor: true,
                              cursor: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 56,
                                    height: 3,
                                    decoration: BoxDecoration(
                                      color: Color(0xffFC4F08),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ],
                              ),
                              preFilledWidget: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 56,
                                    height: 3,
                                    decoration: BoxDecoration(
                                      color: Color(0xffFC4F08),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ],
                              ),
                              onCompleted: (pin) => print(pin),
                              onSubmitted: (x) {},
                              onTap: () {},
                            ),
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          SizedBox(
                            height: 0.05.sh,
                          ),
                          BlocBuilder<LoginCubit, LoginState>(
                            builder: (context, state) {
                              return InkWell(
                                  onTap: () async {
                                    //  final Connectivity connectivity = Connectivity();
                                    //  ConnectivityResult result= await connectivity.checkConnectivity();
                                    //
                                    //        if(result==ConnectivityResult.mobile || result == ConnectivityResult.wifi){
                                    //          context.read<LoginCubit>().userLogin(
                                    //              context: context,
                                    //              email: email.text,
                                    //              password: password.text);
                                    //        }
                                    //
                                    // else{
                                    //   Snackbar.showSnack(
                                    //       context: context, message: 'No Internet Connection'.tr());
                                    //
                                    // }
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SetYourPassword()));
                                  },
                                  child: state is LoginLoading
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
                                          child: const Center(
                                              child:
                                                  CircularProgressIndicator()),
                                        )
                                      : CustomButton(
                                          title: "SEND CONFIRMATION".tr()));
                            },
                          ),
                          Container(
                            height: 0.33.sh,
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
