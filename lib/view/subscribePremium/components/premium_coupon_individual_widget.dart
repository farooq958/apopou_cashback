import 'package:cashback/controller/premiumControllers/PremiumAllCoupons/addtofavouritepremium_cubit.dart';
import 'package:cashback/controller/premiumControllers/PremiumAllCoupons/all_coupon_premium_cubit.dart';
import 'package:cashback/controller/premiumControllers/PremiumAllCoupons/remove_favourite_premium_coupon_cubit.dart';
import 'package:cashback/controller/premiumControllers/Services/premium_controllers.dart';
import 'package:cashback/controller/premiumControllers/premium_favourite_cubit.dart';
import 'package:cashback/model/premium/coupon_model.dart';
import 'package:cashback/view/auth/login_screen.dart';
import 'package:cashback/view/custom_widgets/app_color.dart';
import 'package:cashback/view/custom_widgets/snack_bar.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:cashback/view/subscribePremium/components/premium_coupon_shape.dart';
import 'package:cashback/view/subscribePremium/premiumHome/premium_individual_coupon_detail.dart';
import 'package:cashback/view/subscribePremium/subscribe_premium.dart';
import 'package:flutter/material.dart';
import 'package:cashback/view/subscribePremium/premiumHome/premium_coupon_detail.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:pull_to_refresh/src/smart_refresher.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:cashback/view/imports.dart';

import '../../../model/premium/all_coupon_model.dart';

class PremiumCouponIndividualWidget extends StatefulWidget {
  var model;
  bool guest;
  bool isFavParent;
  int index;
  String check;
  RefreshController controller;
  bool isPremium;
  int pageNo = 0;
  String? premiumCheck;

  PremiumCouponIndividualWidget({
    Key? key,
    required this.model, required this.guest,required this.isFavParent,required this.index,required this.check, required this.controller, required this.isPremium
  ,this.premiumCheck}) : super(key: key);

  @override
  State<PremiumCouponIndividualWidget> createState() => _PremiumCouponIndividualWidgetState();
}

