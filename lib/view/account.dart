// ignore_for_file: must_be_immutable
import 'dart:developer';

import 'package:cashback/controller/VivaWallet/loadingweb_cubit.dart';
import 'package:cashback/controller/VivaWallet/unsubscribe_premium_cubit.dart';
import 'package:cashback/controller/VivaWallet/wallet_url_cubit.dart';
import 'package:cashback/controller/login_controller.dart';
import 'package:cashback/controller/premiumControllers/PremiumUser/premium_user_cubit.dart';
import 'package:cashback/controller/retailers_search_cubit/retailers_search_cubit.dart';
import 'package:cashback/controller/services/dialog_show_cubit.dart';
import 'package:cashback/controller/services/premiun_service_api.dart';
import 'package:cashback/controller/shared_preferences.dart';
import 'package:cashback/controller/balanceCubit/balance_cubit.dart';
import 'package:cashback/controller/services/help_service.dart';
import 'package:cashback/controller/user/cubit/user_cubit.dart';
import 'package:cashback/view/clickHistory/history_screen.dart';
import 'package:cashback/view/custom_widgets/app_color.dart';
import 'package:cashback/view/balance/my_balance_screen.dart';
import 'package:cashback/view/custom_widgets/dialogue.dart';
import 'package:cashback/view/editProfile/edit_profile.dart';
import 'package:cashback/view/subscribePremium/components/diologboxpremium.dart';
import 'package:cashback/view/subscribePremium/subscribe_premium.dart';
import 'package:cashback/view/subscribePremium/subscribe_successful_screen.dart';
import 'package:cashback/view/subscribePremium/un_subscribe_screen.dart';
import 'package:cashback/view/web_view/Controller/web_view_controler.dart';
import 'package:cashback/view/withdraw/withdraw_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_validator/string_validator.dart';
import '../controller/SubscriptionAmount/subscription_amount_cubit.dart';
import '../controller/all_favourite_controller.dart';
import '../controller/all_featured_controller.dart';
import '../controller/all_products_controller.dart';
import '../controller/categories_controller.dart';
import '../controller/logout_cubit.dart';
import '../model/categories_model.dart';
import '../model/login_model.dart';
import 'auth/login_screen.dart';
import 'custom_widgets/snack_bar.dart';
import 'custom_widgets/text_style.dart';
import 'web_view/web_view.dart';
import 'package:cashback/view/imports.dart';
class AccountScreen extends StatefulWidget {
  bool guest;
  bool isPremium;
  AccountScreen({required this.guest, required this.isPremium});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String server = "";
  String helpUrl = "";
  String currency = "";
 String premiumCheck='';
  @override
  void initState() {
    //context.read<WalletUrlCubit>().getWalletUrl();
    context.read<PremiumUserCubit>().getPremiumUserData();
    //getServer();
    currencyGet();
    getHelp();
    premiumCheckIt();
    Future.wait([
      context.read<UserCubit>().getUser(),

      context.read<BalanceCubit>().getBalance(),
    ]);

    super.initState();
  }

  Future currencyGet() async {
    var c = await CurrencyPrefs.getCurrency();
    setState(() {
      currency = c;
    });
  }

  Future premiumCheckIt() async {
    var c = await PremiumCheck.getPremiumCheck();
    setState(() {
      premiumCheck = c;
    });
  }
  Future getHelp() async {
    var url = await HelpService.getHelpUrl();
    setState(() {
      helpUrl = url;
    });
    log("URL $url");
  }

  Future getServer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var country = await prefs.getString("country_id") ?? "1";
    var checkServer = country == "1"
        ? "https://apopou.gr/help"
        : "https://apopou.com.cy/help";

