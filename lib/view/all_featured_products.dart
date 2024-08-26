import 'dart:developer';
import 'package:cashback/view/imports.dart';
import 'package:cashback/controller/AppConstants.dart';
import 'package:cashback/controller/all_feature_shops_cubit.dart';
import 'package:cashback/controller/all_featured_controller.dart';
import 'package:cashback/controller/cashback_icons.dart';
import 'package:cashback/controller/listHeightCubit.dart';
import 'package:cashback/view/featured_heart.dart';
import 'package:cashback/view/home_screen.dart';
import 'package:cashback/view/store_details.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'all_feature_detail_screen.dart';
import 'custom_widgets/text_style.dart';

class AllFeaturedProducts extends StatefulWidget {
  bool guest;
  AllFeaturedProducts({required this.guest});

  @override
  State<AllFeaturedProducts> createState() => _AllFeaturedProductsState();
}

class _AllFeaturedProductsState extends State<AllFeaturedProducts> {
  final RefreshController refreshControllerFeatured =
      RefreshController(initialRefresh: true);
  ScrollController? featuredScrollerController = ScrollController();
  bool enablePullUps = false;
  //ScrollController? featuredScrollerController;
  // double offset = 0.0;
  @override
  void initState() {
    //featuredScrollerController = ScrollController();
    AllFeatureController.listData.clear();

    AllFeatureController.page = 1;
    featuredScrollerController!.addListener(this.swapPageListener);
    super.initState();
  }

  // void swapPageListener() {
  //   log("Run Sho");
  //   offset = featuredScrollerController!.offset;
  //   setState(() {
  //     featuredScrollerController!.hasClients;
  //     if (offset > featuredScrollerController!.position.maxScrollExtent + 100) {
  //       featuredScrollerController!.animateTo(1,
  //           duration: Duration(milliseconds: 500), curve: Curves.ease);
  //     }
  //     if (offset < featuredScrollerController!.position.minScrollExtent - 100) {
  //       featuredScrollerController!.animateTo(0,
  //           duration: Duration(milliseconds: 500), curve: Curves.ease);
  //     }
  //   });
  // }

