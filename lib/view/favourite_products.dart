import 'dart:developer';
import 'package:cashback/view/imports.dart';
import 'package:cashback/controller/AppConstants.dart';
import 'package:cashback/controller/all_favourite_controller.dart';
import 'package:cashback/controller/all_favourite_products_cubit.dart';
import 'package:cashback/controller/cashback_icons.dart';
import 'package:cashback/controller/listHeightCubit.dart';
import 'package:cashback/controller/remove_fav_cubit.dart';
import 'package:cashback/controller/shared_preferences.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:cashback/view/home_screen.dart';
import 'package:cashback/view/store_details.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FavouriteProducts extends StatefulWidget {
  final bool guest;
  const FavouriteProducts({Key? key, required this.guest}) : super(key: key);

  @override
  State<FavouriteProducts> createState() => _FavouriteProductsState();
}

class _FavouriteProductsState extends State<FavouriteProducts> {
  ScrollController? faouriteScrollerController = ScrollController();
  //ScrollController? faouriteScrollerController;
  @override
  void initState() {
    // prodcutScrollerController!.dispose();
    // featuredScrollerController!.dispose();
    //faouriteScrollerController = ScrollController();

    AllFavouriteController.page = 1;
    AllFavouriteController.listData.clear();
    super.initState();
  }

  @override
  void dispose() {
    //faouriteScrollerController!.dispose();
    super.dispose();
  }

  RefreshController refreshControllerFavourite = RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AllFavouriteProductsCubit, AllFavouriteProductsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          height: context.read<ListHeightCubit>().state == false
              ? MediaQuery.of(context).size.height * .75
              : 0.50.sh,
          child: SmartRefresher(
            controller: refreshControllerFavourite,
            //enablePullUp: true,
            reverse: false,
            enablePullDown: true,
            onRefresh: () async {
              refreshControllerFavourite.requestRefresh();
              Future.wait([
                context.read<AllFavouriteProductsCubit>().refreshFavourite(),
              ]).whenComplete(() {
                setState(() {
                  refreshControllerFavourite.refreshCompleted();
                });
              });
              // refreshController.requestRefresh();
              // final result = await context
              //     .read<AllFavouriteProductsCubit>()
              //     .refreshFavourite();
              // if (result) {
              //   refreshController.refreshCompleted();
              // } else {
              //   refreshController.refreshCompleted();
              //   refreshController.loadNoData();
              // }
            },
            onLoading: () async {
              refreshControllerFavourite.requestLoading();
              Future.wait([
                context
                    .read<AllFavouriteProductsCubit>()
                    .allFavouriteProducts(reload: false),
              ]).whenComplete(() {
                setState(() {
                  refreshControllerFavourite.loadComplete();
                });
              });
              // refreshController.requestLoading();
              // final result = await context
              //     .read<AllFavouriteProductsCubit>()
              //     .refreshFavourite();
              // if (result) {
              //   refreshController.loadComplete();
              // } else {
              //   refreshController.refreshCompleted();
              //   refreshController.loadNoData();
              // }
            },
            child: state is AllFavouriteProductsRelaod
                ? Center(child: const CircularProgressIndicator())
                : NotificationListener(
                    onNotification: (n) {
                      if (faouriteScrollerController!
                              .position.userScrollDirection ==
                          ScrollDirection.forward) {
                        // log("test state of hei ${context.read<ListHeightCubit>().state}");
                        // context.read<ListHeightCubit>().setHeight(true);
                        if (faouriteScrollerController!.position.pixels < 5.0 &&
                            context.read<ListHeightCubit>().state == false) {
                          context.read<ListHeightCubit>().setHeight(true);
                        }
                      }

                      if (faouriteScrollerController!
                              .position.userScrollDirection ==
                          ScrollDirection.reverse) {
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
                          controller: faouriteScrollerController,
                          itemCount: AllFavouriteController.listData.length,
                          itemBuilder: (context, index) {
                            //log('Data ${AllFavouriteController.listData[index].featuredStore}');
                            // return InkWell(
                            //   onTap: () {
                            //     Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (context) => StoreDetails(
                            //                 index: index,
                            //                 guest: widget.guest,
                            //                 id: AllFavouriteController
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
                            //                 AllFavouriteController
                            //                     .listData[index].storeImgUrl
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
                            //                               AllFavouriteController
                            //                                   .listData[index]
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
                            //                               AllFavouriteController
                            //                                   .listData[index]
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
                            //                             AllFavouriteController
                            //                                 .listData[index]
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
                            //                                           AllFavouriteController
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
                            //                                           AllFavouriteController
                            //                                               .listData[
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
                            //                         child: Align(
                            //                           alignment: Alignment
                            //                               .bottomCenter,
                            //                           child: InkWell(
                            //                             onTap: () {
                            //                               context
                            //                                   .read<
                            //                                       RemoveFavCubit>()
                            //                                   .removeFav(
                            //                                     type: "fav",
                            //                                     id: AllFavouriteController
                            //                                         .listData[
                            //                                             index]
                            //                                         .identifier,
                            //                                     context:
                            //                                         context,
                            //                                     index: index,
                            //                                   );
                            //                               AllFavouriteController
                            //                                   .page = 1;
                            //                               AllFavouriteController
                            //                                   .listData
                            //                                   .clear();
                            //                               context
                            //                                   .read<
                            //                                       AllFavouriteProductsCubit>()
                            //                                   .allFavouriteProducts(
                            //                                       reload: true);
                            //                               SharePrefs
                            //                                   .refreshController
                            //                                   .loadComplete();
                            //                             },
                            //                             child: Icon(
                            //                               Icons.favorite,
                            //                               color: Colors.red,
                            //                             ),
                            //                           ),
                            //                         ),
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
                builder: (context) => StoreDetails(
                    index: index,
                    isFavorite: true,
                    getFavouriteState: () {
                      //log('CallBack Favoirite $v');
                      setState(() {});
                    },
                    guest: widget.guest,
                    id: AllFavouriteController.listData[index].identifier)));
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
              child: Image.network(AllFavouriteController
                  .listData[index].storeImgUrl
                  .toString()),
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
                        AllFavouriteController.listData[index].storeName,
                        style: Styles.robotoStyle2(
                          fontSize: 16.0.sp,
                          color: const Color(0xFF363636),
                          fontWeight: FontWeight.w900, context: context,
                        ),
                      ),
                      CustomText(
                        AllFavouriteController.listData[index].storeCashback
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
                                AllFavouriteController
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
                        child: InkWell(
                          onTap: ()async  {
                           await context.read<RemoveFavCubit>().removeFav(
                                  type: "fav",
                                  id: AllFavouriteController
                                      .listData[index].identifier,
                                  context: context,
                                  index: index,
                                );
                            AllFavouriteController.page = 1;
                            AllFavouriteController.listData.removeAt(index);
                            // context
                            //     .read<AllFavouriteProductsCubit>()
                            //     .allFavouriteProducts(reload: false);
                         await   refreshControllerFavourite.requestRefresh(needMove: false);
                          },
                          child: Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
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
