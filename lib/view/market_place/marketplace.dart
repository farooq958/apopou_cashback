import 'dart:developer';
import 'package:cashback/controller/market_place/marketplacebloc/marketplace_cubit.dart';
import 'package:cashback/controller/subCategoryController.dart';
import 'package:cashback/controller/subFavCubit/cubit/subfav_cubit.dart';
import 'package:cashback/view/custom_widgets/app_color.dart';
import 'package:cashback/view/auth/login_screen.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:cashback/view/store_details.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../controller/AppConstants.dart';
import '../../controller/cashback_icons.dart';
import 'package:cashback/view/imports.dart';
class MarketPlace extends StatefulWidget {
  bool guest;
  dynamic data;
  final String catName;

  MarketPlace({
    Key? key,
    required this.data,
    required this.catName,
    required this.guest,
  }) : super(key: key);

  @override
  State<MarketPlace> createState() => _MarketPlaceState();
}

class _MarketPlaceState extends State<MarketPlace> {
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  var totalLength;
  var marketName = "";

  @override
  void initState() {
    gettingApi();
    super.initState();
  }

  gettingApi() async {
    SubCategoryController.page = 1;
    context.read<MarketplaceCubit>().MarketPlace(widget.data);
    totalLength = SubCategoryController.list.length;
  }

