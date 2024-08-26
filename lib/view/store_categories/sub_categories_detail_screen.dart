import 'dart:developer';
import 'package:cashback/view/imports.dart';
import 'package:cashback/controller/AppConstants.dart';
import 'package:cashback/controller/retailerCubit/getCouponCubit/get_coupon_cubit.dart';
import 'package:cashback/controller/retailerCubit/sinlgeRetailerCubit/single_retailer_cubit.dart';
import 'package:cashback/controller/services/historyServics.dart';
import 'package:cashback/controller/subCategoryController.dart';
import 'package:cashback/controller/subFavCubit/cubit/subfav_cubit.dart';
import 'package:cashback/view/all_shops_heart.dart';
import 'package:cashback/view/auth/login_screen.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:cashback/view/store_categories/sub_categories_favorite.dart';
import 'package:cashback/view/terms/cashback_term.dart';
import 'package:cashback/view/web_view/web_view.dart';
import 'package:clipboard/clipboard.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart' show parse;
import 'package:path_drawing/path_drawing.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubCategoryDetailScreen extends StatefulWidget {
  final int id;
  final int index;
  final bool guest;
  final bool isAllProduct;
  final void Function() getFavouriteState;
  const SubCategoryDetailScreen({
    Key? key,
    required this.id,
    required this.index,
    this.isAllProduct = true,
    required this.guest,
    required this.getFavouriteState,
  }) : super(key: key);

  @override
  State<SubCategoryDetailScreen> createState() =>
      _SubCategoryDetailScreenState();
}

class _SubCategoryDetailScreenState extends State<SubCategoryDetailScreen> {
  var couponImage;
  var couponCashBack;
  var freeShipping;
  var cashBackTermDesc;
  var redirectURL;
  var favorite;
  @override
  void initState() {
    Future.wait([
      context.read<SingleRetailerCubit>().getSingleRetailer(id: widget.id),
      context.read<GetCouponCubit>().getCoupon(id: widget.id),
    ]).whenComplete(() {
      setState(() {});
    });

    super.initState();
  }

  String parseHtmlString(String htmlString) {
    var document = parse(htmlString);

    String parsedString = parse(document.body!.text).documentElement!.text;

    return parsedString;
  }

