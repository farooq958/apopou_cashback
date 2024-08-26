import 'dart:math';
import 'package:cashback/view/imports.dart';
import 'package:cashback/controller/VivaWallet/wallet_url_cubit.dart';
import 'package:cashback/controller/bottom_navigation_page_index_cubit.dart';
import 'package:cashback/controller/cashback_icons.dart';
import 'package:cashback/controller/services/PushNotification/notification_config.dart';
import 'package:cashback/controller/services/apis.dart';
import 'package:cashback/controller/shared_preferences.dart';
import 'package:cashback/controller/testserver.dart';
import 'package:cashback/view/account.dart';
import 'package:cashback/view/custom_widgets/internet_status_checker.dart';
import 'package:cashback/view/auth/login_screen.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:cashback/view/referAFriend/refer_a_friend.dart';
import 'package:cashback/view/subscribePremium/premiumHome/premium_home_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/services/PushNotification/push_notification_service.dart';
import 'custom_widgets/app_color.dart';
import 'home_screen.dart';
import 'notification/notification_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class BottomNavigationScreen extends StatefulWidget {
  final RemoteMessage? remoteMessage;
  final bool guest;
  final bool isPremium;


  BottomNavigationScreen({required this.guest, this.remoteMessage, required this.isPremium});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  var tok=  SharePrefs.prefs!.getString("token");

  PageController pageController = PageController(initialPage: 0);
  Map _source = {ConnectivityResult.none: false};
  MyConnectivity _connectivity = MyConnectivity.instance;
  bool isConnected = true;
 bool isPremium=false;
  @override
  initState() {
    print("token");
   print(tok);
    setData();
    context.read<BottomNavigationPageIndexCubit>().setPageIndex(index: 0);
   // context.read<WalletUrlCubit>().getWalletUrl();
//    finalServer= email=="test@gmail.com"?testUrl:checkServer;
    initializeNotificationServices();
    NotificationConfig().notificationPayload(context);
    FirebaseMessaging.onMessageOpenedApp.listen((e) async {
      var data = await e.notification!.body;
      print("On Message Opened App $data");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NotificationScreen(guest: false),
        ),
      );
    });

    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() {
        _source = source;
      });
      if (_source.keys.toList()[0] == ConnectivityResult.mobile ||
          _source.keys.toList()[0] == ConnectivityResult.wifi ||
          _source.keys.toList()[0] == ConnectivityResult.ethernet) {
        isConnected = true;
      } else {
        setState(() {
          _source = source;
          isConnected = false;
        });
      }
    });
  }

  initializeNotificationServices() async {
    await PushNotificationServices().initNotification();
    NotificationConfig().messagingInitiation();
    if (widget.remoteMessage != null) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotificationScreen(guest: false),
          ),
        );
      });
    }
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
        body: SizedBox(
          width: 1.sw,
          height: 1.sh,
          child: PageView(
            controller: pageController,
            onPageChanged: (x) {
              if (x == 3 && widget.guest == true) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              } else {
                context
                    .read<BottomNavigationPageIndexCubit>()
                    .setPageIndex(index: x);
              }
            },
            children: [
              isConnected
                  ? HomeScreen(guest: widget.guest)
                  : NoInternetConnection(),
              isConnected
                  ? PremiumHomeScreen(guest: widget.guest, isPremium: widget.isPremium,)
                  : NoInternetConnection(),
              isConnected ? ReferAFriendScreen() : NoInternetConnection(),
              isConnected
                  ? AccountScreen(guest: widget.guest,isPremium:widget.isPremium)
                  : NoInternetConnection(),
            ],
          ),
        ),
        bottomNavigationBar: BlocBuilder<BottomNavigationPageIndexCubit, int>(
          builder: (context, state) {
            return Container(
              width: 375.0,
              height: 84.0.sp,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    offset: const Offset(0, 0),
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        context
                            .read<BottomNavigationPageIndexCubit>()
                            .setPageIndex(index: 0);
                        pageController.jumpToPage(0);
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Icon(
                                Cashback.home,
                                color: state == 0
                                    ? const Color(0xffFC4F08)
                                    : const Color(0xffA7A7A7),
                                size: 23.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.sp,
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: CustomText(
                                  'Home'.tr(),
                                  style: Styles.robotoStyle2(
                                    fontSize: 13.0.sp,
                                    color: state == 0
                                        ? const Color(0xffFC4F08)
                                        : const Color(0xffA7A7A7),
                                    fontWeight: FontWeight.w500, context: context,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  Expanded(
                    child: InkWell(
                      onTap: () {
                        // if (!widget.guest) {
                        context
                            .read<BottomNavigationPageIndexCubit>()
                            .setPageIndex(index: 1);
                        pageController.jumpToPage(1);
                        // } else {
                        //   Navigator.pushReplacement(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => LoginScreen()));
                        // }
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: Align(
                                alignment: Alignment.bottomCenter,
                                child: SvgPicture.asset(
                                  "images/premium_home.svg",
                                  color: state == 1
                                      ? const Color(0xffFC4F08)
                                      : const Color(0xffA7A7A7),
                                  width: 21.w,
                                  height: 21.h,
                                )

                                // Icon(
                                //   Cashback.gift,
                                //   color: state == 1
                                //       ? const Color(0xffFC4F08)
                                //       : const Color(0xffA7A7A7),
                                //   size: 25.sp,
                                // ),
                                ),
                          ),
                          SizedBox(
                            height: 5.sp,
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: CustomText(
                                  'Premium',
                                  style: Styles.robotoStyle2(
                                    fontSize: 13.0.sp,
                                    color: state == 1
                                        ? const Color(0xffFC4F08)
                                        : const Color(0xffA7A7A7),
                                    fontWeight: FontWeight.w500, context: context,
                                  ),
                                  textScaleFactor: 1.0,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  // Expanded(
                  //   child: InkWell(
                  //     onTap: () {
                  //       if (!widget.guest) {
                  //         pageController.jumpToPage(1);
                  //         context
                  //             .read<BottomNavigationPageIndexCubit>()
                  //             .setPageIndex(index: 1);
                  //       }
                  //     },
                  //     child: Column(
                  //       children: [
                  //         // Expanded(
                  //         //   child: Align(
                  //         //     alignment: Alignment.bottomCenter,
                  //         //     child: Icon(
                  //         //       Cashback.bag,
                  //         //       color: state == 1
                  //         //           ? const Color(0xffFC4F08)
                  //         //           : const Color(0xffA7A7A7),
                  //         //       size: 25.sp,
                  //         //     ),
                  //         //   ),
                  //         // ),
                  //         // SizedBox(
                  //         //   height: 5.sp,
                  //         // ),
                  //         // Expanded(
                  //         //   child: Align(
                  //         //     alignment: Alignment.topCenter,
                  //         //     child: FittedBox(
                  //         //       fit: BoxFit.scaleDown,
                  //         //       child: CustomText(
                  //         //         'Products'.tr(),
                  //         //         style: Styles.robotoStyle2(
                  //         //           fontSize: 14.0.sp,
                  //         //           color: state == 1
                  //         //               ? const Color(0xffFC4F08)
                  //         //               : const Color(0xffA7A7A7),
                  //         //           fontWeight: FontWeight.w500,
                  //         //         ),
                  //         //         textAlign: TextAlign.center,
                  //         //       ),
                  //         //     ),
                  //         //   ),
                  //         // )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        if (!widget.guest) {
                          context
                              .read<BottomNavigationPageIndexCubit>()
                              .setPageIndex(index: 2);
                          pageController.jumpToPage(2);
                        } else {
                          // prodcutScrollerController!.dispose();
                          // featuredScrollerController!.dispose();
                          // faouriteScrollerController!.dispose();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        }
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Icon(
                                Cashback.gift,
                                color: state == 2
                                    ? const Color(0xffFC4F08)
                                    : const Color(0xffA7A7A7),
                                size: 23.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.sp,
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: CustomText(
                                  'Refer a Friend'.tr(),
                                  style: Styles.robotoStyle2(
                                    fontSize: 13.0.sp,
                                    color: state == 2
                                        ? const Color(0xffFC4F08)
                                        : const Color(0xffA7A7A7),
                                    fontWeight: FontWeight.w500, context: context,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  // Expanded(
                  //   child: InkWell(
                  //     onTap: () {
                  //       if (!widget.guest) {
                  //         context
                  //             .read<BottomNavigationPageIndexCubit>()
                  //             .setPageIndex(index: 3);
                  //         pageController.jumpToPage(3);
                  //       }
                  //     },
                  //     child: Column(
                  //       children: [
                  //         Expanded(
                  //           child: Align(
                  //             alignment: Alignment.bottomCenter,
                  //             child: Icon(
                  //               Cashback.like,
                  //               color: state == 3
                  //                   ? const Color(0xffFC4F08)
                  //                   : const Color(0xffA7A7A7),
                  //               size: 25.sp,
                  //             ),
                  //           ),
                  //         ),
                  //         SizedBox(
                  //           height: 5.sp,
                  //         ),
                  //         Expanded(
                  //           child: Align(
                  //             alignment: Alignment.topCenter,
                  //             child: FittedBox(
                  //               fit: BoxFit.scaleDown,
                  //               child: CustomText(
                  //                 'Wishlist'.tr(),
                  //                 style: Styles.robotoStyle2(
                  //                   fontSize: 14.0.sp,
                  //                   color: state == 3
                  //                       ? const Color(0xffFC4F08)
                  //                       : const Color(0xffA7A7A7),
                  //                   fontWeight: FontWeight.w500,
                  //                 ),
                  //                 textAlign: TextAlign.center,
                  //               ),
                  //             ),
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        if (!widget.guest) {
                          context
                              .read<BottomNavigationPageIndexCubit>()
                              .setPageIndex(index: 3);
                          pageController.jumpToPage(3);
                        } else {
                          // prodcutScrollerController!.dispose();
                          // featuredScrollerController!.dispose();
                          // faouriteScrollerController!.dispose();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        }
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Icon(
                                Icons.person_outline_outlined,
                                color: state == 3
                                    ? const Color(0xffFC4F08)
                                    : const Color(0xffA7A7A7),
                                size: 23.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.sp,
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: CustomText(
                                  'Account'.tr(),
                                  style: Styles.robotoStyle2(
                                    fontSize: 13.0.sp,
                                    color: state == 3
                                        ? const Color(0xffFC4F08)
                                        : const Color(0xffA7A7A7),
                                    fontWeight: FontWeight.w500, context: context,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    // _connectivity.disposeStream();
    super.dispose();
  }

  Future<void> setData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await SharePrefs.init();
    var id = await prefs.getString("country_id") ?? "";
    var email= await prefs.getString("email")??"";
    var checkServer = id == "1" ? BaseUrl : cyprusBaseUrl;
    //finalServer= email=="test@gmail.com"?testUrl:checkServer;
    finalServer=checkServer;
    print("chec"+finalServer);
    setState(() {

    });
    context.read<WalletUrlCubit>().getWalletUrl();

  }
}

class NoInternetConnection extends StatelessWidget {
  const NoInternetConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "images/no_internet.png",
          width: 120.w,
          height: 160.h,
        ),
        CustomText(
          "No Internet Connection",
          style: Styles.robotoStyle2(
            fontSize: 18.0.sp,
            color: AppColor.primaryColor,
            fontWeight: FontWeight.w800, context: context,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
