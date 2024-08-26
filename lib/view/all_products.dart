import 'dart:developer';
import 'package:cashback/view/custom_widgets/image_widgets.dart';
import 'package:cashback/view/imports.dart';
import 'package:cashback/controller/AppConstants.dart';
import 'package:cashback/controller/all_products_controller.dart';
import 'package:cashback/controller/all_shops_cubit.dart';
import 'package:cashback/controller/cashback_icons.dart';
import 'package:cashback/controller/listHeightCubit.dart';
import 'package:cashback/view/all_shops_heart.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:cashback/view/home_screen.dart';
import 'package:cashback/view/store_details.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// ignore: must_be_immutable
class AllProducts extends StatefulWidget {
  bool guest;
  AllProducts({required this.guest});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  final RefreshController refreshControllerHome =
      RefreshController(initialRefresh: true);

  var noMoreData = false;

  //ScrollController? prodcutScrollerController;
  //double offset = 0.0;
  late ScrollController? prodcutScrollerController = ScrollController();
  @override
  void initState() {
    log("CALL SHO");
    //prodcutScrollerController = ScrollController();
    AllProductsController.page = 1;
    AllProductsController.listData.clear();
    // ? setting the header to expand
    context.read<ListHeightCubit>().setHeight(true);
   // prodcutScrollerController!.addListener(this.swapPageListener);
    super.initState();
  }

  // void swapPageListener() {
  //   log("Run Sho");
  //   offset = prodcutScrollerController!.offset;
  //   setState(() {
  //     prodcutScrollerController!.hasClients;
  //     if (offset > prodcutScrollerController!.position.maxScrollExtent + 100) {
  //       prodcutScrollerController!.animateTo(1,
  //           duration: Duration(milliseconds: 500), curve: Curves.ease);
  //     }
  //     if (offset < prodcutScrollerController!.position.minScrollExtent - 100) {
  //       prodcutScrollerController!.animateTo(0,
  //           duration: Duration(milliseconds: 500), curve: Curves.ease);
  //     }
  //   });
  // }

  void swapPageListener() {
    log("Called product");
    // if (prodcutScrollerController!.offset >
    //     prodcutScrollerController!.position.maxScrollExtent + 100) {
    //   prodcutScrollerController!.animateTo(1,
    //       duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
    // }
    // if (prodcutScrollerController!.offset <
    //     prodcutScrollerController!.position.minScrollExtent - 100) {
    //   prodcutScrollerController!.animateTo(0,
    //       duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
    // }
  }

