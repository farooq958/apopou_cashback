import 'package:cashback/view/imports.dart';
import 'package:cashback/controller/AppConstants.dart';
import 'package:cashback/controller/premiumControllers/PremiumAllCoupons/addtofavouritepremium_cubit.dart';
import 'package:cashback/controller/premiumControllers/PremiumAllCoupons/all_coupon_premium_cubit.dart';
import 'package:cashback/controller/premiumControllers/PremiumAllCoupons/remove_favourite_premium_coupon_cubit.dart';
import 'package:cashback/controller/premiumControllers/Services/premium_controllers.dart';
import 'package:cashback/view/auth/login_screen.dart';
import 'package:cashback/view/custom_widgets/app_color.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:cashback/view/subscribePremium/components/premium_coupon_individual_widget.dart';
import 'package:cashback/view/subscribePremium/components/premium_coupon_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class PremiumIndividualCouponDetail extends StatefulWidget {
  bool isFavParent;
  RefreshController controller;
  final data;
  final bool isPremium;
  final bool guest;
   final String? premiumCheck;
  int pageNo = 0;
  PremiumIndividualCouponDetail(
      {Key? key,
      required this.isFavParent,
      required this.data,
      required this.isPremium,
      required this.guest,
      required this.controller, this.premiumCheck})
      : super(key: key);

  @override
  State<PremiumIndividualCouponDetail> createState() =>
      _PremiumIndividualCouponDetailState();
}

