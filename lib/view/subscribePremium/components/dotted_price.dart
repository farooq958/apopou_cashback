
import 'package:cashback/controller/shared_preferences.dart';
import 'package:cashback/view/custom_widgets/app_color.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../controller/SubscriptionAmount/services/subscription_amount_controller.dart';
import '../../../controller/SubscriptionAmount/subscription_amount_cubit.dart';

import 'package:cashback/view/imports.dart';
class DottedPrice extends StatefulWidget {
  const DottedPrice({Key? key}) : super(key: key);

  @override
  State<DottedPrice> createState() => _DottedPriceState();
}

class _DottedPriceState extends State<DottedPrice> {
  String currency = "";

  Future currencyGet() async {
    var c = await CurrencyPrefs.getCurrency();
    setState(() {
      currency = c;
    });
  }

  @override
  void initState() {
    currencyGet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubscriptionAmountCubit, SubscriptionAmountState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        print(subscriptionAmountController.data);
        return Padding(
          padding: const EdgeInsets.only(bottom: 16).r,
          child: Column(
            children: [
              DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(12),
                padding: const EdgeInsets.symmetric(vertical: 24).r,
                color: AppColor.primaryColor,
                strokeWidth: 1,
                dashPattern: [6, 3],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                   state is SubscriptionAmountLoaded?

                    CustomText(
                      "$currency ${ subscriptionAmountController.data}",
                      style: Styles.robotoStyle(
                        FontWeight.w600,
                        26.sp,
                        AppColor.blackColor,context
                      ),
                    ) :    CustomText(
                     "$currency ${subscriptionAmountController.data}",
                     style: Styles.robotoStyle(
                       FontWeight.w600,
                       26.sp,
                       AppColor.blackColor,context
                     ),
                   ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3).r,
                      child: CustomText(
                        "/${"month".tr()}",
                        style: Styles.robotoStyle(
                          FontWeight.w600,
                          15.sp,
                          AppColor.blackColor,context
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                  bottom: 25,
                ).r,
                child:


                CustomText(
                  "$currency ${subscriptionAmountController.data} ${"will be charged each month and can be cancel anytime".tr()}",
                  textAlign: TextAlign.center,
                  style: Styles.robotoStyle(
                    FontWeight.w400,
                    15.sp,
                    AppColor.lightBlackColor,context
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