  @override
  Widget build(BuildContext context) {
    log("WIDGET DATA ${widget.data}");
    log("WIDGET catName ${widget.catName}");
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<MarketplaceCubit, MarketplaceState>(
          builder: (context, state) {
            if (state.status == MarketplaceStatus.initial) {
              return Container();
              // return Center(
              //   child: CircularProgressIndicator(
              //     color: AppColor.primaryColor,
              //   ),
              // );
            }
            log("Status ${state.status}");
            if (state == MarketplaceStatus.loading) {
              marketName = " ";
              log("testing b ${marketName}");
              setState(() {});
            }

            log("testing .... ${widget.data}");
            state.marketPlaceList = SubCategoryController.list;
            totalLength = SubCategoryController.list.length;
            return Container(
              color: const Color(0xffEFEEEE),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTopArrow(context),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13.0),
                    child: CustomText(
                        "${widget.catName}(${state.marketPlaceList.isEmpty ? 0 : SubCategoryController.total})",
                        style: Styles.robotoStyle(
                          FontWeight.w900,
                          24.0.sp,
                          const Color(0xFF363636),
                          context,
                          height: 1.22,
                        )),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Expanded(
                    child: SmartRefresher(
                      controller: refreshController,
                      enablePullUp: true,
                      reverse: false,
                      onRefresh: () async {
                        state.marketPlaceList = SubCategoryController.list;
                        refreshController.requestRefresh();
                        totalLength = SubCategoryController.list.length;
                        SubCategoryController.page = 1;
                        var result = await context
                            .read<MarketplaceCubit>()
                            .MarketPlace(widget.data);
                        if (result) {
                          refreshController.refreshCompleted();
                        } else {
                          refreshController.loadNoData();
                        }
                      },
                      onLoading: () async {
                        // state.marketPlaceList = SubCategoryController.list;
                        // refreshController.requestLoading();
                        // SubCategoryController.page =
                        //     SubCategoryController.page + 1;
                        // var result = await context
                        //     .read<MarketplaceCubit>()
                        //     .MarketPlace(widget.data);
                        // if (result) {
                        //   refreshController.loadComplete();
                        //   totalLength = SubCategoryController.list.length;
                        // } else {
                        //   refreshController.loadNoData();
                        // }

                        state.marketPlaceList = SubCategoryController.list;
                        refreshController.requestLoading();
                        SubCategoryController.page =
                            SubCategoryController.page + 1;

                        if (SubCategoryController.page >
                            SubCategoryController.totalPages) {
                          refreshController.loadNoData();
                          refreshController.loadComplete();
                        } else {
                          await context
                              .read<MarketplaceCubit>()
                              .MarketPlace(widget.data);
                          refreshController.loadComplete();
                          totalLength = SubCategoryController.list.length;
                        }

                        log("Current Page ${SubCategoryController.page}");
                      },
                      child: SubCategoryController.page == 1 &&
                              state.marketPlaceList.isEmpty &&
                              state.status == MarketplaceStatus.success
                          ? Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20)
                                        .r,
                                child: CustomText("No data available".tr(),
                                    textAlign: TextAlign.center,
                                    style: Styles.robotoStyle(
                                      FontWeight.w500,
                                      18.sp,
                                      AppColor.primaryColor,
                                      context,

                                    )),
                              ),
                            )
                          // : state.marketPlaceList.isEmpty &&
                          //         state.status == MarketplaceStatus.success
                          //     ? Padding(
                          //         padding:
                          //             const EdgeInsets.symmetric(horizontal: 10)
                          //                 .r,
                          //         child: Column(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           crossAxisAlignment:
                          //               CrossAxisAlignment.center,
                          //           children: [
                          //             Row(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.center,
                          //               children: [
                          //                 CustomText(
                          //                     "There is no data to load, Pull"
                          //                         .tr(),
                          //                     textAlign: TextAlign.center,
                          //                     style: Styles.robotoStyle(
                          //                       fontSize: 16.0.sp,
                          //                       color: AppColor.primaryColor,
                          //                       fontWeight: FontWeight.w500,
                          //                     )),
                          //                 Icon(Icons.arrow_downward_rounded),
                          //                 CustomText("down".tr(),
                          //                     textAlign: TextAlign.center,
                          //                     style: Styles.robotoStyle(
                          //                       fontSize: 16.0.sp,
                          //                       color: AppColor.primaryColor,
                          //                       fontWeight: FontWeight.w500,
                          //                     )),
                          //               ],
                          //             ),
                          //             CustomText("to load previous data".tr(),
                          //                 textAlign: TextAlign.center,
                          //                 style: Styles.robotoStyle(
                          //                   fontSize: 16.0.sp,
                          //                   color: AppColor.primaryColor,
                          //                   fontWeight: FontWeight.w500,
                          //                 )),
                          //           ],
                          //         ),
                          //       )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: totalLength,
                              itemBuilder: (context, index) {
                                state.marketPlaceList =
                                    SubCategoryController.list;
                                marketName = state.marketPlaceList[0].storeName;
                                // return GestureDetector(
                                //   onTap: () {
                                //     Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //             builder: (context) => StoreDetails(
                                //                 isAllProduct: false,
                                //                 index: index,
                                //                 guest: widget.guest,
                                //                 id: state.marketPlaceList[index]
                                //                     .identifier)));
                                //   },
                                //   child: Container(
                                //     padding: EdgeInsets.all(10.sp),
                                //     margin: const EdgeInsets.symmetric(
                                //         horizontal: 15, vertical: 4),
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
                                //             constraints: BoxConstraints(
                                //                 maxHeight: 80.0.sp,
                                //                 minHeight: 80.0.sp,
                                //                 minWidth: 80.0.sp,
                                //                 maxWidth: 80.0.sp),
                                //             width: 80.0.sp,
                                //             height: 80.0.sp,
                                //             decoration: BoxDecoration(
                                //               //color: Colors.red,
                                //               borderRadius:
                                //                   BorderRadius.circular(5.0),
                                //             ),
                                //             child: Image.network(state
                                //                 .marketPlaceList[index].storeImgURL
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
                                //                               state
                                //                                   .marketPlaceList[
                                //                                       index]
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
                                //                               state
                                //                                   .marketPlaceList[
                                //                                       index]
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
                                //                             "${state.marketPlaceList[index].categories.isEmpty ? "${widget.catName}" : state.marketPlaceList[index].categories.length}",
                                //                             style:
                                //                                 Styles.robotoStyle(
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
                                //                           'Cashback Up to ',
                                //                           style: Styles.robotoStyle(
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
                                //                                           state
                                //                                               .marketPlaceList[
                                //                                                   index]
                                //                                               .coupons_count
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
                                //                                           state
                                //                                               .marketPlaceList[
                                //                                                   index]
                                //                                               .products_count
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
                                //                       Expanded(child: Builder(
                                //                           builder: (context) {
                                //                         log("testing all favoriters ${SubCategoryController.list[index].favoriters}");
                                //                         return Align(
                                //                             alignment: Alignment
                                //                                 .bottomCenter,
                                //                             child: InkWell(
                                //                               onTap: () {
                                //                                 if (widget.guest) {
                                //                                   Navigator.push(
                                //                                       context,
                                //                                       MaterialPageRoute(
                                //                                           builder:
                                //                                               (context) =>
                                //                                                   LoginScreen()));
                                //                                 } else {
                                //                                   if (SubCategoryController
                                //                                           .list[
                                //                                               index]
                                //                                           .favoriters ==
                                //                                       0) {
                                //                                     context
                                //                                         .read<
                                //                                             SubfavCubit>()
                                //                                         .addToFav(
                                //                                             id: SubCategoryController
                                //                                                 .list[
                                //                                                     index]
                                //                                                 .identifier,
                                //                                             context:
                                //                                                 context,
                                //                                             index:
                                //                                                 index,
                                //                                             type:
                                //                                                 'all')
                                //                                         .whenComplete(
                                //                                             () {
                                //                                       setState(
                                //                                           () {});
                                //                                     });
                                //                                   } else {
                                //                                     context
                                //                                         .read<
                                //                                             SubfavCubit>()
                                //                                         .removeFav(
                                //                                             id: SubCategoryController
                                //                                                 .list[
                                //                                                     index]
                                //                                                 .identifier,
                                //                                             context:
                                //                                                 context,
                                //                                             index:
                                //                                                 index,
                                //                                             type:
                                //                                                 "all")
                                //                                         .whenComplete(
                                //                                             () {
                                //                                       setState(
                                //                                           () {});
                                //                                     });
                                //                                   }
                                //                                 }
                                //                               },
                                //                               child: Icon(
                                //                                 Icons.favorite,
                                //                                 color: SubCategoryController
                                //                                             .list[
                                //                                                 index]
                                //                                             .favoriters ==
                                //                                         0
                                //                                     ? Colors.grey
                                //                                     : Colors.red,
                                //                               ),
                                //                             ));
                                //                       }))
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

                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => StoreDetails(
                                                getFavouriteState: () {
                                                  setState(() {});
                                                },
                                                isAllProduct: false,
                                                index: index,
                                                guest: widget.guest,
                                                id: state.marketPlaceList[index]
                                                    .identifier)));
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
                                          constraints: BoxConstraints(
                                              maxHeight: 80.0.sp,
                                              minHeight: 80.0.sp,
                                              minWidth: 80.0.sp,
                                              maxWidth: 80.0.sp),
                                          width: 80.0.sp,
                                          height: 80.0.sp,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          child: Image.network(state
                                              .marketPlaceList[index]
                                              .storeImgURL
                                              .toString()),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  CustomText(
                                                    state.marketPlaceList[index]
                                                        .storeName,
                                                    style: Styles.robotoStyle(
                                                      FontWeight.w900,
                                                      16.sp,
                                                      const Color(
                                                          0xFF363636),
                                                      context,

                                                    ),
                                                  ),
                                                  CustomText(
                                                    state.marketPlaceList[index]
                                                        .storeCashback
                                                        .toString(),
                                                    style: Styles.robotoStyle(
                                                      FontWeight.w900,
                                                      20.sp,
                                                      const Color(
                                                          0xFFFC4F08),
                                                      context,

                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: CustomText(
                                                  'Cashback'.tr(),
                                                  style: Styles.robotoStyle(
                                                    FontWeight.w500,
                                                    15.sp,
                                                    const Color(
                                                        0xFFA7A7A7),
                                                    context,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Cashback.coupon,
                                                            color: AppConstants
                                                                .appDarkColor,
                                                          ),
                                                          SizedBox(width: 5),
                                                          CustomText(
                                                            state
                                                                .marketPlaceList[
                                                                    index]
                                                                .coupons_count
                                                                .toString(),
                                                            style: GoogleFonts
                                                                .roboto(
                                                              fontSize: 16.0.sp,
                                                              color: const Color(
                                                                  0xFF363636),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      CustomText(
                                                        'Coupons'.tr(),
                                                        style:
                                                            Styles.robotoStyle(
                                                              FontWeight.w500,
                                                              14.sp,
                                                              const Color(
                                                                  0xFFA7A7A7),
                                                              context,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                                right: 20)
                                                            .r,
                                                    child: Builder(
                                                        builder: (context) {
                                                      log("testing all favoriters ${SubCategoryController.list[index].favoriters}");
                                                      return Align(
                                                          alignment: Alignment
                                                              .bottomCenter,
                                                          child: InkWell(
                                                            onTap: () {
                                                              if (widget
                                                                  .guest) {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                LoginScreen()));
                                                              } else {
                                                                if (SubCategoryController
                                                                        .list[
                                                                            index]
                                                                        .favoriters ==
                                                                    0) {
                                                                  context
                                                                      .read<
                                                                          SubfavCubit>()
                                                                      .addToFav(
                                                                          id: SubCategoryController
                                                                              .list[
                                                                                  index]
                                                                              .identifier,
                                                                          context:
                                                                              context,
                                                                          index:
                                                                              index,
                                                                          type:
                                                                              'all')
                                                                      .whenComplete(
                                                                          () {
                                                                    setState(
                                                                        () {});
                                                                  });
                                                                } else {
                                                                  context
                                                                      .read<
                                                                          SubfavCubit>()
                                                                      .removeFav(
                                                                          id: SubCategoryController
                                                                              .list[
                                                                                  index]
                                                                              .identifier,
                                                                          context:
                                                                              context,
                                                                          index:
                                                                              index,
                                                                          type:
                                                                              "all")
                                                                      .whenComplete(
                                                                          () {
                                                                    setState(
                                                                        () {});
                                                                  });
                                                                }
                                                              }
                                                            },
                                                            child: Icon(
                                                              Icons.favorite,
                                                              color: SubCategoryController
                                                                          .list[
                                                                              index]
                                                                          .favoriters ==
                                                                      0
                                                                  ? Colors.grey
                                                                  : Colors.red,
                                                            ),
                                                          ));
                                                    }),
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
                              }),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Padding buildTopArrow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back,
          size: 25.sp,
          color: Colors.black,
        ),
      ),
    );
  }
}
