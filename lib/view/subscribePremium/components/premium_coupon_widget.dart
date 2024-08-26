import 'package:cashback/controller/premiumControllers/PremiumAllCoupons/addtofavouritepremium_cubit.dart';
import 'package:cashback/controller/premiumControllers/PremiumAllCoupons/all_coupon_premium_cubit.dart';
import 'package:cashback/controller/premiumControllers/PremiumAllCoupons/remove_favourite_premium_coupon_cubit.dart';
import 'package:cashback/controller/premiumControllers/Services/premium_controllers.dart';
import 'package:cashback/controller/premiumControllers/premium_favourite_cubit.dart';
import 'package:cashback/model/premium/coupon_model.dart';
import 'package:cashback/view/custom_widgets/image_widgets.dart';
import 'package:cashback/view/imports.dart';
import 'package:cashback/view/auth/login_screen.dart';
import 'package:cashback/view/custom_widgets/app_color.dart';
import 'package:cashback/view/custom_widgets/snack_bar.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:cashback/view/subscribePremium/components/image_widget.dart';
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

import '../../../model/premium/all_coupon_model.dart';

class PremiumCouponWidget extends StatefulWidget {
  HiddenAttrModel model;
  bool guest;
  bool isFavParent;
  int index;
  String check;
  RefreshController controller;
  bool isPremium;
  String premiumCheck;
  final void Function(String) onFromFavTap;

  PremiumCouponWidget({
    Key? key,
    required this.model, required this.guest,required this.isFavParent,required this.index,required this.check, required this.controller, required this.isPremium, required this.premiumCheck, required this.onFromFavTap
  }) : super(key: key);

  @override
  State<PremiumCouponWidget> createState() => _PremiumCouponWidgetState();
}

class _PremiumCouponWidgetState extends State<PremiumCouponWidget> {


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
                       TouchableOpacity(
                         onTap:(){
                           ///widget.model.identifier
                         //  context.read<AllCouponPremiumCubit>().loadPremiumMainData(0, widget.model.store_id, "fromindividual",widget.guest,"fromnottap");

                           // Navigator.push(context, MaterialPageRoute(builder: (context)=>PremiumIndividualCouponDetail(isFavParent:widget.isFavParent,
                           //   premiumCheck:widget.premiumCheck,
                           //   data:widget.model, isPremium: widget.isPremium, guest: widget.guest, controller: widget.controller,)));
                           
                           
          },
                        child: Container(
                          width: 75.0.sp,
                          height: 75.0.sp,
                          margin: const EdgeInsets.only(bottom: 5).r,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: CachedImage(url: widget.model.retailerImg,isCircle: false,),
                        ),
                      ),

                      widget.model.retailerName ==""?
                      CustomText(
                        widget.model.retailerName,
                        textAlign: TextAlign.center,
                        style: Styles.robotoStyle2(
                          fontSize: 13.0.sp,
                          color: const Color(0xFF363636),
                          fontWeight: FontWeight.w600, context: context,
                        ),
                      )
                          :
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
                          alignment: Alignment.center,
                          child: CustomText(
                            widget.model.title ?? "",
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
                            // else if(widget.premiumCheck == '2')
                            // {
                            //   Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (context) =>
                            //             PremiumCouponDetail(data: widget.model),
                            //       ));
                            // }

                            ///issue to be resolve here
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
                                ///premium coupon disabled
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
                                    style: TextStyle(
                                      color: Color(0xff07c4bc),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
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
                BlocListener<AddToFavouritePremiumCubit, String>(
                  listener: (context, state) {
                    // TODO: implement listener


                    if (state == "success") {
                      // Snackbar.showSnack(
                      //
                      //     context: context,
                      //     message: addToFavouriteMessageController);

                      print(addToFavouriteMessageController);
                    }
                    if (state == "internetError") {
                      Snackbar.showSnack(

                          context: context, message: 'NoInternet');
                    }
                    if (state == "unknownError") {
                      Snackbar.showSnack(

                          context: context, message: 'Something Went Wrong');
                    }
                  },
                  child: BlocListener<RemoveFavouritePremiumCouponCubit, String>(
                    listener: (context, state) {
                      // TODO: implement listener
                      if (state == "success") {
                        // Snackbar.showSnack(
                        //
                        //     context: context,
                        //     message: removeFromFavouriteMessageController);
print(removeFromFavouriteMessageController);
                      }
                      if (state == "internetError") {
                        Snackbar.showSnack(

                            context: context, message: 'NoInternet');
                      }
                      if (state == "unknownError") {
                        Snackbar.showSnack(

                            context: context, message: 'Something Went Wrong');
                      }
                    },
                    child: Align(
                      alignment: Alignment.topRight,
                      child:
                      InkWell(
                        onTap: () async {
                          if (widget.guest == true) {


                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ));

                          }
                        
                          else {
                            if (widget.model.isFav == false) {
                              setState(() {
                                widget.isFavParent = true;
                                widget.model.isFav=true;
                              });

                             await context.read<AddToFavouritePremiumCubit>()
                                  .addPremiumCoupon(widget.model.identifier);
                              print(widget.check);
                                  // context
                                  //     .read<AllCouponPremiumCubit>()
                                  //     .loadPremiumMainData(1, "",widget.check,widget.guest,"fromn").whenComplete(() {
                                  // //  widget.controller.requestRefresh();
                                  //   setState(() {});
                                  // });
                     ///  await     widget.controller.requestRefresh(needMove: false);
                              // if(widget.check=='fromall')
                              //   {
                              //     context
                              //         .read<AllCouponPremiumCubit>()
                              //         .loadPremiumMainData(1, "",widget.check);
                              //   }
                            }
                            else {


                            setState(() {
                              widget.isFavParent = false;
                              widget.model.isFav=false;
                            });
                             await context.read<RemoveFavouritePremiumCouponCubit>()
                                  .removePremiumCoupon(widget.model.identifier);
                            //  widget.controller.requestRefresh(needMove: false);
if(widget.check=="fromfav") {
 // setState(() {
 //   print("here");
 //   print(allCouponPremiumController.data.length);
 //   allCouponPremiumController.data.removeAt(widget.index);
 //   print(allCouponPremiumController.data.length);
 // });

//   await context
//       .read<AllCouponPremiumCubit>()
//       .loadPremiumMainData(1, "",widget.check,widget.guest,"fromn").whenComplete(() {
//      //  widget.controller.requestRefresh();
//      setState(() {});
//    });
// await  widget.controller.requestRefresh(needMove: false);

widget.onFromFavTap('fromfav');

}




                            }
                            // setState(() {
                            //
                            // });
                          }
                        },
                        child: Icon(
                          widget.model.isFav == true ? Icons.favorite : Icons
                              .favorite_outline_outlined,
                          color: widget.model.isFav == true ? AppColor.redColor : AppColor
                              .primaryColor,
                        ),
                      ),

                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
