import 'package:cashback/controller/balanceCubit/balance_cubit.dart';
import 'package:cashback/view/balance/transection_history.dart';
import 'package:cashback/view/withdraw/withdraw_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controller/shared_preferences.dart';
import '../custom_widgets/app_color.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:cashback/view/imports.dart';

class MyBalanceScreen extends StatefulWidget {
  const MyBalanceScreen({super.key});

  @override
  State<MyBalanceScreen> createState() => _MyBalanceScreenState();
}

class _MyBalanceScreenState extends State<MyBalanceScreen> {
  String currency = "";

  @override
  void initState() {
    currencyGet();
    Future.wait([
      context.read<BalanceCubit>().getBalance(),
    ]);
    super.initState();
  }

  Future currencyGet() async {
    var c = await CurrencyPrefs.getCurrency();
    setState(() {
      currency = c;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12).r,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textAndBack(context),
              BlocBuilder<BalanceCubit, BalanceState>(
                builder: (context, state) {
                  if (state.status == BalanceStatus.loading) {
                    return Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColor.primaryColor,
                        ),
                      ),
                    );
                  }
                  return SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        withDrawCardWidget(state),
                        space(10),
                        allTabs(state),
                        space(25),
                        transectionHistoryButton(),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget transectionHistoryButton() {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TransectionHistoryScreen(
            tabText: "",
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            "Transection History".tr(),
            style: Styles.robotoStyle(
              FontWeight.bold,
              26.sp,
              AppColor.lightBlackColor,context
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: AppColor.lightBlackColor,
            size: 27.r,
          ),
        ],
      ),
    );
  }

  Widget allTabs(BalanceState state) {
    return Column(
      children: [
        buildListTile(
          imageUrl: "images/available.png",
          title: "Confirm Amount".tr(),
          amountText: "$currency ${state.model.confirmPayments.toString()}",
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TransectionHistoryScreen(
                tabText: "confirmed",
              ),
            ),
          ),
        ),
        space(10),
        buildListTile(
          imageUrl: "images/pending.png",
          title: "Pending Cashback".tr(),
          amountText: "$currency ${state.model.pendingBalance.toString()}",
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TransectionHistoryScreen(
                tabText: "pending",
              ),
            ),
          ),
        ),
        space(10),
        buildListTile(
          imageUrl: "images/decline.png",
          title: "Declined Amount".tr(),
          amountText: "$currency ${state.model.declineBalance.toString()}",
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TransectionHistoryScreen(
                tabText: "declined",
              ),
            ),
          ),
        ),
        space(10),
        buildListTile(
          imageUrl: "images/pendingPayments.png",
          title: "Pending Payments".tr(),
          amountText: "$currency ${state.model.pendingPayments.toString()}",
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TransectionHistoryScreen(
                tabText: "request",
              ),
            ),
          ),
        ),
        space(10),
        buildListTile(
          imageUrl: "images/withdraw.png",
          title: "Withdrawn Amount".tr(),
          amountText: "$currency ${state.model.WithdrawnAmount.toString()}",
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TransectionHistoryScreen(
                tabText: "paid",
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget withDrawCardWidget(BalanceState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20).r,
      margin: const EdgeInsets.symmetric(vertical: 5).r,
      decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(10).r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                "$currency ${state.model.totalBalance}",
                // "$currency ${state.model.totalBalance == 0 ? 0 : state.model.totalBalance!.round()}",
                style: Styles.robotoStyle(
                  FontWeight.bold,
                  37,
                  AppColor.primaryColor,context
                ),
              ),
            ],
          ),
          space(2),
          CustomText(
            "Available Balance".tr(),
            style: Styles.robotoStyle(
              FontWeight.w500,
              15,
              AppColor.blackColor,context
            ),
          ),
          space(15),
          InkWell(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => WithDrawScreen())),
            child: Container(
              width: 200.w,
              height: 45.h,
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(10).r,
              ),
              child: Center(
                child: CustomText(
                  "Withdraw".tr(),
                  style: Styles.robotoStyle(
                    FontWeight.w500,
                    15,
                    AppColor.whiteColor,context
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget textAndBack(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        space(20),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            size: 32.r,
            color: Colors.black,
          ),
        ),
        space(10),
        CustomText(
          "My Balance".tr(),
          style: Styles.robotoStyle(
            FontWeight.bold,
            26,
            AppColor.blackColor,context
          ),
        ),
        space(15),
      ],
    );
  }

  Widget space(double height) {
    return SizedBox(
      height: height.h,
    );
  }

  Widget buildListTile({
    required String imageUrl,
    required String title,
    required String amountText,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20).r,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  imageUrl,
                  width: 25.r,
                ),
                SizedBox(width: 13.w),
                CustomText(title,
                    style: Styles.robotoStyle(
                      FontWeight.w500,
                      14.0,
                      AppColor.lightBlackColor,context
                    )),
              ],
            ),
            CustomText(amountText,
                style: Styles.robotoStyle(
                  FontWeight.bold,
                  15.0,
                  AppColor.blackColor,context
                ))
          ],
        ),
      ),
    );
  }
}
