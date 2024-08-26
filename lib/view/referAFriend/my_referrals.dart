import 'dart:developer';
import 'package:cashback/controller/Functions/mask_email.dart';
import 'package:cashback/controller/services/user_referrals_badges_service.dart';
import 'package:cashback/controller/shared_preferences.dart';
import 'package:cashback/model/user_referral_model.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:cashback/controller/myReferralsCubit/referral_badges_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cashback/view/custom_widgets/app_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../controller/myReferralsCubit/my_referrals_cubit.dart';
import 'package:cashback/view/imports.dart';
class MyReferralsScreen extends StatefulWidget {
  const MyReferralsScreen({super.key});

  @override
  State<MyReferralsScreen> createState() => _MyReferralsScreenState();
}

class _MyReferralsScreenState extends State<MyReferralsScreen> {
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  String currency = "";

  @override
  void initState() {
    currencyGet();
    Future.wait([
      context.read<ReferralBadgesCubit>().getBadges(),
      context.read<MyReferralsCubit>().getUserReferral("1"),

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textAndBack(context),
              BlocBuilder<ReferralBadgesCubit, ReferralBadgesState>(
                  builder: (context, state) {
                if (state.status == ReferralBadgesStatus.loading) {
                  return Center(
                    child: SizedBox(
                      width: 30.w,
                      height: 30.w,
                      child: CircularProgressIndicator(
                        color: AppColor.primaryColor,
                      ),
                    ),
                  );
                }
                return priceRow(state);
              }),
              BlocBuilder<MyReferralsCubit, MyReferralsState>(
                // listener: (context, state) {},
                builder: (context, state) {
                  log("CUBIT DATA ${state.model.data}");
                  if (state.status == MyReferralStatus.loading) {
                    return Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColor.primaryColor,
                        ),
                      ),
                    );
                  }
                  return Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        state.model.data!.isEmpty
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.only(
                                  left: 6,
                                  top: 12,
                                  bottom: 10,
                                ).r,
                                child: RichText(
                                  textScaleFactor:1.0 ,
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: "Page number".tr(),
                                    style: Styles.robotoStyle(
                                      FontWeight.w500,
                                      16,
                                      AppColor.lightBlackColor,context
                                    ),
                                    children: [
                                      TextSpan(text: ":"),
                                      TextSpan(
                                        text:
                                            " ${context.read<MyReferralsCubit>().currentPage <= state.model.meta!.pagination!.totalPages ? context.read<MyReferralsCubit>().currentPage : state.model.meta!.pagination!.totalPages.toString()}",
                                        style: Styles.robotoStyle(
                                          FontWeight.w500,
                                          16,
                                          AppColor.primaryColor,context
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        Expanded(
                          child: SmartRefresher(
                            footer: ClassicFooter(
                              loadStyle: LoadStyle.ShowWhenLoading,
                              loadingText: "Loading".tr(),
                              idleText: "Pull Up Load More".tr(),
                            ),
                            controller: refreshController,
                            enablePullUp: true,
                            reverse: false,
                            enableTwoLevel: true,
                            onRefresh: () async {
                              if (context.read<MyReferralsCubit>().currentPage >
                                  0) {
                                context.read<MyReferralsCubit>().currentPage -
                                    1;
                                refreshController.requestRefresh();
                                await context
                                    .read<MyReferralsCubit>()
                                    .getUserReferral(
                                        "${context.read<MyReferralsCubit>().currentPage - 1}");

                                refreshController.refreshCompleted();
                              } else {
                                refreshController.loadNoData();
                                refreshController.refreshCompleted();
                              }
                            },
                            onLoading: () async {
                              context.read<MyReferralsCubit>().currentPage + 1;
                              refreshController.requestLoading();
                              if (context.read<MyReferralsCubit>().currentPage >
                                  state.model.meta!.pagination!.totalPages) {
                                refreshController.loadNoData();
                                refreshController.loadComplete();
                              } else {
                                if (context
                                        .read<MyReferralsCubit>()
                                        .currentPage <
                                    state.model.meta!.pagination!.totalPages) {
                                  await context
                                      .read<MyReferralsCubit>()
                                      .getUserReferral(
                                          "${context.read<MyReferralsCubit>().currentPage + 1}");
                                  refreshController.loadComplete();
                                }
                              }
                              // refreshController.requestLoading();
                              // if (context
                              //         .read<MyReferralsCubit>()
                              //         .currentPage <=
                              //     state.model.meta!.pagination!.totalPages) {
                              //   log("Total Pages ${state.model.meta!.pagination!.totalPages.toString()}");
                              //   log("Current Page ${context.read<MyReferralsCubit>().currentPage}");
                              //   log("RUNNING ");
                              //   await context
                              //       .read<MyReferralsCubit>()
                              //       .getUserReferral(
                              //           "${context.read<MyReferralsCubit>().currentPage + 1}");
                              //   refreshController.loadComplete();
                              // }
                            },
                            child: state.model.data!.isEmpty
                                // &&
                                //     context
                                //             .read<MyReferralsCubit>()
                                //             .currentPage ==
                                //         1
                                ? Center(
                                    child: CustomText("No Referrals".tr(),
                                        style: Styles.robotoStyle(
                                          FontWeight.bold,
                                          23.sp,
                                          AppColor.primaryColor,context
                                        )),
                                  )
                                : ListView.builder(
                                    itemCount: state.model.data!.length,
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return allReferralsWidget(
                                          state.model, index);
                                    },
                                  ),
                          ),
                        ),
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

  Widget priceRow(ReferralBadgesState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildContainer(
          AppColor.primaryColor,
          state.model.refTotalClicks.toString(),
          "Referrals links clicks",
        ),
        buildContainer(
          AppColor.blueColor,
          state.model.refTotal.toString(),
          "Referrals",
        ),
        buildContainer(
          AppColor.yellowColor,
          "${double.parse(state.model.refPendingBonuses!.toString()).toInt()}$currency",
          "Pending Earnings",
        ),
        buildContainer(
          AppColor.greenColor,
          "${double.parse(state.model.refPaidBonuses!.toString()).toInt()}$currency",
          "Paid Earnings",
        ),
      ],
    );
  }

  Widget allReferralsWidget(UserReferralModel model, int index) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15).r,
      margin: const EdgeInsets.symmetric(vertical: 5).r,
      decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(10).r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleCustomText(model.data![index].fullName.toString()),
                space(5),
                // subtitleCustomText(model.data![index].contactEmail.toString()),
                subtitleCustomText(
                    maskEmail(model.data![index].contactEmail.toString())),
              ],
            ),
          ),
          dateCustomText(model.data![index].createdOnDate.toString()),
        ],
      ),
    );
  }

  CustomText dateCustomText(String text) {
    return CustomText(
      text,
      style: Styles.robotoStyle(
        FontWeight.w500,
        12,
        AppColor.blackColor,context
      ),
    );
  }

  CustomText signupCustomText(String text) {
    return CustomText(
      text,
      style: Styles.robotoStyle(
        FontWeight.w500,
        18,
        AppColor.primaryColor,context
      ),
    );
  }

  CustomText subtitleCustomText(String text) {
    return CustomText(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: Styles.robotoStyle(
        FontWeight.normal,
        14,
        AppColor.blackColor,context
      ),
    );
  }

  CustomText titleCustomText(String text) {
    return CustomText(
      text,
      style: Styles.robotoStyle(
        FontWeight.bold,
        18,
        AppColor.blackColor,context
      ),
    );
  }

  Widget space(double height) {
    return SizedBox(
      height: height.h,
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
          "My Referral".tr(),
          style: Styles.robotoStyle(
            FontWeight.bold,
            24.sp,
            AppColor.blackColor,context
          ),
        ),
        space(40),
      ],
    );
  }

  Widget buildContainer(Color color, String containerText, String text) {
    return Column(
      children: [
        Container(
          width: 60.w,
          height: 55.w,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8).r,
          ),
          child: Center(
            child: CustomText(containerText,
                style: Styles.robotoStyle(
                  FontWeight.bold,
                  15.sp,
                  AppColor.whiteColor,context
                )),
          ),
        ),
        space(10),
        CustomText(text.tr(),
            textAlign: TextAlign.center,
            style: Styles.robotoStyle(
              FontWeight.w400,
              13.sp,
              AppColor.blackColor,context
            )),
      ],
    );
  }
}
