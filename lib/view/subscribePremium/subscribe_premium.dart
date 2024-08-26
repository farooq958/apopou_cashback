import 'package:cashback/controller/SubscriptionAmount/subscription_amount_cubit.dart';
import 'package:cashback/view/custom_widgets/app_bar.dart';
import 'package:cashback/view/custom_widgets/app_color.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:cashback/view/subscribePremium/components/premium_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SubscribePremiumScreen extends StatefulWidget {
  const SubscribePremiumScreen({Key? key}) : super(key: key);

  @override
  State<SubscribePremiumScreen> createState() => _SubscribePremiumScreenState();
}

class _SubscribePremiumScreenState extends State<SubscribePremiumScreen> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<SubscriptionAmountCubit>().getSubscriptionAmountData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12).r,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                AppBarWidget(text: "Become Premium Member"),
                SizedBox(height: 10.sp,),
                PremiumDetail(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