  @override
  void dispose() {
    //prodcutScrollerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllShopsCubit, AllShopsState>(
      builder: (context, state) {
        if (AllProductsController.listData.length ==
            AllProductsController.data.meta.pagination.totalPages) {
          noMoreData = true;
        }
        log("AllProductsController.listData.length ${AllProductsController.data.data}");
        return Container(
          // color: Colors.red,
          // height: context.read<ListHeightCubit>().state == false
          //     ? 0.50.sh
          //     : 0.50.sh,
          child: SmartRefresher(
            controller: refreshControllerHome,
            // enablePullUp: true,
            reverse: false,
            footer: Container(
              height: 10,
              child: CustomText('hello'),
            ),
            onRefresh: () async {
              log("testing smart refresh is calling");
              refreshControllerHome.requestRefresh();
              final result =
                  await context.read<AllShopsCubit>().allShops(reload: false);
              if (result) {
                refreshControllerHome.refreshCompleted();
              } else {
                refreshControllerHome.loadNoData();
              }
            },
            onLoading: () async {
              refreshControllerHome.requestLoading();
              // ! todo this ....
              log("testing smart loading is calling");

              final result =
                  await context.read<AllShopsCubit>().allShops(reload: false);
              if (result) {
                refreshControllerHome.loadComplete();
              } else {
                refreshControllerHome.loadNoData();
              }
            },
            child: state is Reload
                ? Center(child: const CircularProgressIndicator())
                : NotificationListener(
                    onNotification: (n) {
                      if (AllProductsController.listData.length ==
                          AllProductsController
                              .data.meta.pagination.totalPages) {}
                      if (prodcutScrollerController!
                              .position.userScrollDirection ==
                          ScrollDirection.forward) {
                        if (prodcutScrollerController!.position.pixels < 5.0 &&
                            context.read<ListHeightCubit>().state == false) {
                          context.read<ListHeightCubit>().setHeight(true);
                        }
                        // context.read<ListHeightCubit>().setHeight(true);
                      }

                      // log("testing reverse ${}");

                      if (prodcutScrollerController!
                              .position.userScrollDirection ==
                          ScrollDirection.reverse) {
                        // if()
                        if (n is ScrollEndNotification) {
                          context.read<AllShopsCubit>().allShops(reload: false);
                          log("testing api is calling ");
                        }
                        context.read<ListHeightCubit>().setHeight(false);
                      }
                      return true;
                    },
                    child: ListView.builder(
                        padding: EdgeInsets.only(top: 10.sp),
                        controller: prodcutScrollerController,
                        itemCount: AllProductsController.listData.length,
                        itemBuilder: (context, index) {
                          return customTile(index).animate().slideY();
                          // return InkWell(
                          //   onTap: () {
                          //     Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) => StoreDetails(
                          //                 index: index,
                          //                 guest: widget.guest,
                          //                 id: AllProductsController
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
                          //           flex: 1,
                          //           child: Container(
                          //             width: 80.0.sp,
                          //             height: 80.0.sp,
                          //             decoration: BoxDecoration(
                          //               borderRadius:
                          //                   BorderRadius.circular(5.0),
                          //             ),
                          //             child: Image.network(AllProductsController
                          //                 .listData[index].storeImgUrl
                          //                 .toString()),
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
                          //                               AllProductsController
                          //                                   .listData[index]
                          //                                   .storeName,
                          //                               style:
                          //                                   Styles.robotoStyle2(
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
                          //                               AllProductsController
                          //                                   .listData[index]
                          //                                   .storeCashback
                          //                                   .toString(),
                          //                               style:
                          //                                   Styles.robotoStyle2(
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
                          //                     // Expanded(
                          //                     //   child: Align(
                          //                     //     alignment:
                          //                     //         Alignment.centerLeft,
                          //                     //     child: FittedBox(
                          //                     //       fit: BoxFit.scaleDown,
                          //                     //       child: CustomText(
                          //                     //         AllProductsController
                          //                     //                 .listData[index]
                          //                     //                 .categories
                          //                     //                 .data
                          //                     //                 .asMap()
                          //                     //                 .containsKey(0)
                          //                     //             ? AllProductsController
                          //                     //                 .listData[index]
                          //                     //                 .categories
                          //                     //                 .data[0]
                          //                     //                 .categoryTitle
                          //                     //             : "N/A",
                          //                     //         style: Styles.robotoStyle2(
                          //                     //           fontSize: 14.0.sp,
                          //                     //           color: const Color(
                          //                     //               0xFF363636),
                          //                     //           fontWeight:
                          //                     //               FontWeight.w500,
                          //                     //         ),
                          //                     //       ),
                          //                     //     ),
                          //                     //   ),
                          //                     // ),
                          //                     Expanded(
                          //                       child: FittedBox(
                          //                         fit: BoxFit.scaleDown,
                          //                         child: CustomText(
                          //                           'Cashback',
                          //                           style: Styles.robotoStyle2(
                          //                             fontSize: 14.0.sp,
                          //                             color: const Color(
                          //                                 0xFFA7A7A7),
                          //                             fontWeight:
                          //                                 FontWeight.w500,
                          //                           ),
                          //                           textAlign: TextAlign.center,
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
                          //                                       alignment: Alignment
                          //                                           .centerLeft,
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
                          //                                       alignment: Alignment
                          //                                           .centerLeft,
                          //                                       child:
                          //                                           FittedBox(
                          //                                         fit: BoxFit
                          //                                             .scaleDown,
                          //                                         child: CustomText(
                          //                                           AllProductsController
                          //                                               .listData[
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
                          //                                                 FontWeight
                          //                                                     .w900,
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
                          //                                     style: GoogleFonts
                          //                                         .roboto(
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
                          //                       // Expanded(
                          //                       //   flex: 2,
                          //                       //   child: Column(
                          //                       //     children: [
                          //                       //       Expanded(
                          //                       //         child: Row(
                          //                       //           children: [
                          //                       //             Expanded(
                          //                       //               child: Align(
                          //                       //                 alignment: Alignment
                          //                       //                     .centerLeft,
                          //                       //                 child: Icon(
                          //                       //                   Cashback.bag,
                          //                       //                   color: AppConstants
                          //                       //                       .appDarkColor,
                          //                       //                 ),
                          //                       //               ),
                          //                       //             ),
                          //                       //             Expanded(
                          //                       //               flex: 2,
                          //                       //               child: Align(
                          //                       //                 alignment: Alignment
                          //                       //                     .centerLeft,
                          //                       //                 child:
                          //                       //                     FittedBox(
                          //                       //                   fit: BoxFit
                          //                       //                       .scaleDown,
                          //                       //                   child: CustomText(
                          //                       //                     AllProductsController
                          //                       //                         .listData[
                          //                       //                             index]
                          //                       //                         .productsCount
                          //                       //                         .toString(),
                          //                       //                     style: GoogleFonts
                          //                       //                         .roboto(
                          //                       //                       fontSize:
                          //                       //                           16.0.sp,
                          //                       //                       color: const Color(
                          //                       //                           0xFF363636),
                          //                       //                       fontWeight:
                          //                       //                           FontWeight
                          //                       //                               .w900,
                          //                       //                     ),
                          //                       //                   ),
                          //                       //                 ),
                          //                       //               ),
                          //                       //             )
                          //                       //           ],
                          //                       //         ),
                          //                       //       ),
                          //                       //       Expanded(
                          //                       //         child: Align(
                          //                       //           alignment: Alignment
                          //                       //               .centerLeft,
                          //                       //           child: FittedBox(
                          //                       //             fit: BoxFit
                          //                       //                 .scaleDown,
                          //                       //             child: CustomText(
                          //                       //               'Products'.tr(),
                          //                       //               style: GoogleFonts
                          //                       //                   .roboto(
                          //                       //                 fontSize:
                          //                       //                     14.0.sp,
                          //                       //                 color: const Color(
                          //                       //                     0xFFA7A7A7),
                          //                       //                 fontWeight:
                          //                       //                     FontWeight
                          //                       //                         .w500,
                          //                       //               ),
                          //                       //             ),
                          //                       //           ),
                          //                       //         ),
                          //                       //       )
                          //                       //     ],
                          //                       //   ),
                          //                       // ),
                          //                       Expanded(
                          //                         child: Align(
                          //                             alignment: Alignment
                          //                                 .bottomCenter,
                          //                             child: AllShopsHeart(
                          //                               index: index,
                          //                               guest: widget.guest,
                          //                             )),
                          //                       )
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
                        }),
                  ),
          ),
        );
      },
    );
  }

  Widget customTile(int index) {
    log("IMAGE USTAZ ${AllProductsController.listData[index].storeImgUrl.toString()}");
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StoreDetails(
              index: index,
              guest: widget.guest,
              id: AllProductsController.listData[index].identifier,
              getFavouriteState: () {
                setState(() {});
              },
            ),
          ),
        );
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
              child: CachedImage(

                  url: AllProductsController.listData[index].storeImgUrl.toString(),),
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
                        AllProductsController.listData[index].storeName,
                        style: Styles.robotoStyle2(
                          fontSize: 16.0.sp,
                          color: const Color(0xFF363636),
                          fontWeight: FontWeight.w900, context: context,
                        ),
                      ),
                      CustomText(
                        AllProductsController.listData[index].storeCashback
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
                                AllProductsController
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
                        child: AllShopsHeart(
                          controller:refreshControllerHome,
                          index: index,
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