  @override
  Widget build(BuildContext context) {
    log('Kar tol pa Start k khrb sho ${widget.id}');
    return WillPopScope(
      onWillPop: () async {
        widget.getFavouriteState();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xffEFEEEE),
          body: Container(
              margin: AppConstants.screenPadding,
              width: 1.sw,
              height: 1.sh,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 20.sp,
                    child: SizedBox(
                      height: 25.sp,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () async {
                            widget.getFavouriteState();
                            Navigator.pop(context, true);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            size: 25.sp,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 60.sp,
                    left: 0,
                    bottom: 0,
                    right: 0,
                    child: SizedBox(
                        width: 1.sw,
                        // height: 0.88.sh,
                        child: Column(
                          children: [
                            // first row of product
                            BlocBuilder<SingleRetailerCubit,
                                SingleRetailerState>(
                              builder: (context, state) {
                                log("HEADTitle ${state.list.headTitle}");
                                couponImage = state.list.storeImgURL;
                                couponCashBack = state.list.storeCashback;
                                freeShipping = state.list.shippingInfo;
                                cashBackTermDesc = state.list.storeTerms;
                                redirectURL = state.list.redirectURL;

                                if (state.status ==
                                    SingleRetailerStatus.loading) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: Color(0xFFFC4F08),
                                    ),
                                  );
                                }

                                if (state.status ==
                                    SingleRetailerStatus.error) {
                                  return Container();
                                }
                                return SizedBox(
                                  height: 100.sp,
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Stack(
                                          children: [
                                            Container(
                                              height: 90.h,
                                              width: 90.w,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                      couponImage,
                                                    )),
                                              ),
                                            ),
                                            Positioned(
                                              right: 2.sp,
                                              bottom: 2.sp,
                                              child: SubCategoriesFavorite(
                                                id: widget.id,
                                                index: widget.index,
                                                guest: widget.guest,
                                              ),
                                              // widget.isAllProduct ==
                                              //         false
                                              //     ? Align(
                                              //         alignment: Alignment
                                              //             .bottomCenter,
                                              //         child: InkWell(
                                              //           onTap: () async {
                                              //             log("clickiung this one .......");
                                              //             if (widget.guest ==
                                              //                 true) {
                                              //               log("clickiung this one ");
                                              //               showLoaderDialog(
                                              //                   context);
                                              //             } else {
                                              //               log("clickiung this one } ");
                                              //               if (SubCategoryController
                                              //                       .list[widget
                                              //                           .index]
                                              //                       .favoriters ==
                                              //                   0) {
                                              //                 context
                                              //                     .read<
                                              //                         SubfavCubit>()
                                              //                     .addToFav(
                                              //                         id: SubCategoryController
                                              //                             .list[widget
                                              //                                 .index]
                                              //                             .identifier,
                                              //                         context:
                                              //                             context,
                                              //                         index: widget
                                              //                             .index,
                                              //                         type:
                                              //                             'all')
                                              //                     .whenComplete(
                                              //                         () {
                                              //                   setState(() {});
                                              //                 });
                                              //               } else {
                                              //                 context
                                              //                     .read<
                                              //                         SubfavCubit>()
                                              //                     .removeFav(
                                              //                         id: SubCategoryController
                                              //                             .list[widget
                                              //                                 .index]
                                              //                             .identifier,
                                              //                         context:
                                              //                             context,
                                              //                         index: widget
                                              //                             .index,
                                              //                         type:
                                              //                             "all")
                                              //                     .whenComplete(
                                              //                         () {
                                              //                   setState(() {});
                                              //                 });
                                              //               }
                                              //             }
                                              //           },
                                              //           child: Icon(
                                              //             Icons.favorite,
                                              //             color: SubCategoryController
                                              //                         .list[widget
                                              //                             .index]
                                              //                         .favoriters ==
                                              //                     0
                                              //                 ? Colors.grey
                                              //                 : Colors.red,
                                              //           ),
                                              //         ))
                                              //     : Align(
                                              //         alignment: Alignment
                                              //             .bottomCenter,
                                              //         child: GestureDetector(
                                              //           onTap: () {
                                              //             log("clickiung this one .......asdfasdfsadf");
                                              //             if (widget.guest ==
                                              //                 true) {
                                              //               log("clickiung this one ");
                                              //               showLoaderDialog(
                                              //                   context);
                                              //             } else {
                                              //               log("clickiung this one  } ");
                                              //               if (SubCategoryController
                                              //                       .list[widget
                                              //                           .index]
                                              //                       .favoriters ==
                                              //                   0) {
                                              //                 context
                                              //                     .read<
                                              //                         SubfavCubit>()
                                              //                     .addToFav(
                                              //                         id: SubCategoryController
                                              //                             .list[widget
                                              //                                 .index]
                                              //                             .identifier,
                                              //                         context:
                                              //                             context,
                                              //                         index: widget
                                              //                             .index,
                                              //                         type:
                                              //                             'all')
                                              //                     .whenComplete(
                                              //                         () {
                                              //                   setState(() {});
                                              //                 });
                                              //               } else {
                                              //                 context
                                              //                     .read<
                                              //                         SubfavCubit>()
                                              //                     .removeFav(
                                              //                         id: SubCategoryController
                                              //                             .list[widget
                                              //                                 .index]
                                              //                             .identifier,
                                              //                         context:
                                              //                             context,
                                              //                         index: widget
                                              //                             .index,
                                              //                         type:
                                              //                             "all")
                                              //                     .whenComplete(
                                              //                         () {
                                              //                   setState(() {});
                                              //                 });
                                              //               }
                                              //             }
                                              //           },
                                              //           child: AllShopsHeart(
                                              //             index: widget.index,
                                              //             guest: widget.guest,
                                              //           ),
                                              //         )),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.sp,
                                      ),
                                      // first row
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 12.h),
                                            state.list.headTitle.isEmpty
                                                ? Container()
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 5,
                                                    ).r,
                                                    child: CustomText(
                                                      '${state.list.headTitle.split("+")[0].length > 15 ? state.list.headTitle.split("+")[0].substring(0, 20) : "."}${state.list.headTitle.split("+")[0].length > 20 ? "..." : ""}',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: Styles.robotoStyle(
                                                        FontWeight.w700,
                                                        17.0.sp,
                                                        Colors.black,
                                                        context,

                                                      ),
                                                    ),
                                                  ),
                                            SizedBox(height: 8.h),
                                            state.list.headTitle.contains("|")
                                                ? CustomText(
                                                    '${state.list.headTitle.split("|")[1]}',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Styles.robotoStyle(

                                                      FontWeight.w900,
                                                      17.0.sp,
                                                      const Color(0xFFFC4F08),
                                                      context,

                                                      // color: const Color(
                                                      //     0xFFFC4F08),
                                                      // fontSize: 17.sp,
                                                      // fontWeight:
                                                      //     FontWeight.w900,
                                                    ),
                                                  )
                                                : state.list.headTitle
                                                        .contains("&")
                                                    ? CustomText(
                                                        //"${state.list.headTitle.split("+")[1].length > 15 ? state.list.headTitle.split("+")[1].substring(0, 18) : state.list.headTitle.split("+")[1]}...",
                                                        '+${state.list.headTitle.split("&")[1]}',
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            Styles.robotoStyle(
                                                              FontWeight.w900,
                                                              17.0.sp,
                                                              const Color(0xFFFC4F08),
                                                              context,
                                                        ),
                                                      )
                                                    : Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 5,
                                                        ).r,
                                                        child: CustomText(
                                                          '+${state.list.headTitle.split("+")[1]}',
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: GoogleFonts
                                                              .roboto(
                                                            color: const Color(
                                                                0xFFFC4F08),
                                                            fontSize: 17.sp,
                                                            fontWeight:
                                                                FontWeight.w900,
                                                          ),
                                                        ),
                                                      ),

                                            // Align(
                                            //   alignment: Alignment.topLeft,
                                            //   child: Text.rich(
                                            //     TextSpan(
                                            //       style: Styles.robotoStyle(
                                            //         fontSize: 16.0.sp,
                                            //         color:
                                            //             const Color(0xFF363636),
                                            //       ),
                                            //       children: [
                                            //         TextSpan(
                                            //           text:
                                            //               '${state.list.headTitle.split("+")[0].length > 15 ? state.list.headTitle.split("+")[0].substring(0, 20) : "."}${state.list.headTitle.split("+")[0].length > 20 ? "..." : ""}\n ',
                                            //           style: Styles.robotoStyle(
                                            //             fontWeight:
                                            //                 FontWeight.w700,
                                            //           ),
                                            //         ),
                                            //         TextSpan(
                                            //           text:
                                            //               '+${state.list.headTitle.split("+")?[1] ?? ""}',
                                            //           style: Styles.robotoStyle(
                                            //             color: const Color(
                                            //                 0xFFFC4F08),
                                            //             fontSize: 17.sp,
                                            //             fontWeight:
                                            //                 FontWeight.w900,
                                            //           ),
                                            //         ),
                                            //       ],
                                            //     ),
                                            //   ),
                                            // ),
                                            ///text star / 4.5 by persons
                                            // Row(
                                            //   mainAxisAlignment:
                                            //       MainAxisAlignment.start,
                                            //   children: [
                                            //     Icon(
                                            //       Icons.star_border_outlined,
                                            //       size: 18.sp,
                                            //       color:
                                            //           const Color(0xFFD00000),
                                            //     ),
                                            //     Text.rich(
                                            //       TextSpan(
                                            //         style: Styles.robotoStyle(
                                            //           fontSize: 18.0.sp,
                                            //           color: const Color(
                                            //               0xFF363636),
                                            //         ),
                                            //         children: [
                                            //           TextSpan(
                                            //             text: '4.5',
                                            //             style:
                                            //                 Styles.robotoStyle(
                                            //               fontSize: 16.sp,
                                            //               fontWeight:
                                            //                   FontWeight.w700,
                                            //             ),
                                            //           ),
                                            //           TextSpan(
                                            //             text:
                                            //                 ' by 4523 persons',
                                            //             style:
                                            //                 Styles.robotoStyle(
                                            //               fontSize: 14.0,
                                            //               fontWeight:
                                            //                   FontWeight.w500,
                                            //             ),
                                            //           ),
                                            //         ],
                                            //       ),
                                            //     )
                                            //   ],
                                            // ),

                                            ///See All Reviews///
                                            // Expanded(
                                            //           child: Align(
                                            //             alignment: Alignment.centerLeft,
                                            //             child: Container(
                                            //               width: 132.0.sp,
                                            //               // height: 20.sp,
                                            //               decoration: BoxDecoration(
                                            //                 borderRadius:
                                            //                     BorderRadius.circular(
                                            //                         2.0),
                                            //                 border: Border.all(
                                            //                   width: 2.0,
                                            //                   color: const Color(
                                            //                       0xFFFC4F08),
                                            //                 ),
                                            //               ),
                                            //               child: Center(
                                            //                 child: InkWell(
                                            //                   onTap: () {
                                            //                     //TODO: onTap See all reviews
                                            //                     print(
                                            //                         'onTap See all reviews');
                                            //                   },
                                            //                   child: Center(
                                            //                     child: FittedBox(
                                            //                       fit: BoxFit.scaleDown,
                                            //                       child: CustomText(
                                            //                         'SEE ALL REVIEWS',
                                            //                         style: GoogleFonts
                                            //                             .roboto(
                                            //                           fontSize: 12.0.sp,
                                            //                           color: const Color(
                                            //                               0xFFFC4F08),
                                            //                           fontWeight:
                                            //                               FontWeight
                                            //                                   .w900,
                                            //                         ),
                                            //                         textAlign: TextAlign
                                            //                             .center,
                                            //                       ),
                                            //                     ),
                                            //                   ),
                                            //                 ),
                                            //               ),
                                            //             ),
                                            //           ),
                                            //         ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),

                            SizedBox(
                              height: 15.sp,
                            ),
                            Expanded(
                              child: ListView(
                                physics: NeverScrollableScrollPhysics(),
                                children: [
                                  // coupons list
                                  BlocBuilder<GetCouponCubit, GetCouponState>(
                                    builder: (context, state) {
                                      if (state.status ==
                                          GetCouponStatus.loading) {
                                        return Container();
                                      }
                                      log("state.list.length ${state.list.length}");
                                      if (state.status ==
                                          GetCouponStatus.loading) {
                                        return Container();
                                      }

                                      if (state.status ==
                                          GetCouponStatus.error) {
                                        return Center(
                                          child:
                                              CustomText("Error while loading ...."),
                                        );
                                      }
                                      return Column(
                                        children: [
                                          // SizedBox(
                                          //   height: 92.sp,
                                          //   width: 1.sw,
                                          //   child: Row(
                                          //     children: [
                                          //       Expanded(
                                          //         flex: 1,
                                          //         child: Container(
                                          //           padding: EdgeInsets.only(
                                          //               left: 13.sp,
                                          //               right: 13.sp),
                                          //           height: 92.0.sp,
                                          //           decoration: BoxDecoration(
                                          //             borderRadius:
                                          //                 BorderRadius.circular(
                                          //                     5.0.sp),
                                          //             color: Colors.white,
                                          //           ),
                                          //           child: Column(
                                          //             children: [
                                          //               Expanded(
                                          //                 flex: 2,
                                          //                 child: Row(
                                          //                   children: [
                                          //                     Expanded(
                                          //                       child: Align(
                                          //                         alignment: Alignment
                                          //                             .bottomLeft,
                                          //                         child: Icon(
                                          //                           Cashback
                                          //                               .coupon,
                                          //                           size: 40.sp,
                                          //                           color: const Color(
                                          //                               0xFFFC4F08),
                                          //                         ),
                                          //                       ),
                                          //                     ),
                                          //                     Expanded(
                                          //                       flex: 2,
                                          //                       child: Align(
                                          //                         alignment: Alignment
                                          //                             .bottomLeft,
                                          //                         child:
                                          //                             FittedBox(
                                          //                           fit: BoxFit
                                          //                               .scaleDown,
                                          //                           child: CustomText(
                                          //                             '${state.list.length}',
                                          //                             style: GoogleFonts
                                          //                                 .roboto(
                                          //                               fontSize:
                                          //                                   40.0.sp,
                                          //                               color: const Color(
                                          //                                   0xFF363636),
                                          //                               fontWeight:
                                          //                                   FontWeight
                                          //                                       .w900,
                                          //                             ),
                                          //                           ),
                                          //                         ),
                                          //                       ),
                                          //                     )
                                          //                   ],
                                          //                 ),
                                          //               ),
                                          //               Expanded(
                                          //                 child: Align(
                                          //                   alignment:
                                          //                       Alignment.topLeft,
                                          //                   child: FittedBox(
                                          //                     fit: BoxFit
                                          //                         .scaleDown,
                                          //                     child: CustomText(
                                          //                       'Διαθέσιμα κουπόνια',
                                          //                       style: GoogleFonts
                                          //                           .roboto(
                                          //                         fontSize:
                                          //                             14.0.sp,
                                          //                         color: const Color(
                                          //                             0xFFA7A7A7),
                                          //                         fontWeight:
                                          //                             FontWeight
                                          //                                 .w500,
                                          //                       ),
                                          //                     ),
                                          //                   ),
                                          //                 ),
                                          //               )
                                          //             ],
                                          //           ),
                                          //         ),
                                          //       ),
                                          //       SizedBox(
                                          //         width: 10.sp,
                                          //       ),
                                          //       Expanded(
                                          //         flex: 1,
                                          //         child: Container(
                                          //           padding: EdgeInsets.only(
                                          //               left: 13.sp,
                                          //               right: 13.sp),
                                          //           height: 92.0.sp,
                                          //           decoration: BoxDecoration(
                                          //             borderRadius:
                                          //                 BorderRadius.circular(
                                          //                     5.0.sp),
                                          //             color: Colors.white,
                                          //           ),
                                          //           child: Column(
                                          //             children: [
                                          //               Expanded(
                                          //                 flex: 2,
                                          //                 child: Row(
                                          //                   children: [
                                          //                     Expanded(
                                          //                       child: Align(
                                          //                         alignment: Alignment
                                          //                             .bottomLeft,
                                          //                         child: Icon(
                                          //                           Cashback.bag,
                                          //                           size: 40.sp,
                                          //                           color: const Color(
                                          //                               0xFF0BDCD4),
                                          //                         ),
                                          //                       ),
                                          //                     ),
                                          //                     Expanded(
                                          //                       flex: 2,
                                          //                       child: Align(
                                          //                         alignment: Alignment
                                          //                             .bottomLeft,
                                          //                         child:
                                          //                             FittedBox(
                                          //                           fit: BoxFit
                                          //                               .scaleDown,
                                          //                           child: CustomText(
                                          //                             '0',
                                          //                             style: GoogleFonts
                                          //                                 .roboto(
                                          //                               fontSize:
                                          //                                   40.0.sp,
                                          //                               color: const Color(
                                          //                                   0xFF363636),
                                          //                               fontWeight:
                                          //                                   FontWeight
                                          //                                       .w900,
                                          //                             ),
                                          //                           ),
                                          //                         ),
                                          //                       ),
                                          //                     )
                                          //                   ],
                                          //                 ),
                                          //               ),
                                          //               Expanded(
                                          //                 child: Align(
                                          //                   alignment:
                                          //                       Alignment.topLeft,
                                          //                   child: FittedBox(
                                          //                     fit: BoxFit
                                          //                         .scaleDown,
                                          //                     child: CustomText(
                                          //                       'Products Available',
                                          //                       style: GoogleFonts
                                          //                           .roboto(
                                          //                         fontSize:
                                          //                             14.0.sp,
                                          //                         color: const Color(
                                          //                             0xFFA7A7A7),
                                          //                         fontWeight:
                                          //                             FontWeight
                                          //                                 .w500,
                                          //                       ),
                                          //                     ),
                                          //                   ),
                                          //                 ),
                                          //               )
                                          //             ],
                                          //           ),
                                          //         ),
                                          //       )
                                          //     ],
                                          //   ),
                                          // ),
                                          SizedBox(
                                            height: 5.sp,
                                          ),

                                          /// free shipping herer
                                          Container(
                                              padding: EdgeInsets.only(
                                                  left: 13.sp, right: 13.sp),
                                              height: 62.0.sp,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        5.0.sp),
                                                color: Colors.white,
                                              ),
                                              child: Container(
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        width: 35.sp,
                                                        height: 35.sp,
                                                        decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                                image: AssetImage(
                                                                    "images/freeShipping.png"),
                                                                fit: BoxFit
                                                                    .cover)),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10.sp,
                                                    ),
                                                    Expanded(
                                                      flex: 7,
                                                      child: CustomText(
                                                        "${parseHtmlString(freeShipping)}",
                                                        style:
                                                            Styles.robotoStyle(
                                                              FontWeight.normal,
                                                              12.0.sp,
                                                              const Color(0xFF363636),
                                                              context,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )),

                                          ///
                                          SizedBox(
                                            height: 25.sp,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .90,
                                            child: CustomText(
                                              'Διαθέσιμα κουπόνια',
                                              style: Styles.robotoStyle(
                                                FontWeight.w900,
                                                16.0.sp,
                                                const Color(0xFF363636),
                                                context,

                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.sp,
                                          ),
                                          Container(
                                            //35
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .5,
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    BouncingScrollPhysics(),
                                                itemCount: state.list.length,
                                                itemBuilder: (context, index) {
                                                  log("testing using ..... ${state.list[index].couponCode}");
                                                  return SizedBox(
                                                    height: 175.sp,
                                                    child: Stack(
                                                      children: [
                                                        CustomPaint(
                                                          size: Size(
                                                              1.sw,
                                                              (1.sw * 0.5)
                                                                  .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                                                          painter:
                                                              FillPainter(),
                                                          child: Container(
                                                            height: 145.sp,
                                                          ),
                                                        ),
                                                        CustomPaint(
                                                          size: Size(
                                                              1.sw,
                                                              (1.sw * 0.5)
                                                                  .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                                                          painter:
                                                              FillWithDot(),
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 30.sp,
                                                                    right:
                                                                        23.sp,
                                                                    top: 10.sp,
                                                                    bottom:
                                                                        10.sp),
                                                            height: 145.sp,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Expanded(
                                                                  flex: 3,
                                                                  child: Row(
                                                                    children: [
                                                                      //image
                                                                      Expanded(
                                                                        child:
                                                                            Align(
                                                                          alignment:
                                                                              Alignment.topCenter,
                                                                          child: couponImage == null
                                                                              ? Center(
                                                                                  child: CircularProgressIndicator(),
                                                                                )
                                                                              : FutureBuilder(
                                                                                  future: Future.delayed(Duration(milliseconds: 500)),
                                                                                  builder: (context, snap) {
                                                                                    return Container(
                                                                                      height: 70.0.sp,
                                                                                      decoration: BoxDecoration(
                                                                                          borderRadius: BorderRadius.circular(5.0),
                                                                                          // color: const Color(0xFFD00000),
                                                                                          image: DecorationImage(image: NetworkImage("$couponImage"))),
                                                                                    );
                                                                                  }),
                                                                        ),
                                                                      ),
                                                                      //title // description
                                                                      SizedBox(
                                                                          width:
                                                                              5),
                                                                      Expanded(
                                                                        flex: 3,
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            CustomText(
                                                                              '${state.list[index].title}',
                                                                              maxLines: 1,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: Styles.robotoStyle(
                                                                                FontWeight.w900,
                                                                                16.0.sp,
                                                                                const Color(0xFF07C4BC),
                                                                                context,
                                                                                //
                                                                                // fontSize: 16.0.sp,
                                                                                // color: const Color(0xFF07C4BC),
                                                                                // fontWeight: FontWeight.w900,
                                                                              ),
                                                                            ),
                                                                            SizedBox(height: 2),
                                                                            CustomText(
                                                                              '${state.list[index].description != "" ? state.list[index].description : ""}',
                                                                              maxLines: state.list[index].description.length > 40 ? 2 : 3,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: Styles.robotoStyle(
                                                                                FontWeight.w500,
                                                                                14.0.sp,
                                                                                Colors.black,
                                                                                context,

                                                                               // fontWeight: FontWeight.w500,
                                                                              ),
                                                                            ),
                                                                            //add in milstone 4
                                                                            // Expanded(
                                                                            //   child: Align(
                                                                            //     alignment: Alignment.topLeft,
                                                                            //     child: CustomText(
                                                                            //       '${couponCashBack.toString().split(" ")[0]}',
                                                                            //       style: Styles.robotoStyle(
                                                                            //         fontSize: 18.0,
                                                                            //         color: const Color(0xFFFC4F08),
                                                                            //         fontWeight: FontWeight.w900,
                                                                            //       ),
                                                                            //     ),
                                                                            //   ),
                                                                            // ),
                                                                            // Expanded(
                                                                            //   child: Align(
                                                                            //     alignment: Alignment.topLeft,
                                                                            //     child: CustomText(
                                                                            //       'Cashback up to',
                                                                            //       style: Styles.robotoStyle(
                                                                            //         fontSize: 12.0.sp,
                                                                            //         color: const Color(0xFFA7A7A7),
                                                                            //         fontWeight: FontWeight.w500,
                                                                            //       ),
                                                                            //     ),
                                                                            //   ),
                                                                            // ),
                                                                          ],
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                    flex: 2,
                                                                    child: // Group: Group 151
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Expanded(
                                                                              child: GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              if (widget.guest == true) {
                                                                                showLoaderDialog(context);
                                                                                // Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
                                                                              } else {
                                                                                HistoryService.callHistoryApi(id: widget.id);
                                                                                Navigator.push(context, MaterialPageRoute(builder: (_) => InAppWebView(url: state.list[index].redirectURL)));
                                                                              }
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              child: state.list[index].couponCode.isNotEmpty || state.list[index].couponCode != ''
                                                                                  ? Align(
                                                                                      alignment: Alignment.bottomLeft,
                                                                                      child: DottedBorder(
                                                                                        color: Color(0xFF07C4BC),
                                                                                        child: Container(
                                                                                          height: 35.0.sp,
                                                                                          decoration: BoxDecoration(
                                                                                            borderRadius: BorderRadius.circular(2.0),
                                                                                            // border: Border.all(
                                                                                            //   width: 2.0,
                                                                                            //   color: Color(0xFF07C4BC),
                                                                                            // ),
                                                                                          ),
                                                                                          child: Center(
                                                                                            child: CustomText(
                                                                                              '${state.list[index].couponCode} ',
                                                                                              style: Styles.robotoStyle(
                                                                                                FontWeight.w900,
                                                                                                14.0.sp,
                                                                                                Color(0xFF07C4BC),
                                                                                                context,
                                                                                              ),
                                                                                              textAlign: TextAlign.center,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    )
                                                                                  : Align(
                                                                                      alignment: Alignment.bottomLeft,
                                                                                      child: Container(
                                                                                        height: 35.0.sp,
                                                                                        decoration: BoxDecoration(
                                                                                          borderRadius: BorderRadius.circular(2.0),
                                                                                          border: Border.all(
                                                                                            width: 2.0,
                                                                                            color: Color(0xFFFC4F08),
                                                                                          ),
                                                                                        ),
                                                                                        child: Center(
                                                                                          child: CustomText(
                                                                                            '${state.list[index].offerType} ',
                                                                                            style: Styles.robotoStyle(
                                                                                              FontWeight.w900,
                                                                                              14.0.sp,
                                                                                              Color(0xFFFC4F08),
                                                                                              context,
                                                                                            ),
                                                                                            textAlign: TextAlign.center,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                            ),
                                                                          )),
                                                                          state.list[index].couponCode.isNotEmpty || state.list[index].couponCode != ''
                                                                              ? Expanded(
                                                                                  flex: 0,
                                                                                  child: GestureDetector(
                                                                                    onTap: () {
                                                                                      FlutterClipboard.copy(state.list[index].couponCode).then((v) {
                                                                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                          content: CustomText("copied"),
                                                                                          behavior: SnackBarBehavior.floating,
                                                                                          backgroundColor: Color(0xffFD4F08),
                                                                                          duration: Duration(milliseconds: 300),
                                                                                        ));
                                                                                      });
                                                                                    },
                                                                                    child: Container(
                                                                                      alignment: Alignment.bottomCenter,
                                                                                      padding: EdgeInsets.only(bottom: 10.sp),
                                                                                      height: 100.sp,
                                                                                      child: CustomText("  Tap to copy",
                                                                                          style: Styles.robotoStyle(
                                                                                            FontWeight.normal,
                                                                                            12.0.sp,
                                                                                            Color(0xffcccccc),
                                                                                            context,

                                                                                          )),
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                              : Container(),
                                                                          Expanded(
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Expanded(
                                                                                  flex: 2,
                                                                                  child: Align(
                                                                                    alignment: Alignment.bottomRight,
                                                                                    child: CustomText(
                                                                                      '${state.list[index].validTo.toString().split(" ")[0]}',
                                                                                      style: Styles.robotoStyle(
                                                                                        FontWeight.w900,
                                                                                        14.0.sp,
                                                                                        Color(0xFF363636),
                                                                                        context,

                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Expanded(
                                                                                  child: Align(
                                                                                    alignment: Alignment.bottomRight,
                                                                                    child: CustomText(
                                                                                      'Expiry Date',
                                                                                      style: Styles.robotoStyle(
                                                                                        FontWeight.w500,
                                                                                        12.0.sp,
                                                                                        Color(0xFFA7A7A7),
                                                                                        context,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    )),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                          ),
                                          SizedBox(
                                            height: 20.sp,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              )),
          bottomNavigationBar: _bottomBar(),
        ),
      ),
    );
  }

  Widget _bottomBar() {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .08,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => CashBackTerms(
                            desc: parseHtmlString(cashBackTermDesc),
                          )));
            },
            child: CustomText(
              "ΟΡΟΙ ΚΑΤΑΣΤΗΜΑΤΟΣ",
              style: Styles.robotoStyle(
                FontWeight.w900,
                14.0.sp,
               Colors.black,
                context,

              ),
            ),
          ),
          MaterialButton(
            onPressed: () async {
              if (widget.guest == false) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => InAppWebView(url: redirectURL)));
                // ! to store the number visit of store ...
                HistoryService.callHistoryApi(id: widget.id);
                // // ! it's a redirect url for the store ...
                // await launchUrl(Uri.parse("${redirectURL}"),
                //     mode: LaunchMode.inAppWebView);
              } else {
                showLoaderDialog(context);
              }
            },
            color: Color(0xffFD4F08),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 13.sp, horizontal: 15.sp),
              child: CustomText(
                "ΕΝΕΡΓΟΠΟΙΗΣΗ",
                style: Styles.robotoStyle(
                  FontWeight.w900,
                  14.0.sp,
                 Colors.white,
                  context,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      insetPadding: EdgeInsets.zero,
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.width * 0.78,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20),
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("images/logoutIcon.png"))),
            ),
            SizedBox(
              height: 20.h,
            ),
            const CustomText(
              "Δεν είστε συνδεδεμένος",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomText(
              "Για επιστροφή χρημάτων (cashback) θα πρέπει πρώτα να συνδεθείτε",
              // "Για επιστροφή χρημάτων (cashback) πρέπει να συνδεθείτ",
              style: TextStyle(fontSize: 12.sp, color: Colors.black),
            ),
            SizedBox(
              height: 1.h,
            ),
            Container(
              // color: Colors.red,
              width: 100.sh,
              child: CustomText(
                "Δεν είστε μέλος; Η εγγραφή είναι Δωρεάν",
                // "Δεν είστε μέλος; Δωρεάν Εγγραφή",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 12.sp, color: Colors.black),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    width: 145.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: const Color(0xffA7A7A7)),
                    child: const Center(
                      child: CustomText(
                        "Ακύρωση",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    await prefs.remove("token");
                    await prefs.remove("uid");
                    await prefs.remove("initial");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    width: 145.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppConstants.appDarkColor),
                    child: const Center(
                      child: CustomText("Σύνδεση",
                          // "ΑΠΟΣΥΝΔΕΣΗ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class FillPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path0 = Path();
    path0.moveTo(size.width, 0);
    path0.lineTo(size.width, size.height * 0.4042667);
    path0.quadraticBezierTo(size.width * 0.9340000, size.height * 0.3966667,
        size.width * 0.9317333, size.height * 0.5008000);
    path0.quadraticBezierTo(size.width * 0.9331667, size.height * 0.6042000,
        size.width, size.height * 0.5994667);
    path0.lineTo(size.width, size.height);
    path0.lineTo(0, size.height);
    path0.lineTo(0, size.height * 0.6000000);
    path0.quadraticBezierTo(size.width * 0.0695000, size.height * 0.5954667,
        size.width * 0.0696667, size.height * 0.4930667);
    path0.quadraticBezierTo(size.width * 0.0693333, size.height * 0.4000667, 0,
        size.height * 0.3923333);
    path0.lineTo(0, 0);
    path0.lineTo(size.width, 0);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class FillWithDot extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = Color(0xffCCCCCC)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.sp;

    Path path0 = Path();
    path0.moveTo(size.width, 0);
    path0.lineTo(size.width, size.height * 0.4042667);
    path0.quadraticBezierTo(size.width * 0.9340000, size.height * 0.3966667,
        size.width * 0.9317333, size.height * 0.5008000);
    path0.quadraticBezierTo(size.width * 0.9331667, size.height * 0.6042000,
        size.width, size.height * 0.5994667);
    path0.lineTo(size.width, size.height);
    path0.lineTo(0, size.height);
    path0.lineTo(0, size.height * 0.6000000);
    path0.quadraticBezierTo(size.width * 0.0695000, size.height * 0.5954667,
        size.width * 0.0696667, size.height * 0.4930667);
    path0.quadraticBezierTo(size.width * 0.0693333, size.height * 0.4000667, 0,
        size.height * 0.3923333);
    path0.lineTo(0, 0);
    path0.lineTo(size.width, 0);
    path0.close();

    canvas.drawPath(
        dashPath(
          path0,
          dashArray: CircularIntervalList<double>(<double>[15.0, 6]),
        ),
        paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