class _PremiumIndividualCouponDetailState
    extends State<PremiumIndividualCouponDetail> {
  var refreshControllerPremiumIndividual =
      new RefreshController(initialRefresh: true);
  @override
  void initState() {
    print("object");
    print(widget.data.identifier);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          await widget.controller.requestRefresh(needMove: false);
          return true;
        },
        child: SafeArea(
            child: Scaffold(
                backgroundColor: Color(0xffEFEEEE),
                body: Container(
                    margin: AppConstants.screenPadding,
                    width: 1.sw,
                    height: 1.sh,
                    child: Stack(children: [
                      Positioned(
                        left: 0,
                        top: 20.sp,
                        child: SizedBox(
                          height: 25.sp,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () async {
                                //widget.getFavouriteState();

                                // context
                                //     .read<AllCouponPremiumCubit>()
                                //     .loadPremiumMainData(1, "","fromall",widget.guest).whenComplete(() {
                                //   //  widget.controller.requestRefresh();
                                //   setState(() {});
                                // });
                                Navigator.pop(context, true);
                                await widget.controller
                                    .requestRefresh(needMove: false);
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
                            //height: 150.h,
                            child: ListView(
                              //shrinkWrap: true,
                              //physics: NeverScrollableScrollPhysics(),
                              children: [
                                ///upper design name image
                                SizedBox(
                                  height: 100.sp,
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Stack(children: [
                                          FadeInImage(
                                            height: 90.h,
                                            width: 90.w,
                                            placeholder: AssetImage(
                                                "images/no_store.png"),
                                            image: NetworkImage(
                                                widget.data.retailerImg),
                                            fit: BoxFit.cover,
                                            imageErrorBuilder:
                                                (context, error, stackTrace) {
                                              return Image.asset(
                                                height: 90.h,
                                                width: 90.w,
                                                "images/no_store.png",
                                                fit: BoxFit.fill,
                                              );
                                            },
                                          ),
                                          Positioned(
                                            right: 2.sp,
                                            bottom: 2.sp,
                                            child: TouchableOpacity(
                                              onTap: () async {
                                                if (widget.guest == true) {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            LoginScreen(),
                                                      ));
                                                } else {
                                                  if (widget.isFavParent ==
                                                      false) {
                                                    setState(() {
                                                      widget.isFavParent = true;
                                                    });

                                                    await context
                                                        .read<
                                                            AddToFavouritePremiumCubit>()
                                                        .addPremiumCoupon(widget
                                                            .data.identifier);
                                                    // print(widget.check);

                                                    //    await     widget.controller.requestRefresh(needMove: false);
                                                    // if(widget.check=='fromall')
                                                    //   {
                                                    //     context
                                                    //         .read<AllCouponPremiumCubit>()
                                                    //         .loadPremiumMainData(1, "",widget.check);
                                                    //   }
                                                  } else {
                                                    setState(() {
                                                      widget.isFavParent =
                                                          false;
                                                    });
                                                    await context
                                                        .read<
                                                            RemoveFavouritePremiumCouponCubit>()
                                                        .removePremiumCoupon(
                                                            widget.data
                                                                .identifier);
                                                    //  widget.controller.requestRefresh(needMove: false);
                                                    // if(widget.check=="fromfav") {
                                                    //   setState(() {
                                                    //     print("here");
                                                    //     print(allCouponPremiumController.data.length);
                                                    //     allCouponPremiumController.data.removeAt(widget.index);
                                                    //     print(allCouponPremiumController.data.length);
                                                    //   });
                                                    //
                                                    //   await context
                                                    //       .read<AllCouponPremiumCubit>()
                                                    //       .loadPremiumMainData(1, "",widget.check,widget.guest).whenComplete(() {
                                                    //     //  widget.controller.requestRefresh();
                                                    //     setState(() {});
                                                    //   });
                                                    //   await  widget.controller.requestRefresh(needMove: false);
                                                    //
                                                    //
                                                    // }
                                                  }
                                                  setState(() {});
                                                }
                                              },
                                              child: Icon(
                                                Icons.favorite,
                                                color:
                                                    widget.isFavParent == true
                                                        ? AppColor.redColor
                                                        : AppColor.greyColor,
                                              ),
                                            ),
                                          ),
                                        ]),
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
                                            widget.data.retailerName.isEmpty
                                                ? Container()
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 5,
                                                    ).r,
                                                    child: CustomText(
                                                      '${widget.data.retailerName.toString()}',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style:
                                                          Styles.robotoStyle2(
                                                        fontSize: 17.sp,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        context: context,
                                                      ),
                                                    ),
                                                  ),
                                            SizedBox(height: 8.h),
                                            widget.data.title.isEmpty
                                                ? Container()
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 5,
                                                    ).r,
                                                    child: CustomText(
                                                      '${widget.data.title}',
                                                      maxLines: 2,
                                                      textAlign:
                                                          TextAlign.start,
                                                      style:
                                                          Styles.robotoStyle2(
                                                        color: const Color(
                                                            0xFFFC4F08),
                                                        fontSize: 17.sp,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        context: context,
                                                      ),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20.sp,
                                ),

                                ///Disclaimer container
                                Container(
                                    padding: EdgeInsets.only(
                                        left: 13.sp, right: 13.sp),
                                    height: 62.0.sp,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(5.0.sp),
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
                                                    "images/info_icon.png"),
                                                fit: BoxFit.fill,
                                              )),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.sp,
                                          ),

                                          ///disclaimer info
                                          Expanded(
                                            flex: 7,
                                            child: CustomText(
                                              widget.data.description,
                                              style: Styles.robotoStyle2(
                                                fontSize: 12.0.sp,
                                                color: const Color(0xFF363636),
                                                fontWeight: FontWeight.normal,
                                                context: context,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                SizedBox(
                                  height: 10.sp,
                                ),

                                ///data main list data individual
                                BlocBuilder<AllCouponPremiumCubit,
                                    AllCouponPremiumState>(
                                  builder: (context, state) {
                                    if (state is AllCouponPremiumLoading) {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color: AppColor.primaryColor,
                                        ),
                                      );
                                    } else if (state
                                        is AllCouponPremiumLoaded) {
                                      print('lenth of data premium');
                                      print(allCouponPremiumController.data.length);
                                      return Container(
                                        // color: AppColor.primaryColor,
                                        height: 1.sh,
                                        width: 1.sw,
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: SmartRefresher(
                                                  controller:
                                                      refreshControllerPremiumIndividual,
                                                  physics:
                                                      ClampingScrollPhysics(),
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  enablePullUp: true,
                                                  reverse: false,
                                                  onRefresh: () async {
                                                    refreshControllerPremiumIndividual
                                                        .requestRefresh();

                                                    /// widget.data.identifier
                                                    var result = context
                                                        .read<
                                                            AllCouponPremiumCubit>()
                                                        .loadPremiumMainData(
                                                            0,
                                                            widget.data
                                                                .store_id,
                                                            "fromindividual",
                                                            widget.guest,
                                                            "fromnottap");
                                                    if (await result == 200) {
                                                      refreshControllerPremiumIndividual
                                                          .refreshCompleted();
                                                    } else {
                                                      refreshControllerPremiumIndividual
                                                          .loadNoData();
                                                    }
                                                  },
                                                  child:
                                                      allCouponPremiumController
                                                              .data.isEmpty
                                                          ? ListView(
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                              shrinkWrap: true,
                                                              children: [
                                                                Center(
                                                                    child:
                                                                        Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              20.r),
                                                                  child: CustomText(
                                                                      "No data available"
                                                                          .tr(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: Styles
                                                                          .robotoStyle2(
                                                                        fontSize:
                                                                            18.0.sp,
                                                                        color: AppColor
                                                                            .primaryColor,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        context:
                                                                            context,
                                                                      )),
                                                                )),
                                                              ],
                                                            )
                                                          : ListView.separated(
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                              shrinkWrap: true,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                return PremiumCouponIndividualWidget(
                                                                    controller:
                                                                        refreshControllerPremiumIndividual,
                                                                    model: allCouponPremiumController
                                                                            .data[
                                                                        index],
                                                                    index:
                                                                        index,
                                                                    guest: widget
                                                                        .guest,
                                                                    isFavParent:
                                                                        false,
                                                                    check:
                                                                        "test",
                                                                    premiumCheck: widget.premiumCheck,
                                                                    isPremium:
                                                                        widget
                                                                            .isPremium);
                                                              },
                                                              separatorBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      int index) {
                                                                return SizedBox(
                                                                  height: 5.sp,
                                                                );
                                                              },
                                                              itemCount:
                                                                  allCouponPremiumController
                                                                      .data
                                                                      .length,
                                                            )),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      return Expanded(
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: AppColor.primaryColor,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 10.sp,
                                ),
                              ],
                            ),
                          ))
                    ])))));
  }
}
