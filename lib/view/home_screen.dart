import 'package:cashback/controller/premiumControllers/PremiumUser/premium_user_cubit.dart';
import 'package:cashback/controller/services/premiun_service_api.dart';
import 'package:cashback/controller/testserver.dart';
import 'package:cashback/view/custom_widgets/app_color.dart';
import 'package:cashback/view/imports.dart';
import 'dart:developer';
import 'package:cashback/controller/AppConstants.dart';
import 'package:cashback/controller/VivaWallet/wallet_url_cubit.dart';
import 'package:cashback/controller/cashback_icons.dart';
import 'package:cashback/controller/internetChecker/internet_checker_bloc.dart';
import 'package:cashback/controller/parent_categories_controller.dart';
import 'package:cashback/controller/product_types_page_index_cubit.dart';
import 'package:cashback/controller/services/currency_service.dart';
import 'package:cashback/controller/shared_preferences.dart';
import 'package:cashback/view/all_featured_products.dart';
import 'package:cashback/view/all_products.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:cashback/view/store_categories/categories_expandable_screen.dart';
import 'package:cashback/view/favourite_products.dart';
import 'package:cashback/view/auth/login_screen.dart';
import 'package:cashback/view/notification/notification_screen.dart';
import 'package:cashback/view/homeSearch/search_click_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_validator/string_validator.dart';
import '../controller/listHeightCubit.dart';
import '../controller/parent_categories_cubit.dart';
import '../controller/services/apis.dart';
import 'market_place/marketplace.dart';