  void swapPageListener() {
    log("Called feature");
    if (featuredScrollerController!.offset >
        featuredScrollerController!.position.maxScrollExtent + 100) {
      featuredScrollerController!.animateTo(1,
          duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
    }
    if (featuredScrollerController!.offset <
        featuredScrollerController!.position.minScrollExtent - 100) {
      featuredScrollerController!.animateTo(0,
          duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
    }
  }

  @override
  void dispose() {
    //featuredScrollerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("G U E S T ${widget.guest}");
    bool isfeatureLoaded = false;
    return BlocConsumer<AllFeatureShopsCubit, AllFeatureShopsState>(
      listener: (context, state) {
        if (state is AllFeatureShopsLoaded) {
          isfeatureLoaded = true;
        }
        if (state is AllFeatureShopsLoading) {
          // AllFeatureController.listData.clear();
        }
      },
      builder: (context, state) {
        return Container(
          height: context.read<ListHeightCubit>().state == false
              ? MediaQuery.of(context).size.height * .70
              : 0.50.sh,
          child: SmartRefresher(
            controller: refreshControllerFeatured,
            // enablePullUp: false,
            footer: Container(
              height: 100,
              width: double.infinity,
              child: CustomText('hello'),
            ),
            reverse: false,
            onRefresh: () async {
              AllFeatureController.listData.length == 0
                  ? ""
                  : refreshControllerFeatured.requestRefresh();
              final result = await context
                  .read<AllFeatureShopsCubit>()
                  .allFeatureShops(reload: false, isGuest: widget.guest);

              if (result) {
                refreshControllerFeatured.refreshCompleted();
              } else {
                refreshControllerFeatured.loadNoData();
              }
            },
            onLoading: () async {
              refreshControllerFeatured.requestLoading();
              final result = await context
                  .read<AllFeatureShopsCubit>()
                  .allFeatureShops(reload: false, isGuest: widget.guest);
              if (result) {
                refreshControllerFeatured.loadComplete();
              } else {
                refreshControllerFeatured.loadNoData();
              }
            },
            child: isfeatureLoaded == false &&
                    AllFeatureController.listData.length == 0
                ? Container()
                : NotificationListener(
                    onNotification: (Notification n) {
                      log("tessssting ${AllFeatureController.page}");

                      if (featuredScrollerController!
                              .position.userScrollDirection ==
                          ScrollDirection.forward) {
                        // log("test state of height 222 ${n == ScrollStartNotification} ${context.read<ListHeightCubit>().state}");
                        // context.read<ListHeightCubit>().setHeight(true);
                        if (featuredScrollerController!.position.pixels < 5.0 &&
                            context.read<ListHeightCubit>().state == false) {
                          context.read<ListHeightCubit>().setHeight(true);
                        }
                      }

                      if (featuredScrollerController!
                              .position.userScrollDirection ==
                          ScrollDirection.reverse) {
                        if (n is ScrollEndNotification) {
                          // context
                          //     .read<AllFeatureShopsCubit>()
                          //     .allFeatureShops(reload: false);
                          log("testing api is calling ");
                        }
                        context.read<ListHeightCubit>().setHeight(false);
                      }
                      return true;
                    },
                    child: Container(
                      // height: context.read<ListHeightCubit>().state == false
                      //     ? MediaQuery.of(context).size.height * .70
                      //     : 0.50.sh,
                      child: ListView.builder(
                          padding: EdgeInsets.only(top: 10.sp),
                          controller: featuredScrollerController,
                          itemCount: AllFeatureController.listData.length,
                          itemBuilder: (context, index) {
                            // return GestureDetector(
                            //   onTap: () {
                            //     Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (context) => StoreDetails(
                            //                 index: index,
                            //                 guest: widget.guest,
                            //                 id: AllFeatureController
                            //                     .listData[index].identifier)));
                            //   },
                            //   child: Container(
                            //     padding: EdgeInsets.all(10.sp),
                            //     margin: EdgeInsets.only(bottom: 10.sp),
                            //     width: 334.0,
                            //     height: 111.0,
                            //     decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(5.0),
                            //       color: Colors.white,
                            //     ),
                            //     child: Row(
                            //       children: [
                            //         Expanded(
                            //           child: Container(
                            //             width: 80.0.sp,
                            //             height: 80.0.sp,
                            //             decoration: BoxDecoration(
                            //               borderRadius:
                            //                   BorderRadius.circular(5.0),
                            //             ),
                            //             child: Image.network(
                            //                 AllFeatureController
                            //                     .data.data[index].storeImgUrl
                            //                     .toString()),
                            //           ),
                            //         ),
                            //         Expanded(
                            //           flex: 4,
                            //           child: Container(
                            //             padding: EdgeInsets.only(left: 20.sp),
                            //             child: Column(
                            //               children: [
                            //                 Expanded(
                            //                   child: Row(
                            //                     children: [
                            //                       Expanded(
                            //                         child: Align(
                            //                           alignment:
                            //                               Alignment.topLeft,
                            //                           child: FittedBox(
                            //                             fit: BoxFit.scaleDown,
                            //                             child: CustomText(
                            //                               AllFeatureController
                            //                                   .data
                            //                                   .data[index]
                            //                                   .storeName,
                            //                               style: GoogleFonts
                            //                                   .roboto(
                            //                                 fontSize: 16.0.sp,
                            //                                 color: const Color(
                            //                                     0xFF363636),
                            //                                 fontWeight:
                            //                                     FontWeight.w900,
                            //                               ),
                            //                             ),
                            //                           ),
                            //                         ),
                            //                       ),
                            //                       Expanded(
                            //                         child: Align(
                            //                           alignment:
                            //                               Alignment.topCenter,
                            //                           child: FittedBox(
                            //                             fit: BoxFit.scaleDown,
                            //                             child: CustomText(
                            //                               AllFeatureController
                            //                                   .data
                            //                                   .data[index]
                            //                                   .storeCashback
                            //                                   .toString(),
                            //                               style: GoogleFonts
                            //                                   .roboto(
                            //                                 fontSize: 20.0.sp,
                            //                                 color: const Color(
                            //                                     0xFFFC4F08),
                            //                                 fontWeight:
                            //                                     FontWeight.w900,
                            //                               ),
                            //                               textAlign:
                            //                                   TextAlign.center,
                            //                             ),
                            //                           ),
                            //                         ),
                            //                       ),
                            //                     ],
                            //                   ),
                            //                 ),
                            //                 Expanded(
                            //                     child: Row(
                            //                   children: [
                            //                     Expanded(
                            //                       child: Align(
                            //                         alignment:
                            //                             Alignment.centerLeft,
                            //                         child: FittedBox(
                            //                           fit: BoxFit.scaleDown,
                            //                           child: CustomText(
                            //                             AllFeatureController
                            //                                 .data
                            //                                 .data[index]
                            //                                 .headTitle
                            //                                 .substring(0, 10),
                            //                             style:
                            //                                 Styles.robotoStyle2(
                            //                               fontSize: 14.0.sp,
                            //                               color: const Color(
                            //                                   0xFF363636),
                            //                               fontWeight:
                            //                                   FontWeight.w500,
                            //                             ),
                            //                           ),
                            //                         ),
                            //                       ),
                            //                     ),
                            //                     Expanded(
                            //                       child: FittedBox(
                            //                         fit: BoxFit.scaleDown,
                            //                         child: CustomText(
                            //                           'Cashback Up to '.tr(),
                            //                           style: Styles.robotoStyle2(
                            //                             fontSize: 14.0.sp,
                            //                             color: const Color(
                            //                                 0xFFA7A7A7),
                            //                             fontWeight:
                            //                                 FontWeight.w500,
                            //                           ),
                            //                           textAlign:
                            //                               TextAlign.center,
                            //                         ),
                            //                       ),
                            //                     )
                            //                   ],
                            //                 )),
                            //                 Expanded(
                            //                   flex: 2,
                            //                   child: Row(
                            //                     children: [
                            //                       Expanded(
                            //                         flex: 2,
                            //                         child: Column(
                            //                           children: [
                            //                             Expanded(
                            //                               child: Row(
                            //                                 children: [
                            //                                   Expanded(
                            //                                     child: Align(
                            //                                       alignment:
                            //                                           Alignment
                            //                                               .centerLeft,
                            //                                       child: Icon(
                            //                                         Cashback
                            //                                             .coupon,
                            //                                         color: AppConstants
                            //                                             .appDarkColor,
                            //                                       ),
                            //                                     ),
                            //                                   ),
                            //                                   Expanded(
                            //                                     flex: 2,
                            //                                     child: Align(
                            //                                       alignment:
                            //                                           Alignment
                            //                                               .centerLeft,
                            //                                       child:
                            //                                           FittedBox(
                            //                                         fit: BoxFit
                            //                                             .scaleDown,
                            //                                         child: CustomText(
                            //                                           AllFeatureController
                            //                                               .data
                            //                                               .data[
                            //                                                   index]
                            //                                               .couponsCount
                            //                                               .toString(),
                            //                                           style: GoogleFonts
                            //                                               .roboto(
                            //                                             fontSize:
                            //                                                 16.0.sp,
                            //                                             color: const Color(
                            //                                                 0xFF363636),
                            //                                             fontWeight:
                            //                                                 FontWeight.w900,
                            //                                           ),
                            //                                         ),
                            //                                       ),
                            //                                     ),
                            //                                   )
                            //                                 ],
                            //                               ),
                            //                             ),
                            //                             Expanded(
                            //                               child: Align(
                            //                                 alignment: Alignment
                            //                                     .centerLeft,
                            //                                 child: FittedBox(
                            //                                   fit: BoxFit
                            //                                       .scaleDown,
                            //                                   child: CustomText(
                            //                                     'Coupons'.tr(),
                            //                                     style:
                            //                                         GoogleFonts
                            //                                             .roboto(
                            //                                       fontSize:
                            //                                           14.0.sp,
                            //                                       color: const Color(
                            //                                           0xFFA7A7A7),
                            //                                       fontWeight:
                            //                                           FontWeight
                            //                                               .w500,
                            //                                     ),
                            //                                   ),
                            //                                 ),
                            //                               ),
                            //                             )
                            //                           ],
                            //                         ),
                            //                       ),
                            //                       Expanded(
                            //                         flex: 2,
                            //                         child: Column(
                            //                           children: [
                            //                             Expanded(
                            //                               child: Row(
                            //                                 children: [
                            //                                   Expanded(
                            //                                     child: Align(
                            //                                       alignment:
                            //                                           Alignment
                            //                                               .centerLeft,
                            //                                       child: Icon(
                            //                                         Cashback
                            //                                             .bag,
                            //                                         color: AppConstants
                            //                                             .appDarkColor,
                            //                                       ),
                            //                                     ),
                            //                                   ),
                            //                                   Expanded(
                            //                                     flex: 2,
                            //                                     child: Align(
                            //                                       alignment:
                            //                                           Alignment
                            //                                               .centerLeft,
                            //                                       child:
                            //                                           FittedBox(
                            //                                         fit: BoxFit
                            //                                             .scaleDown,
                            //                                         child: CustomText(
                            //                                           AllFeatureController
                            //                                               .data
                            //                                               .data[
                            //                                                   index]
                            //                                               .productsCount
                            //                                               .toString(),
                            //                                           style: GoogleFonts
                            //                                               .roboto(
                            //                                             fontSize:
                            //                                                 16.0.sp,
                            //                                             color: const Color(
                            //                                                 0xFF363636),
                            //                                             fontWeight:
                            //                                                 FontWeight.w900,
                            //                                           ),
                            //                                         ),
                            //                                       ),
                            //                                     ),
                            //                                   )
                            //                                 ],
                            //                               ),
                            //                             ),
                            //                             Expanded(
                            //                               child: Align(
                            //                                 alignment: Alignment
                            //                                     .centerLeft,
                            //                                 child: FittedBox(
                            //                                   fit: BoxFit
                            //                                       .scaleDown,
                            //                                   child: CustomText(
                            //                                     'Products'.tr(),
                            //                                     style:
                            //                                         GoogleFonts
                            //                                             .roboto(
                            //                                       fontSize:
                            //                                           14.0.sp,
                            //                                       color: const Color(
                            //                                           0xFFA7A7A7),
                            //                                       fontWeight:
                            //                                           FontWeight
                            //                                               .w500,
                            //                                     ),
                            //                                   ),
                            //                                 ),
                            //                               ),
                            //                             )
                            //                           ],
                            //                         ),
                            //                       ),
                            //                       Expanded(
                            //                           child: FeaturedHeart(
                            //                         index: index,
                            //                         guest: widget.guest,
                            //                       ))
                            //                     ],
                            //                   ),
                            //                 )
                            //               ],
                            //             ),
                            //           ),
                            //         )
                            //       ],
                            //     ),
                            //   ),
                            // );
                            return customTile(index);
                          }),
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget customTile(int index) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AllFeaturesDetailScreen(
                    getFavouriteState: () {
                      //log("CALLED CALL BACK FUNCTION $v");
                      //AllFeatureController.listData[index].identifier;
                      setState(() {});
                    },
                    index: index,
                    guest: widget.guest,
                    id: AllFeatureController.listData[index].identifier)));
      },
      child: Container(
        padding: EdgeInsets.all(10.sp),
        margin: EdgeInsets.only(bottom: 10.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
              width: 75.0.sp,
              height: 75.0.sp,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Image.network(
                  AllFeatureController.listData[index].storeImgUrl.toString()),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        AllFeatureController.listData[index].storeName,
                        style: Styles.robotoStyle2(
                          fontSize: 16.0.sp,
                          color: const Color(0xFF363636),
                          fontWeight: FontWeight.w900, context: context,
                        ),
                      ),
                      CustomText(
                        AllFeatureController.listData[index].storeCashback
                            .toString(),
                        style: Styles.robotoStyle2(
                          fontSize: 20.0.sp,
                          color: const Color(0xFFFC4F08),
                          fontWeight: FontWeight.w900, context: context,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: CustomText(
                      'Cashback'.tr(),
                      style: Styles.robotoStyle2(
                        fontSize: 15.0.sp,
                        color: const Color(0xFFA7A7A7),
                        fontWeight: FontWeight.w500, context: context,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Cashback.coupon,
                                color: AppConstants.appDarkColor,
                              ),
                              SizedBox(width: 5),
                              CustomText(
                                AllFeatureController
                                    .listData[index].couponsCount
                                    .toString(),
                                style: Styles.robotoStyle2(
                                  fontSize: 16.0.sp,
                                  color: const Color(0xFF363636),
                                  fontWeight: FontWeight.w900, context: context,
                                ),
                              ),
                            ],
                          ),
                          CustomText(
                            'Coupons'.tr(),
                            style: Styles.robotoStyle2(
                              fontSize: 14.0.sp,
                              color: const Color(0xFFA7A7A7),
                              fontWeight: FontWeight.w500, context: context,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20).r,
                        child: FeaturedHeart(
                          controller:refreshControllerFeatured,
                          index: index,
                          check: "",
                          guest: widget.guest,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
