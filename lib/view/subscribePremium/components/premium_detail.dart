import 'package:cashback/controller/VivaWallet/wallet_url_cubit.dart';
import 'package:cashback/view/custom_widgets/app_color.dart';
import 'package:cashback/view/custom_widgets/custom_button.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:cashback/view/subscribePremium/components/dotted_price.dart';
import 'package:cashback/view/subscribePremium/components/premium_tile.dart';
import 'package:cashback/view/subscribePremium/payment_method_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cashback/view/imports.dart';

class PremiumDetail extends StatefulWidget {
  const PremiumDetail({Key? key}) : super(key: key);

  @override
  State<PremiumDetail> createState() => _PremiumDetailState();
}

class _PremiumDetailState extends State<PremiumDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 22,
      ).r,
      margin: const EdgeInsets.only(bottom: 15).r,
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 4,
            blurRadius: 10,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15).r,
            child: CustomText(
              "When you become a premium member will get access to:".tr(),
              style: Styles.robotoStyle(
                FontWeight.w500,
                17,
                AppColor.blackColor,context
              ),
            ),
          ),
          PremiumTile(text: "Get premium coupon"),
          SizedBox(height: 10.sp,),
          PremiumTile(text: "Shop with premium coupon"),
          SizedBox(height: 10.sp,),
          PremiumTile(text: "Μηδενική χρέωση στην ανάληψη χρημάτων"),
          SizedBox(height: 10.sp,),
          // PremiumTile(text: "Get premium coupon"),
          // PremiumTile(text: "Shop with premium coupon"),
          // PremiumTile(text: "Get premium coupon"),
          // PremiumTile(text: "Shop with premium coupon"),
          // PremiumTile(text: "Get premium coupon"),
          // PremiumTile(text: "Shop with premium coupon", bPadding: 30),
          DottedPrice(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PaymentMethodScreen(),
                ),);
              context.read<WalletUrlCubit>().getWalletUrl();
            },
            behavior: HitTestBehavior.opaque,
            child: CustomButton(
              title: "Become Premium".tr(),
            ),
          ),
        ],
      ),
    );
  }
}