class _PremiumCouponIndividualWidgetState extends State<PremiumCouponIndividualWidget> {
@override
  void initState() {

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // bool isFav = widget.isFavParent;
    //print(isFav);
    return ClipPath(
      clipper: PremiumCouponShape(right: 205, holeRadius: 29),
      child: DottedBorder(
        color: Color(0xffCCCCCC),
        borderType: BorderType.RRect,
        radius: Radius.circular(10),
        strokeWidth: 3,
        dashPattern: [7, 2],
        child: ClipPath(
          clipper: PremiumCouponShape(right: 205, holeRadius: 22),
          child: Container(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: 10,
            ).r,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            width: double.infinity,
            height: MediaQuery
                .of(context)
                .size
                .height * 0.18,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10).r,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 75.0.sp,
                        height: 75.0.sp,
                        margin: const EdgeInsets.only(bottom: 5).r,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Image.network(widget.model.retailerImg),
                      ),
                      FittedBox(
                        child: CustomText(
                          widget.model.retailerName,
                          textAlign: TextAlign.center,
                          style: Styles.robotoStyle2(
                            fontSize: 13.0.sp,
                            color: const Color(0xFF363636),
                            fontWeight: FontWeight.w600, context: context,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20.sp,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: CustomText(
                            widget.model.retailerName,
                            style: Styles.robotoStyle2(
                              fontSize: 16.sp,
                              color: const Color(0xFF363636),
                              fontWeight: FontWeight.w700, context: context,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            if (widget.guest == true) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ));

                            }
                            else if(widget.premiumCheck == '1'){
                              if(widget.isPremium==false){

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SubscribePremiumScreen(),
                                    ));

                              }
                              else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PremiumCouponDetail(data: widget.model),
                                    ));
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
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: Radius
                                  .circular(20.sp)
                                  .r,
                              padding: EdgeInsets.zero,
                              color: Color(0xff07c4bc),
                              strokeWidth: 1,
                              dashPattern: [6, 3],
                              child: Container(
                                width: 144.w,
                                height: 35.h,
                                // padding: EdgeInsets.symmetric(
                                //         horizontal: 28, vertical: 8)
                                //     .r,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius
                                      .circular(20.sp)
                                      .r,
                                  color: Color(0xff07c4bc).withOpacity(0.1),
                                ),
                                child: Center(
                                  child: CustomText(
                                    "COUPON DETAIL",
                                    style: Styles.robotoStyle2(
                                      color: Color(0xff07c4bc),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700, context: context,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // BlocListener<AddToFavouritePremiumCubit, String>(
                //   listener: (context, state) {
                //     // TODO: implement listener
                //
                //
                //     if (state == "success") {
                //       // Snackbar.showSnack(
                //       //
                //       //     context: context,
                //       //     message: addToFavouriteMessageController);
                //
                //       print(addToFavouriteMessageController);
                //     }
                //     if (state == "internetError") {
                //       Snackbar.showSnack(
                //
                //           context: context, message: 'NoInternet');
                //     }
                //     if (state == "unknownError") {
                //       Snackbar.showSnack(
                //
                //           context: context, message: 'Something Went Wrong');
                //     }
                //   },
                //   child: BlocListener<RemoveFavouritePremiumCouponCubit, String>(
                //     listener: (context, state) {
                //       // TODO: implement listener
                //       if (state == "success") {
                //         // Snackbar.showSnack(
                //         //
                //         //     context: context,
                //         //     message: removeFromFavouriteMessageController);
                //         print(removeFromFavouriteMessageController);
                //       }
                //       if (state == "internetError") {
                //         Snackbar.showSnack(
                //
                //             context: context, message: 'NoInternet');
                //       }
                //       if (state == "unknownError") {
                //         Snackbar.showSnack(
                //
                //             context: context, message: 'Something Went Wrong');
                //       }
                //     },
                //     child: Align(
                //       alignment: Alignment.topRight,
                //       child:
                //       InkWell(
                //         onTap: () async {
                //           if (widget.guest == true) {
                //
                //
                //             Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                   builder: (context) => LoginScreen(),
                //                 ));
                //
                //           }
                //           // else if(widget.isPremium==false){
                //           //
                //           //   Navigator.push(
                //           //       context,
                //           //       MaterialPageRoute(
                //           //         builder: (context) => SubscribePremiumScreen(),
                //           //       ));
                //           //
                //           // }
                //           else {
                //             if (widget.isFavParent == false) {
                //               setState(() {
                //                 widget.isFavParent = true;
                //               });
                //
                //               // await context.read<AddToFavouritePremiumCubit>()
                //               //     .addPremiumCoupon(widget.model.identifier);
                //               // print(widget.check);
                //               // context
                //               //     .read<AllCouponPremiumCubit>()
                //               //     .loadPremiumMainData(1, "",widget.check,widget.guest).whenComplete(() {
                //               //   //  widget.controller.requestRefresh();
                //               //   setState(() {});
                //               // });
                //               // await     widget.controller.requestRefresh(needMove: false);
                //               // if(widget.check=='fromall')
                //               //   {
                //               //     context
                //               //         .read<AllCouponPremiumCubit>()
                //               //         .loadPremiumMainData(1, "",widget.check);
                //               //   }
                //             }
                //             else {
                //
                //
                //               setState(() {
                //                 widget.isFavParent = false;
                //               });
                //               // await context.read<RemoveFavouritePremiumCouponCubit>()
                //               //     .removePremiumCoupon(widget.model.identifier);
                //               // widget.controller.requestRefresh(needMove: false);
                //               // if(widget.check=="fromfav") {
                //               //   setState(() {
                //               //     print("here");
                //               //     print(allCouponPremiumController.data.length);
                //               //     allCouponPremiumController.data.removeAt(widget.index);
                //               //     print(allCouponPremiumController.data.length);
                //               //   });
                //               //
                //               //   await context
                //               //       .read<AllCouponPremiumCubit>()
                //               //       .loadPremiumMainData(1, "",widget.check,widget.guest).whenComplete(() {
                //               //     //  widget.controller.requestRefresh();
                //               //     setState(() {});
                //               //   });
                //               //   await  widget.controller.requestRefresh(needMove: false);
                //               //
                //               //
                //               // }
                //
                //
                //
                //
                //             }
                //             setState(() {
                //
                //             });
                //           }
                //         },
                //         child: Icon(
                //           widget.isFavParent == true ? Icons.favorite : Icons
                //               .favorite_outline_outlined,
                //           color: widget.isFavParent == true ? AppColor.redColor : AppColor
                //               .primaryColor,
                //         ),
                //       ),
                //
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}