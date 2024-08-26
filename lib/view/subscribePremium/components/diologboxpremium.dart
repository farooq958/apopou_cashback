import 'dart:developer';
import 'package:cashback/view/imports.dart';
import 'package:cashback/controller/VivaWallet/unsubscribe_premium_cubit.dart';
import 'package:cashback/view/custom_widgets/app_color.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PremiumDialogBox extends StatelessWidget {
  const PremiumDialogBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
              Radius.circular(10.0.r))),
      insetPadding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context)
              .size
              .height *
              0.29,
          horizontal: MediaQuery.of(context)
              .size
              .width *
              0.04),
      child: Padding(
        padding: const EdgeInsets.only(
            left: 8.0, right: 8.0, top: 40,bottom: 20),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
                'images/premiumDialogIcon.svg'),
          SizedBox(height: 15.sp,),
            Padding(
              padding: EdgeInsets.only(left: 20.sp),
              child: CustomText(
                "Είστε βέβαιοι ότι θέλετε να καταργήσετε την εγγραφή σας!",
                style:   Styles.robotoStyle2(
                  fontSize: 22.sp,
                  color: AppColor.blackColor, context: context
                ),
              ),
            ),


            Expanded(
              
              child: Row(
                children: [
                  SizedBox(width: 20.sp,),
                  Expanded(
                    child: Align(
                      child:  SizedBox(
                        height: 50.sp,
                        width: 130.sp,
                        child: ElevatedButton(onPressed: () {
                          log("cancel tapped");
                         Navigator.pop(context);

                        },
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColor.greyColor),),
                          child:
                        CustomText(
                            "Cancel "



                            ),),
                      ),
                    ),
                  ),
                  SizedBox(width: 20.sp,),
                   Expanded(

                     child: Align(

                       child: SizedBox(
                         height: 50.sp,
                         width: 130.sp,
                         child: ElevatedButton(
                           style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColor.primaryColor)),
                           onPressed: () async {
                              log("Yes tapped");
                              log(context.toString());
                             await context.read<UnsubscribePremiumCubit>().unSubscribeFromPremium();
                         Navigator.pop(context);


                           }, child:
                  CustomText(
                            "Yes"

                  ),),
                       ),
                     ),
                   ),
                  SizedBox(width: 20.sp,),
                ],
              ),
                // child: GuestShow(
                //   title: null,
                //   padding: EdgeInsets.symmetric(
                //     horizontal: 20,
                //   ),
                //   height: 160,
                //   width: double.maxFinite,
                // )),
            )
          ],
        ),
      ),
    );
  }
}