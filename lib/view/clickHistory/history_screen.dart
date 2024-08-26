import 'dart:developer';

import 'package:cashback/controller/services/apis.dart';
import 'package:cashback/model/balance/click_history_model.dart';
import 'package:cashback/controller/clickHistoryCubit/click_history_cubit.dart';
import 'package:cashback/view/clickHistory/history_detail.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../custom_widgets/app_color.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:cashback/view/imports.dart';

class AllHistoryScreen extends StatefulWidget {
  const AllHistoryScreen({super.key});

  @override
  State<AllHistoryScreen> createState() => _AllHistoryScreenState();
}

class _AllHistoryScreenState extends State<AllHistoryScreen> {
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  String userId = '';
  var current;

  @override
  void initState() {
    getUserId();
    super.initState();
  }

  Future getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uid = await prefs.getString("uid") ?? "";
    await context.read<ClickHistoryCubit>().getClickHistory(uid, "1");
    setState(() {
      userId = uid;
    });
    log("UserIdddd $userId");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondaryColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textAndBack(context),
            BlocBuilder<ClickHistoryCubit, ClickHistoryState>(
                // listener: (context, state) {},
                builder: (context, state) {
              log("STATE ${state.status}");
              if (state.status == ClickHistoryStatus.loading) {
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
                    // context.read<ClickHistoryCubit>().currentPage != null
                    state.modelList.data!.isEmpty
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(
                              top: 15,
                              bottom: 12,
                            ).r,
                            child: RichText(
                              textScaleFactor: 1.0,
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
                                        " ${context.read<ClickHistoryCubit>().currentPage <= state.modelList.meta!.pagination!.totalPages ? context.read<ClickHistoryCubit>().currentPage : state.modelList.meta!.pagination!.totalPages.toString()}",
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
                          if (context.read<ClickHistoryCubit>().currentPage >
                              0) {
                            current =
                                context.read<ClickHistoryCubit>().currentPage -
                                    1;
                            refreshController.requestRefresh();
                            await context
                                .read<ClickHistoryCubit>()
                                .getClickHistory(
                                  userId,
                                  "$current",
                                );
                            refreshController.refreshCompleted();
                          } else {
                            refreshController.loadNoData();
                            refreshController.refreshCompleted();
                          }

                          log("PAGESSS $current");
                        },
                        onLoading: () async {
                          current =
                              context.read<ClickHistoryCubit>().currentPage + 1;
                          refreshController.requestLoading();
                          if (current >
                              state.modelList.meta!.pagination!.totalPages) {
                            refreshController.loadNoData();
                            refreshController.loadComplete();
                          } else {
                            if (context.read<ClickHistoryCubit>().currentPage <
                                state.modelList.meta!.pagination!.totalPages) {
                              await context
                                  .read<ClickHistoryCubit>()
                                  .getClickHistory(
                                    userId,
                                    "$current",
                                  );
                              refreshController.loadComplete();
                            }
                          }
                          log("PAGESSS $current");
                        },
                        child: state.modelList.data!.isEmpty
                            // &&
                            //     context.read<ClickHistoryCubit>().currentPage ==
                            //         1
                            ? Center(
                                child: CustomText(
                                  "No clicks available".tr(),
                                  style: Styles.robotoStyle(FontWeight.bold,
                                      20.sp, AppColor.primaryColor,context),
                                ),
                              )
                            : ListView.builder(
                                itemCount: state.modelList.data!.length,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: ((context, index) {
                                  var model = state.modelList.data![index];
                                  return buildContainer(model, context);
                                })),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      )),
    );
  }

  Widget buildContainer(ClickHistoryData model, BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HistoryDetailScreen(model: model))),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20).r,
        margin: const EdgeInsets.symmetric(vertical: 5).r,
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(12).r,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row(
                //   children: [
                //     CustomText(
                //       "Click ID".tr(),
                //       style: Styles.robotoStyle(
                //         FontWeight.w500,
                //         15,
                //         AppColor.primaryColor,
                //       ),
                //     ),
                //     CustomText(
                //       ": ${model.clickRef}",
                //       style: Styles.robotoStyle(
                //         FontWeight.w500,
                //         15,
                //         AppColor.primaryColor,
                //       ),
                //     ),
                //   ],
                // ),
                CustomText(
                  "${model.clickRef}",
                  style: Styles.robotoStyle(
                    FontWeight.w500,
                    15,
                    AppColor.primaryColor,context
                  ),
                ),
                space(4),
                CustomText(
                  model.retailor.toString(),
                  style: Styles.robotoStyle(
                    FontWeight.normal,
                    19,
                    AppColor.blackColor,context
                  ),
                ),
              ],
            ),
            Column(
              children: [
                CustomText(
                  "View Details".tr(),
                  style: Styles.robotoStyle(
                    FontWeight.normal,
                    15,
                    AppColor.blackColor,context
                  ),
                ),
                space(3),
                CustomText(
                  model.dateAdded.toString(),
                  style: Styles.robotoStyle(
                    FontWeight.bold,
                    15,
                    AppColor.greyColor,context
                  ),
                ),
              ],
            ),
          ],
        ),
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
        Row(
          children: [
            CustomText(
              "History".tr(),
              style: Styles.robotoStyle(
                FontWeight.bold,
                26,
                AppColor.blackColor,context
              ),
            ),
            SizedBox(width: 8.w),
            Image.asset(
              "images/calendar.png",
              width: 25.w,
              height: 25.h,
            ),
          ],
        ),
      ],
    );
  }

  Widget space(double height) {
    return SizedBox(
      height: height.h,
    );
  }
}