class HomeScreen extends StatefulWidget {
  bool guest;
  HomeScreen({required this.guest});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> assetsArray = [
    "images/marketplace.png",
    "images/electronics.png",
    "images/home.png",
    "images/home.png",
  ];
  List<String> categories = [
    "Marketplaces",
    "Electronics",
    "Home Appliances",
    "Electronics",
  ];
  String countryId = "";
  String premiumCheck='';
  getCountryId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await SharePrefs.init();
    var id = await prefs.getString("country_id") ?? "";
    setState(() {
      countryId = id;
    });
    log("Country Id $countryId");
  }

  @override
  void initState() {
    getCountryId();
    premiumCheckIt();
    context.read<WalletUrlCubit>().getWalletUrl();
    context.read<PremiumUserCubit>().getPremiumUserData();

    //context.read<UserCubit>().getUser();
    Future.wait([
      CurrencyPrefs.setCurrency(),
      // CurrencyService.getCurrency(),
    ]);
    super.initState();
    SharePrefs.activateHomeTabController();
    context.read<ProductTypesPageIndexCubit>().setTabIndex(index: 0);
    context.read<ParentCategoriesCubit>().parentCategories();

    // context.read<InternetCheckerBloc>().add(InternetAvailableEvent());
  }
  Future premiumCheckIt() async {
    var c = await PremiumCheck.getPremiumCheck();
    setState(() {
      premiumCheck = c;
    });
  }
  @override
  Widget build(BuildContext context) {
  //  var test = context.watch<ListHeightCubit>().state;
    return SizedBox(
      width: 1.sw,
      height: 1.sh,
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 30.sp,
            ),
            Container(
              padding: AppConstants.screenPadding,
              height: 60.sp,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Image.asset("images/logo_orange.png"),
                  ),

                  Expanded(
                    child: Container(
                      width: 38.w,
                      height: 22.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10).r,
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
                  ),
                  BlocBuilder<PremiumUserCubit, PremiumUserState>(
                    builder: (context, state) {


                      if(state is PremiumUserSuccess) {

                        // print("tesss"+state.data);
                        return state.premiumData.isActive == 0 || state.premiumData.isActive == 2?

                        SizedBox() :
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 12, bottom: 3)
                              .r,
                          child: SvgPicture.asset(
                            "images/premium_icon.svg",color: premiumCheck=='1'?null:Colors.grey,),
                        );
                      }
                      else
                      {
                        return SizedBox();
                      }


                    },
                  ),

                  //Flag//
                  // BlocBuilder<UserCubit, UserState>(
                  //   builder: (context, state) {
                  //     var countryId = state.model.country;
                  //     log("Country Id Home $countryId");
                  //     if (state.status == UserStatus.loading) {
                  //       return Expanded(
                  //         child: Container(
                  //           width: 38.w,
                  //           height: 22.h,
                  //           decoration: BoxDecoration(
                  //             color: Colors.white,
                  //             borderRadius: BorderRadius.circular(10).r,
                  //           ),
                  //         ),
                  //       );
                  //     }
                  //     return Expanded(
                  //       child: Container(
                  //         width: 38.w,
                  //         height: 22.h,
                  //         decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           borderRadius: BorderRadius.circular(10).r,
                  //         ),
                  //         child: countryId == "1"
                  //             ? Center(
                  //                 child: Image.network(
                  //                 "https://apopou.gr/images/greece.jpg",
                  //                 width: 25.w,
                  //                 height: 12,
                  //               ))
                  //             : Center(
                  //                 child: Image.network(
                  //                 "https://apopou.gr/images/cyprus.jpg",
                  //                 width: 25.w,
                  //                 height: 12,
                  //               )),
                  //       ),
                  //     );
                  //   },
                  // ),
                  const Spacer(
                    flex: 4,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => NotificationScreen(
                                        guest: widget.guest,
                                      )));
                        },
                        child: Container(
                          width: 40.0.sp,
                          height: 40.0.sp,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(
                            Icons.notifications_none,
                            color: AppConstants.appDarkColor,
                            size: 25.sp,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: AppConstants.screenPadding,
              height: 50.sp,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchClickScreen(
                                      guest: widget.guest,
                                    )));
                      },
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0.sp),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30.0.sp),
                            ),
                            filled: true,
                            hintStyle: Styles.robotoStyle2(color: Colors.grey[800], context: context),
                            hintText: "Type in your text".tr(),
                            fillColor: Colors.white70),
                      ),
                    ),
                  ),

                  Expanded(
                      child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CategoriesExpanable(guest: widget.guest)));
                    },
                    child: Column(
                      children: [
                        const Expanded(
                          child: Icon(
                            Cashback.category,
                            color: Colors.black,
                          ),
                        ),
                        Expanded(
                          child: CustomText(
                            'Categories'.tr(),
                            style: Styles.robotoStyle2(
                              fontSize: 14.0.sp,
                              color: const Color(0xFF363636),
                              fontWeight: FontWeight.w900, context: context,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        )
                      ],
                    ),
                  )),
                ],
              ),
            ),
            SizedBox(
              height: 20.sp,
            ),
            BlocBuilder<ListHeightCubit, bool>(
  builder: (context, test) {
    return AnimatedContainer(
              duration: Duration(milliseconds: 500),
              height: test != true ? 0.sp : 95.sp,
              child:
                  BlocBuilder<ParentCategoriesCubit, ParentCategoriesState>(
                builder: (context, state) {
                  return state is ParentCategoriesLoading
                      ? Container(
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : ListView.builder(
                   // shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              ParentCategoriesController.data.data.length,
                          itemBuilder: (context, index) {
                            var marketName = ParentCategoriesController
                                .data.data[index].categoryTitle;
                            return InkWell(
                              onTap: () {
                                log("HOME SCREEN CATEGORY ICON ${ParentCategoriesController.data.data[index].ico}");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => MarketPlace(
                                              guest: widget.guest,
                                              catName:
                                                  ParentCategoriesController
                                                      .data
                                                      .data[index]
                                                      .categoryTitle,
                                              data: ParentCategoriesController
                                                  .data
                                                  .data[index]
                                                  .identifier,
                                            )));
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: index == 0 ? 20.sp : 0,
                                    right: 10.sp),
                                height: 95,
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                        padding: EdgeInsets.all(15.sp),
                                        width: 97.33.sp,
                                        height: 70.0.sp,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(11.0.sp),
                                          color: Colors.white,
                                        ),
                                        child: Center(
                                            child: SvgPicture.network(
                                          width: 97.33.sp,
                                          height: 70.0.sp,
                                          fit: BoxFit.contain,
                                          //{countryId == "1" ? BaseUrl : cyprusBaseUrl}
                                          "${finalServer}/${ParentCategoriesController.data.data[index].ico}",
                                        )),
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: CustomText(
                                          ParentCategoriesController
                                              .data.data[index].categoryTitle,
                                          style: Styles.robotoStyle2(
                                            fontSize: 14.0.sp,
                                            color: const Color(0xFF363636),
                                            fontWeight: FontWeight.w900, context: context,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }).animate().slide(begin: Offset(20, 0),duration: Duration(milliseconds: 100),curve:Curves.fastEaseInToSlowEaseOut );
                },
              ),
            );
  },
),
            BlocBuilder<ListHeightCubit, bool>(
              builder: (context, test) {
    return SizedBox(
              height: test != true ? 0.sp : 20.sp,
            );
  },
),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              padding: EdgeInsets.all(3.sp),
              margin: AppConstants.screenPadding,
              // width: 334.0,
              height: 50.0.sp,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white,
                border: Border.all(
                  width: 1.0,
                  color: const Color(0xFFCCCCCC),
                ),
              ),
              child: BlocBuilder<ProductTypesPageIndexCubit, int>(
                builder: (context, state) {
                  return Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: 86.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: state == 0
                                ? const Color(0xFFFC4F08)
                                : Colors.transparent,
                          ),
                          child: InkWell(
                            onTap: () {
                              SharePrefs.tabPageController!.jumpToPage(0);
                              context
                                  .read<ProductTypesPageIndexCubit>()
                                  .setTabIndex(index: 0);
                            },
                            child: Center(
                              child: CustomText(
                                'All'.tr(),
                                style: Styles.robotoStyle2(
                                  fontSize: 14.0.sp,
                                  color: state == 0
                                      ? Colors.white
                                      : Color(0xff4D4D4D),
                                  fontWeight: FontWeight.w900, context: context,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: 86.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: state == 1
                                ? const Color(0xFFFC4F08)
                                : Colors.transparent,
                          ),
                          child: InkWell(
                            onTap: () {
                              context
                                  .read<ProductTypesPageIndexCubit>()
                                  .setTabIndex(index: 1);
                              SharePrefs.tabPageController!.jumpToPage(1);
                            },
                            child: Center(
                              child: CustomText(
                                'Featured'.tr(),
                                style: Styles.robotoStyle2(
                                  fontSize: 14.0.sp,
                                  color: state == 1
                                      ? Colors.white
                                      : Color(0xff4D4D4D),
                                  fontWeight: FontWeight.w900, context: context,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: 86.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: state == 2
                                ? const Color(0xFFFC4F08)
                                : Colors.transparent,
                          ),
                          child: InkWell(
                            onTap: () async {
                              if (!widget.guest) {
                                SharePrefs.tabPageController!.jumpToPage(2);
                                context
                                    .read<ProductTypesPageIndexCubit>()
                                    .setTabIndex(index: 2);
                              } else {
                                // prodcutScrollerController!.dispose();
                                // featuredScrollerController!.dispose();
                                // faouriteScrollerController!.dispose();
                                // SharedPreferences prefs =
                                //     await SharedPreferences.getInstance();

                                // await prefs.remove("token");
                                // await prefs.remove("uid");
                                // await prefs.remove("initial");
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()));
                              }
                            },
                            child: Center(
                              child: CustomText(
                                'Favourite'.tr(),
                                style: Styles.robotoStyle2(
                                  fontSize: 14.0.sp,
                                  color: state == 2
                                      ? Colors.white
                                      : Color(0xff4D4D4D),
                                  fontWeight: FontWeight.w900, context: context,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

     AnimatedContainer(
              duration: Duration(milliseconds: 500),
              margin: AppConstants.screenPadding,
              // padding: EdgeInsets.all(10.0),
              // color: Colors.red,
              height:  .60.sh ,
              child: PageView(

                physics: const NeverScrollableScrollPhysics(),
                controller: SharePrefs.tabPageController,
                onPageChanged: (x) {
                  context
                      .read<ProductTypesPageIndexCubit>()
                      .setTabIndex(index: x);
                },
                children: [
                  AllProducts(guest: widget.guest),
                  AllFeaturedProducts(guest: widget.guest),
                  FavouriteProducts(
                    guest: widget.guest,
                  )
                ],
              ),
            )

          ],
        ),
      ),
      // BlocConsumer<InternetCheckerBloc, InternetCheckerState>(
      //   listener: (context, state) {},
      //   builder: (context, state) {
      //     return SingleChildScrollView(
      //       physics: NeverScrollableScrollPhysics(),
      //       child: Container(
      //         // color: Colors.red,
      //         child: Column(
      //           children: [
      //             SizedBox(
      //               height: 30.sp,
      //             ),
      //             Container(
      //               padding: AppConstants.screenPadding,
      //               height: 60.sp,
      //               child: Row(
      //                 children: [
      //                   Expanded(
      //                     flex: 2,
      //                     child: Image.asset("images/logo_orange.png"),
      //                   ),
      //
      //                   Expanded(
      //                     child: Container(
      //                       width: 38.w,
      //                       height: 22.h,
      //                       decoration: BoxDecoration(
      //                         color: Colors.white,
      //                         borderRadius: BorderRadius.circular(10).r,
      //                       ),
      //                       child: countryId == "1"
      //                           ? Center(
      //                               child: Image.network(
      //                               "https://apopou.gr/images/greece.jpg",
      //                               width: 25.w,
      //                               height: 12,
      //                             ))
      //                           : Center(
      //                               child: Image.network(
      //                               "https://apopou.gr/images/cyprus.jpg",
      //                               width: 25.w,
      //                               height: 12,
      //                             )),
      //                     ),
      //                   ),
      //
      //                   //Flag//
      //                   // BlocBuilder<UserCubit, UserState>(
      //                   //   builder: (context, state) {
      //                   //     var countryId = state.model.country;
      //                   //     log("Country Id Home $countryId");
      //                   //     if (state.status == UserStatus.loading) {
      //                   //       return Expanded(
      //                   //         child: Container(
      //                   //           width: 38.w,
      //                   //           height: 22.h,
      //                   //           decoration: BoxDecoration(
      //                   //             color: Colors.white,
      //                   //             borderRadius: BorderRadius.circular(10).r,
      //                   //           ),
      //                   //         ),
      //                   //       );
      //                   //     }
      //                   //     return Expanded(
      //                   //       child: Container(
      //                   //         width: 38.w,
      //                   //         height: 22.h,
      //                   //         decoration: BoxDecoration(
      //                   //           color: Colors.white,
      //                   //           borderRadius: BorderRadius.circular(10).r,
      //                   //         ),
      //                   //         child: countryId == "1"
      //                   //             ? Center(
      //                   //                 child: Image.network(
      //                   //                 "https://apopou.gr/images/greece.jpg",
      //                   //                 width: 25.w,
      //                   //                 height: 12,
      //                   //               ))
      //                   //             : Center(
      //                   //                 child: Image.network(
      //                   //                 "https://apopou.gr/images/cyprus.jpg",
      //                   //                 width: 25.w,
      //                   //                 height: 12,
      //                   //               )),
      //                   //       ),
      //                   //     );
      //                   //   },
      //                   // ),
      //                   const Spacer(
      //                     flex: 4,
      //                   ),
      //                   Expanded(
      //                     child: Align(
      //                       alignment: Alignment.centerRight,
      //                       child: InkWell(
      //                         onTap: () {
      //                           Navigator.push(
      //                               context,
      //                               MaterialPageRoute(
      //                                   builder: (_) => NotificationScreen(
      //                                         guest: widget.guest,
      //                                       )));
      //                         },
      //                         child: Container(
      //                           width: 40.0.sp,
      //                           height: 40.0.sp,
      //                           decoration: const BoxDecoration(
      //                             shape: BoxShape.circle,
      //                             color: Colors.white,
      //                           ),
      //                           child: Icon(
      //                             Icons.notifications_none,
      //                             color: AppConstants.appDarkColor,
      //                             size: 25.sp,
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                   )
      //                 ],
      //               ),
      //             ),
      //             Container(
      //               padding: AppConstants.screenPadding,
      //               height: 50.sp,
      //               child: Row(
      //                 children: [
      //                   Expanded(
      //                     flex: 2,
      //                     child: InkWell(
      //                       onTap: () {
      //                         Navigator.push(
      //                             context,
      //                             MaterialPageRoute(
      //                                 builder: (context) => SearchClickScreen(
      //                                       guest: widget.guest,
      //                                     )));
      //                       },
      //                       child: TextField(
      //                         enabled: false,
      //                         decoration: InputDecoration(
      //                             prefixIcon: const Icon(
      //                               Icons.search,
      //                               color: Colors.black,
      //                             ),
      //                             border: OutlineInputBorder(
      //                               borderRadius:
      //                                   BorderRadius.circular(30.0.sp),
      //                             ),
      //                             enabledBorder: OutlineInputBorder(
      //                               borderSide: BorderSide.none,
      //                               borderRadius:
      //                                   BorderRadius.circular(30.0.sp),
      //                             ),
      //                             filled: true,
      //                             hintStyle: TextStyle(color: Colors.grey[800]),
      //                             hintText: "Type in your text".tr(),
      //                             fillColor: Colors.white70),
      //                       ),
      //                     ),
      //                   ),
      //                   Expanded(
      //                       child: InkWell(
      //                     onTap: () {
      //                       Navigator.push(
      //                           context,
      //                           MaterialPageRoute(
      //                               builder: (context) => CategoriesExpanable(
      //                                   guest: widget.guest)));
      //                     },
      //                     child: Column(
      //                       children: [
      //                         const Expanded(
      //                           child: Icon(
      //                             Cashback.category,
      //                             color: Colors.black,
      //                           ),
      //                         ),
      //                         Expanded(
      //                           child: CustomText(
      //                             'Categories'.tr(),
      //                             style: Styles.robotoStyle2(
      //                               fontSize: 14.0.sp,
      //                               color: const Color(0xFF363636),
      //                               fontWeight: FontWeight.w900,
      //                             ),
      //                             textAlign: TextAlign.right,
      //                           ),
      //                         )
      //                       ],
      //                     ),
      //                   )),
      //                 ],
      //               ),
      //             ),
      //             SizedBox(
      //               height: 20.sp,
      //             ),
      //             AnimatedContainer(
      //               duration: Duration(milliseconds: 500),
      //               height: test != true ? 0.sp : 95.sp,
      //               child: BlocBuilder<ParentCategoriesCubit,
      //                   ParentCategoriesState>(
      //                 builder: (context, state) {
      //                   return state is ParentCategoriesLoading
      //                       ? Container(
      //                           child:
      //                               Center(child: CircularProgressIndicator()),
      //                         )
      //                       : ListView.builder(
      //                           scrollDirection: Axis.horizontal,
      //                           itemCount:
      //                               ParentCategoriesController.data.data.length,
      //                           itemBuilder: (context, index) {
      //                             var marketName = ParentCategoriesController
      //                                 .data.data[index].categoryTitle;
      //                             return InkWell(
      //                               onTap: () {
      //                                 log("HOME SCREEN CATEGORY ID ${ParentCategoriesController.data.data[index].identifier}");
      //                                 Navigator.push(
      //                                     context,
      //                                     MaterialPageRoute(
      //                                         builder: (_) => MarketPlace(
      //                                               guest: widget.guest,
      //                                               catName:
      //                                                   ParentCategoriesController
      //                                                       .data
      //                                                       .data[index]
      //                                                       .categoryTitle,
      //                                               data:
      //                                                   ParentCategoriesController
      //                                                       .data
      //                                                       .data[index]
      //                                                       .identifier,
      //                                             )));
      //                               },
      //                               child: Container(
      //                                 margin: EdgeInsets.only(
      //                                     left: index == 0 ? 20.sp : 0,
      //                                     right: 10.sp),
      //                                 height: 95,
      //                                 child: Column(
      //                                   children: [
      //                                     Expanded(
      //                                       flex: 4,
      //                                       child: Container(
      //                                         padding: EdgeInsets.all(15.sp),
      //                                         width: 97.33.sp,
      //                                         height: 70.0.sp,
      //                                         decoration: BoxDecoration(
      //                                           borderRadius:
      //                                               BorderRadius.circular(
      //                                                   11.0.sp),
      //                                           color: Colors.white,
      //                                         ),
      //                                         child: Center(
      //                                             child: SvgPicture.network(
      //                                           width: 97.33.sp,
      //                                           height: 70.0.sp,
      //                                           fit: BoxFit.contain,
      //                                           "${BaseUrl}/${ParentCategoriesController.data.data[index].ico}",
      //                                         )),
      //                                       ),
      //                                     ),
      //                                     Expanded(
      //                                       child: Align(
      //                                         alignment: Alignment.bottomCenter,
      //                                         child: CustomText(
      //                                           ParentCategoriesController.data
      //                                               .data[index].categoryTitle,
      //                                           style: Styles.robotoStyle2(
      //                                             fontSize: 14.0.sp,
      //                                             color:
      //                                                 const Color(0xFF363636),
      //                                             fontWeight: FontWeight.w900,
      //                                           ),
      //                                           textAlign: TextAlign.center,
      //                                         ),
      //                                       ),
      //                                     )
      //                                   ],
      //                                 ),
      //                               ),
      //                             );
      //                           });
      //                 },
      //               ),
      //             ),
      //             SizedBox(
      //               height: test != true ? 0.sp : 20.sp,
      //             ),
      //             AnimatedContainer(
      //               duration: Duration(milliseconds: 500),
      //               padding: EdgeInsets.all(3.sp),
      //               margin: AppConstants.screenPadding,
      //               // width: 334.0,
      //               height: 50.0.sp,
      //               decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(5.0),
      //                 color: Colors.white,
      //                 border: Border.all(
      //                   width: 1.0,
      //                   color: const Color(0xFFCCCCCC),
      //                 ),
      //               ),
      //               child: BlocBuilder<ProductTypesPageIndexCubit, int>(
      //                 builder: (context, state) {
      //                   return Row(
      //                     children: [
      //                       Expanded(
      //                         child: Container(
      //                           width: 86.0,
      //                           decoration: BoxDecoration(
      //                             borderRadius: BorderRadius.circular(5.0),
      //                             color: state == 0
      //                                 ? const Color(0xFFFC4F08)
      //                                 : Colors.transparent,
      //                           ),
      //                           child: InkWell(
      //                             onTap: () {
      //                               SharePrefs.controller!.jumpToPage(0);
      //                               context
      //                                   .read<ProductTypesPageIndexCubit>()
      //                                   .setTabIndex(index: 0);
      //                             },
      //                             child: Center(
      //                               child: CustomText(
      //                                 'All'.tr(),
      //                                 style: Styles.robotoStyle2(
      //                                   fontSize: 14.0.sp,
      //                                   color: state == 0
      //                                       ? Colors.white
      //                                       : Color(0xff4D4D4D),
      //                                   fontWeight: FontWeight.w900,
      //                                 ),
      //                                 textAlign: TextAlign.center,
      //                               ),
      //                             ),
      //                           ),
      //                         ),
      //                       ),
      //                       Expanded(
      //                         child: Container(
      //                           width: 86.0,
      //                           decoration: BoxDecoration(
      //                             borderRadius: BorderRadius.circular(5.0),
      //                             color: state == 1
      //                                 ? const Color(0xFFFC4F08)
      //                                 : Colors.transparent,
      //                           ),
      //                           child: InkWell(
      //                             onTap: () {
      //                               context
      //                                   .read<ProductTypesPageIndexCubit>()
      //                                   .setTabIndex(index: 1);
      //                               SharePrefs.controller!.jumpToPage(1);
      //                             },
      //                             child: Center(
      //                               child: CustomText(
      //                                 'Featured'.tr(),
      //                                 style: Styles.robotoStyle2(
      //                                   fontSize: 14.0.sp,
      //                                   color: state == 1
      //                                       ? Colors.white
      //                                       : Color(0xff4D4D4D),
      //                                   fontWeight: FontWeight.w900,
      //                                 ),
      //                                 textAlign: TextAlign.center,
      //                               ),
      //                             ),
      //                           ),
      //                         ),
      //                       ),
      //                       Expanded(
      //                         child: Container(
      //                           width: 86.0,
      //                           decoration: BoxDecoration(
      //                             borderRadius: BorderRadius.circular(5.0),
      //                             color: state == 2
      //                                 ? const Color(0xFFFC4F08)
      //                                 : Colors.transparent,
      //                           ),
      //                           child: InkWell(
      //                             onTap: () async {
      //                               if (!widget.guest) {
      //                                 SharePrefs.controller!.jumpToPage(2);
      //                                 context
      //                                     .read<ProductTypesPageIndexCubit>()
      //                                     .setTabIndex(index: 2);
      //                               } else {
      //                                 // prodcutScrollerController!.dispose();
      //                                 // featuredScrollerController!.dispose();
      //                                 // faouriteScrollerController!.dispose();
      //                                 // SharedPreferences prefs =
      //                                 //     await SharedPreferences.getInstance();
      //
      //                                 // await prefs.remove("token");
      //                                 // await prefs.remove("uid");
      //                                 // await prefs.remove("initial");
      //                                 Navigator.pushReplacement(
      //                                     context,
      //                                     MaterialPageRoute(
      //                                         builder: (context) =>
      //                                             LoginScreen()));
      //                               }
      //                             },
      //                             child: Center(
      //                               child: CustomText(
      //                                 'Favourite'.tr(),
      //                                 style: Styles.robotoStyle2(
      //                                   fontSize: 14.0.sp,
      //                                   color: state == 2
      //                                       ? Colors.white
      //                                       : Color(0xff4D4D4D),
      //                                   fontWeight: FontWeight.w900,
      //                                 ),
      //                                 textAlign: TextAlign.center,
      //                               ),
      //                             ),
      //                           ),
      //                         ),
      //                       ),
      //                     ],
      //                   );
      //                 },
      //               ),
      //             ),
      //             AnimatedContainer(
      //               duration: Duration(milliseconds: 500),
      //               margin: AppConstants.screenPadding,
      //               // padding: EdgeInsets.all(10.0),
      //               // color: Colors.red,
      //               height: test == false ? .60.sh : 0.50.sh,
      //               child: PageView(
      //                 physics: const NeverScrollableScrollPhysics(),
      //                 controller: SharePrefs.controller,
      //                 onPageChanged: (x) {
      //                   context
      //                       .read<ProductTypesPageIndexCubit>()
      //                       .setTabIndex(index: x);
      //                 },
      //                 children: [
      //                   AllProducts(guest: widget.guest),
      //                   AllFeaturedProducts(guest: widget.guest),
      //                   FavouriteProducts(
      //                     guest: widget.guest,
      //                   )
      //                 ],
      //               ),
      //             )
      //           ],
      //         ),
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