    setState(() {
      server = checkServer;
      log("Server $server");
    });
  }
  //bool isPremium=false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 1.sh,
      child: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          log("User Status ${state.status}");
          if (state.status == UserStatus.error &&
              state.model.fullName == null) {
            showLoaderDialog(
              context,
              onCancelTap: () {},
              onTap: () async {
                var res = await context
                    .read<LogoutCubit>()
                    .logout(context: context, guest: true);
                log("res $res");
                if (res == true) {
                  AllProductsController.listData = [];
                  AllFavouriteController.listData = [];
                  AllFeatureController.listData = [];
                  CategoriesController.data = CategoriesModel(
                    meta: Meta(
                      pagination: Pagination(
                        currentPage: 0,
                        perPage: 0,
                        count: 0,
                        total: 0,
                        totalPages: 0,
                        links: Links(),
                      ),
                    ),
                    data: [],
                  );
                  LoginController.data = LoginModel(
                      tokenType: '',
                      data: Data(
                        userId: 0,
                        username: '',
                        email: '',
                        fname: '',
                        lname: '',
                        gender: '',
                        address: '',
                        address2: '',
                        city: '',
                        state: '',
                        zip: '',
                        country: 0,
                        phone: '',
                        paymentMethod: '',
                        regSource: '',
                        refClicks: 0,
                        refId: 0,
                        refBonus: 0,
                        newsletter: 0,
                        ip: '',
                        status: '',
                        authProvider: '',
                        authUid: '',
                        unsubscribeKey: '',
                        loginSession: '',
                        lastLogin: '',
                        loginCount: 0,
                        lastIp: '',
                        created: DateTime.now(),
                        blockReason: '',
                        validated: 0,
                        sha1: 0,
                        providerName: '',
                        providerId: '',
                        deletedAt: '',
                      ),
                      accessToken: '');
                  RetailerSearchController.data.data = [];
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  var country = await prefs.getString("country_id") ?? "";
                  await prefs.remove("token");
                  await prefs.remove("uid");
                  await prefs.remove("initial");
                  log("Country pref $country");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                } else {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }
                // prodcutScrollerController!.dispose();
                // featuredScrollerController!.dispose();
                // faouriteScrollerController!.dispose();
              },
            );
          }
        },
        builder: (context, state) {
          if (state.status == UserStatus.loading) {
            return Center(
                child: CircularProgressIndicator(color: AppColor.primaryColor));
          }
          return ListView(
            shrinkWrap: true,
           physics: BouncingScrollPhysics(),
           // physics: NeverScrollableScrollPhysics(),
          //  physics: NeverScrollableScrollPhysics(),
            children: [
              Container(
                padding: EdgeInsets.only(left: 15.sp, right: 15.sp),
                width: 383.0.sp,
                height: 0.27.sh,
                color: const Color(0xFFFC4F08),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30.sp,
                    ),
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: 93.0.sp,
                          height: 93.0.sp,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('images/user_profile.png'),
                              //AssetImage('images/man.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            state.model.firstName.toString(),
                            textScaleFactor: 1.0,
                            style: Styles.robotoStyle2(
                              fontSize: 20.0.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w900, context: context,
                            ),
                          ),

                          BlocListener<PremiumUserCubit, PremiumUserState>(
                            listener: (context, state) {
                              print("object3");
                              if(state is PremiumUserSuccess) {
                             //   print("tesss" + walletUrlController.data);
//                                 if(isURL(state.walletUrlController.data))
//                                 {
//
// setState(() {
//   isPremium=false;
//   print("heree1");
// });
//                                 }
//                                 else{
//
//                                   setState(() {
//                                     print("heree2");
//                                     isPremium=true;
//                                   });
//                                 }
// setState(() {
//
// });
                              }


                              // TODO: implement listener
                            },
                            child:BlocBuilder<PremiumUserCubit, PremiumUserState>(
                              builder: (context, state) {


                                if(state is PremiumUserSuccess) {
                                  print(state.premiumData.isActive.toString()+"active state");

                                  // print("tesss"+state.data);
                                  return state.premiumData.isActive == 0 || state.premiumData.isActive == 2?

                                  SizedBox() :
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(left: 12, bottom: 3)
                                        .r,
                                    child: SvgPicture.asset(
                                      "images/premium_icon.svg",color: premiumCheck=='1'?Colors.white:Colors.grey,),
                                  );
                                }
                                else
                                {
                                  return SizedBox();
                                }


                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: CustomText(
                            'Καλοσώρισες!',
                            style: Styles.robotoStyle2(
                              fontSize: 14.0.sp,
                              color: Colors.white, context: context,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: 145.0,
                          height: 33.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.0),
                            color: const Color(0xFF363636).withOpacity(0.39),
                          ),
                          child: BlocBuilder<BalanceCubit, BalanceState>(
                            builder: (context, state) {
                              if (state.status == BalanceStatus.loading) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: AppColor.primaryColor,
                                  ),
                                );
                              }
                              return Center(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: CustomText(
                                    "$currency ${state.model.totalBalance}",
                                    style: Styles.robotoStyle2(
                                      fontSize: 19.0.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900, context: context,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 50.sp),
              GridView.count(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
               childAspectRatio: MediaQuery.of(context)
                   .size
                   .width /
                   (MediaQuery.of(context).size.height / 5.5),
               // scrollDirection: Axis.horizontal,

              //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 5)
              //
              // ,
                crossAxisCount: 2,
                //crossAxisSpacing: 2,
                mainAxisSpacing: 20,
                children: [
                  InkWell(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyBalanceScreen())),
                    child: Container(
                      padding: EdgeInsets.only(left: 15.sp, right: 15.sp),
                      margin: EdgeInsets.only(left: 10.sp, right: 10.sp),
                      alignment: Alignment(-0.62, -0.05),
                     // width: 341.0,
                      height: 20.0.sp,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                      ),

                      //row
                      child: Column(
                        children: [
                          Expanded(
                            child: Align(

                                alignment: Alignment.centerLeft,
                                child: Image.asset(
                                  "images/coins.png",
                                  width: 30.sp,
                                )),
                          ),
                          Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(
                                  'My Balance'.tr(),
                                  style: Styles.robotoStyle2(
                                    fontSize: 16.0,
                                    color: const Color(0xFF363636),
                                    fontWeight: FontWeight.w500,
                                    height: 0.88, context: context,
                                  ),
                                ),
                              )),
                          // Expanded(
                          //   child: Align(
                          //     alignment: Alignment.centerRight,
                          //     child: Icon(
                          //       Icons.arrow_forward_ios,
                          //       size: 20.sp,
                          //       color: Colors.black,
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                  //SizedBox(height: 8.sp),
                  /// Become premium member button
                  BlocListener<DialogShowCubit, bool>(
                    listener: (context, sState) {
                      // TODO: implement listener
                      if(sState == true)
                      {
                        AppDialog.dialog(context, SubscribeSuccessfulScreen());
                      }

                    },
                    child: BlocBuilder<UnsubscribePremiumCubit, UnsubscribePremiumState>(
                      builder: (context, usState) {
                        return BlocListener<UnsubscribePremiumCubit, UnsubscribePremiumState>(
                          listener: (context, unState) {
                            // TODO: implement listener
                            if(unState is UnsubscribePremiumLoaded)
                            {
                              context.read<PremiumUserCubit>().getPremiumUserData();
                              AppDialog.dialog(context, UnSubscribeScreen());
                              //  Future.delayed(duration)

                            //  context.read<WalletUrlCubit>().getWalletUrl();
                            }
                          },
                          child: BlocConsumer<PremiumUserCubit, PremiumUserState>(
                            listener: (context, state) {
                              // TODO: implement listener
                            },
                            builder: (context, pState) {
                              bool isPremium=false;
                              if(pState is PremiumUserSuccess)
                              {
                                if( pState.premiumData.isActive == 0 || pState.premiumData.isActive ==2)
                                {
                                  isPremium=false;
                                }
                                else
                                {
                                  isPremium=true;
                                }

                              }
                              return InkWell(
                                onTap: () {
                                  if(premiumCheck == '1') {
                                    if (isPremium == false) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SubscribePremiumScreen()));
                                      context.read<SubscriptionAmountCubit>()
                                          .getSubscriptionAmountData();
                                    }
                                    else {
                                      showDialog(context: context,
                                          builder: (context) => PremiumDialogBox());
                                    }
                                  }
                                  else
                                  {
                                    Snackbar.showSnack(
                                        context: context,
                                        message:
                                        "Η υπηρεσία Premium δεν είναι διαθέσιμη προς το παρόν.");
                                  }
                                },
                                child: Opacity(
                                  opacity: premiumCheck=='1'? 1:0.5,
                                  child: Container(
                                    padding: EdgeInsets.only(left: 15.sp, right: 15.sp),
                                    margin: EdgeInsets.only(left: 10.sp, right: 10.sp),
                                    alignment: Alignment(-0.62, -0.05),
                                  //  width: 341.0,
                                    height: 20.0.sp,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: SvgPicture.asset(
                                                isPremium==false? "images/premium_home.svg":'images/unsubscribeIcon.svg',
                                                width: 30.sp,
                                                color: isPremium==false? AppColor.primaryColor:null,
                                              )),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: CustomText(
                                                isPremium==false? "Become Premium Member".tr():"Απεγγραφή Premium",
                                                style: Styles.robotoStyle2(
                                                  fontSize: 16.0,
                                                  color: const Color(0xFF363636),
                                                  fontWeight: FontWeight.w500,
                                                  height: 0.88, context: context,
                                                ),
                                              ),
                                            )),
                                        // Expanded(
                                        //   child: Align(
                                        //     alignment: Alignment.centerRight,
                                        //     child: Icon(
                                        //       Icons.arrow_forward_ios,
                                        //       size: 20.sp,
                                        //       color: Colors.black,
                                        //     ),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                //  SizedBox(height: 8.sp),
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AllHistoryScreen())),
                    child: Container(
                      padding: EdgeInsets.only(left: 15.sp, right: 15.sp),
                      margin: EdgeInsets.only(left: 10.sp, right: 10.sp),
                      alignment: const Alignment(-0.62, -0.05),
                     // width: 341.0,
                      height: 20.0.sp,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 5.sp,),
                          Expanded(
                            flex: 2,
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Image.asset(
                                  "images/history.png",
                               //   height: 50,
                                  width: 30.sp,
                                )),
                          ),
                          Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(
                                  'History'.tr(),
                                  style: Styles.robotoStyle2(
                                    fontSize: 16.0,
                                    color: const Color(0xFF363636),
                                    fontWeight: FontWeight.w500,
                                    height: 0.88, context: context,
                                  ),
                                ),
                              )),
                          // Expanded(
                          //   child: Align(
                          //     alignment: Alignment.centerRight,
                          //     child: Icon(
                          //       Icons.arrow_forward_ios,
                          //       size: 20.sp,
                          //       color: Colors.black,
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
               //   SizedBox(height: 8.sp),
                  InkWell(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => WithDrawScreen())),
                    child: Container(
                      padding: EdgeInsets.only(left: 15.sp, right: 15.sp),
                      margin: EdgeInsets.only(left: 10.sp, right: 10.sp),
                      alignment: Alignment(-0.62, -0.05),
                      //width: 341.0,
                      height: 20.0.sp,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 5.sp,),
                          Expanded(
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Image.asset(
                                  "images/withdraw.png",
                                  width: 30.sp,
                                )),
                          ),
                          Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(
                                  'Withdrawal'.tr(),
                                  style: Styles.robotoStyle2(
                                    fontSize: 14.0,
                                    color: const Color(0xFF363636),
                                    fontWeight: FontWeight.w500,
                                    height: 0.88, context: context,
                                  ),
                                ),
                              )),
                          // Expanded(
                          //   child: Align(
                          //     alignment: Alignment.centerRight,
                          //     child: Icon(
                          //       Icons.arrow_forward_ios,
                          //       size: 20.sp,
                          //       color: Colors.black,
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                 // SizedBox(height: 8.sp),
                  InkWell(
                    onTap: () {
                      WebViewNotifier.loading.value=true;
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InAppWebView(
                                  url: "https://forms.apopou.gr/app/form?id=10",
                                )));

                      });



                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 15.sp, right: 15.sp),
                      margin: EdgeInsets.only(left: 10.sp, right: 10.sp),
                      alignment: Alignment(-0.62, -0.05),
                    //  width: 341.0,
                      height: 20.0.sp,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 5.sp,),
                          Expanded(
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Image.asset(
                                  "images/list.png",
                                  width: 30.sp,
                                )),
                          ),
                          Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(
                                  'Transaction not Recorded'.tr(),
                                  style: Styles.robotoStyle2(
                                    fontSize: 14.0,
                                    color: const Color(0xFF363636),
                                    fontWeight: FontWeight.w500,
                                    height: 0.88, context: context,
                                  ),
                                ),
                              )),
                          // Expanded(
                          //   child: Align(
                          //     alignment: Alignment.centerRight,
                          //     child: Icon(
                          //       Icons.arrow_forward_ios,
                          //       size: 20.sp,
                          //       color: Colors.black,
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                  //SizedBox(height: 8.sp),
                  BlocBuilder<UserCubit, UserState>(
                    builder: (context, state) {
                      return InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfileScreen(
                                  model: state.model,
                                ))),
                        child: Container(
                          padding: EdgeInsets.only(left: 15.sp, right: 15.sp),
                          margin: EdgeInsets.only(left: 10.sp, right: 10.sp),
                          alignment: Alignment(-0.62, -0.05),
                         // width: 341.0,
                         // height: 59.0.sp,
                          height: 20.0.sp,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 5.sp,),
                              Expanded(
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Image.asset(
                                      "images/user.png",
                                      width: 30.sp,
                                    )),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: CustomText(
                                      'Edit Profile'.tr(),
                                      style: Styles.robotoStyle2(
                                        fontSize: 16.0,
                                        color: const Color(0xFF363636),
                                        fontWeight: FontWeight.w500,
                                        height: 0.88, context: context,
                                      ),
                                    ),
                                  )),
                              // Expanded(
                              //   child: Align(
                              //     alignment: Alignment.centerRight,
                              //     child: Icon(
                              //       Icons.arrow_forward_ios,
                              //       size: 20.sp,
                              //       color: Colors.black,
                              //     ),
                              //   ),
                              // )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                 // SizedBox(height: 8.sp),
                  InkWell(
                    onTap: () async {
                      WebViewNotifier.loading.value=true;
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InAppWebView(
                                  url: helpUrl,
                                  // "https://apopou.gr/help",
                                  //"https://apopou.com.cy/help",
                                )));
                      });
                      //   await Future.delayed(Duration.zero);

                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 15.sp, right: 15.sp),
                      margin: EdgeInsets.only(left: 10.sp, right: 10.sp),
                      alignment: Alignment(-0.62, -0.05),
                    //  width: 341.0,
                      //height: 59.0.sp,
                      height: 20.0.sp,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 5.sp,),
                          Expanded(
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Image.asset(
                                  "images/information.png",
                                  width: 30.sp,
                                )),
                          ),
                          Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(
                                  'Help'.tr(),
                                  style: Styles.robotoStyle2(
                                    fontSize: 16.0,
                                    color: const Color(0xFF363636),
                                    fontWeight: FontWeight.w500,
                                    height: 0.88, context: context,
                                  ),
                                ),
                              )),
                          // Expanded(
                          //   child: Align(
                          //     alignment: Alignment.centerRight,
                          //     child: Icon(
                          //       Icons.arrow_forward_ios,
                          //       size: 20.sp,
                          //       color: Colors.black,
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                 // SizedBox(height: 8.sp),
                  Container(
                    padding: EdgeInsets.only(left: 15.sp, right: 15.sp),
                    margin: EdgeInsets.only(left: 10.sp, right: 10.sp),
                    alignment: const Alignment(-0.62, -0.05),
                    //width: 341.0,
                  //  height: 59.0.sp,
                  //  height: 100.0.sp,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.white,
                    ),
                    child: InkWell(
                      onTap: () async {
                        showLoaderDialog(
                          context,
                          onCancelTap: () {
                            Navigator.pop(context);
                          },
                          onTap: () async {
                            var res = await context
                                .read<LogoutCubit>()
                                .logout(context: context, guest: true);
                            log("res $res");
                            if (res == true) {
                              AllProductsController.listData = [];
                              AllFavouriteController.listData = [];
                              AllFeatureController.listData = [];
                              CategoriesController.data = CategoriesModel(
                                meta: Meta(
                                  pagination: Pagination(
                                    currentPage: 0,
                                    perPage: 0,
                                    count: 0,
                                    total: 0,
                                    totalPages: 0,
                                    links: Links(),
                                  ),
                                ),
                                data: [],
                              );
                              LoginController.data = LoginModel(
                                  tokenType: '',
                                  data: Data(
                                    userId: 0,
                                    username: '',
                                    email: '',
                                    fname: '',
                                    lname: '',
                                    gender: '',
                                    address: '',
                                    address2: '',
                                    city: '',
                                    state: '',
                                    zip: '',
                                    country: 0,
                                    phone: '',
                                    paymentMethod: '',
                                    regSource: '',
                                    refClicks: 0,
                                    refId: 0,
                                    refBonus: 0,
                                    newsletter: 0,
                                    ip: '',
                                    status: '',
                                    authProvider: '',
                                    authUid: '',
                                    unsubscribeKey: '',
                                    loginSession: '',
                                    lastLogin: '',
                                    loginCount: 0,
                                    lastIp: '',
                                    created: DateTime.now(),
                                    blockReason: '',
                                    validated: 0,
                                    sha1: 0,
                                    providerName: '',
                                    providerId: '',
                                    deletedAt: '',
                                  ),
                                  accessToken: '');
                              RetailerSearchController.data.data = [];
                              SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                              var country =
                                  await prefs.getString("country_id") ?? "";
                              await prefs.remove("token");
                              await prefs.remove("uid");
                              await prefs.remove("initial");
                              await prefs.remove("email");
                              log("Country pref $country");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            }
                            // prodcutScrollerController!.dispose();
                            // featuredScrollerController!.dispose();
                            // faouriteScrollerController!.dispose();
                          },
                        );

                        log("OSHO G");
                      },
                      child: Column(
                        children: [
                          SizedBox(height: 5.sp,),
                          Expanded(
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Image.asset(
                                  "images/logout.png",
                                  width: 25.sp,
                                )),
                          ),
                          Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(
                                  'Logout'.tr(),
                                  style: Styles.robotoStyle2(
                                    fontSize: 16.0,
                                    color: const Color(0xFF363636),
                                    fontWeight: FontWeight.w500,
                                    height: 0.88, context: context,
                                  ),
                                ),
                              )),
                          // Expanded(
                          //   child: Align(
                          //     alignment: Alignment.centerRight,
                          //     child: Icon(
                          //       Icons.arrow_forward_ios,
                          //       size: 20.sp,
                          //       color: Colors.black,
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),

                ],
              ),

            ],
          );
        },
      ),
    );
  }
}
