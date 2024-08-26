import 'dart:developer';
import 'package:cashback/controller/transactionHistory/transaction_history_cubit.dart';
import 'package:cashback/view/balance/transection_detail.dart';
import 'package:cashback/view/custom_widgets/app_color.dart';
import 'package:easy_localization/easy_localization.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../controller/shared_preferences.dart';
import '../../../../model/balance/transaction_history_model.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:cashback/view/imports.dart';

class TransectionHistoryScreen extends StatefulWidget {
  final String tabText;

  const TransectionHistoryScreen({
    super.key,
    required this.tabText,
  });

  @override
  State<TransectionHistoryScreen> createState() =>
      _TransectionHistoryScreenState();
}

class _TransectionHistoryScreenState extends State<TransectionHistoryScreen> {
  bool isAll = true;
  bool isCredit = false; //Confirmed
  bool isDebit = false; //Paid
  bool isPending = false; //Pending
  bool isDeclined = false; //Declined
  bool isRequest = false; //Request
  String currency = "";
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  ScrollController? scrollController;
  List confirmList = List.empty(growable: true);
  List paidList = List.empty(growable: true);
  List pendingList = List.empty(growable: true);
  List allList = List.empty(growable: true);
  List declinedList = List.empty(growable: true);
  List requestList = List.empty(growable: true);
  IconData iconData = Icons.arrow_downward_rounded;
  var leftPosition;
  var rightPosition;
  int rotatePosition = 3;

  @override
  void initState() {
    scrollController = ScrollController();
    currencyGet();
    Future.wait([
      controlTabs(),
    ]);
    rightPosition = 0.0;
    super.initState();
  }

  Future currencyGet() async {
    var c = await CurrencyPrefs.getCurrency();
    setState(() {
      currency = c;
    });
  }

  Future controlTabs() async {
    switch (widget.tabText) {
      case "":
        context
            .read<TransactionHistoryCubit>()
            .getTransactionHistory(pageNumber: "1", status: "");
        isAll = true;
        break;
      case "confirmed":
        context
            .read<TransactionHistoryCubit>()
            .getTransactionHistory(pageNumber: "1", status: "confirmed");
        isAll = false;
        isCredit = true;
        break;
      case "paid":
        context
            .read<TransactionHistoryCubit>()
            .getTransactionHistory(pageNumber: "1", status: "paid");
        isAll = false;
        isDebit = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollController!.animateTo(
            scrollController!.position.maxScrollExtent,
            duration: Duration(seconds: 1),
            curve: Curves.ease,
          );
        });

        setState(() {});
        break;
      case "pending":
        context
            .read<TransactionHistoryCubit>()
            .getTransactionHistory(pageNumber: "1", status: "pending");
        isAll = false;
        isPending = true;
        break;
      case "request":
        context
            .read<TransactionHistoryCubit>()
            .getTransactionHistory(pageNumber: "1", status: "request");
        isAll = false;
        isRequest = true;
        break;
      case "declined":
        context
            .read<TransactionHistoryCubit>()
            .getTransactionHistory(pageNumber: "1", status: "declined");
        isAll = false;
        isDeclined = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollController!.animateTo(
            scrollController!.position.maxScrollExtent,
            duration: Duration(seconds: 1),
            curve: Curves.ease,
          );
        });
        setState(() {});
        break;
    }
  }

  @override
  void didChangeDependencies() {
    scrollController!.addListener(() {
      if (scrollController!.position.pixels == 0.0) {
        leftPosition = null;
        rightPosition = 0.0;
        rotatePosition = 3;
        setState(() {});
      } else {
        rightPosition = null;
        leftPosition = 0.0;
        rotatePosition = 1;
        setState(() {});
      }
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondaryColor,
      body: SafeArea(
        child: Column(
          children: [
            upperBody(context),
            // space(20),
            BlocConsumer<TransactionHistoryCubit, TransactionHistoryState>(
                listener: (context, state) {
              if (state.status == TransactionHistoryStatus.success) {
                confirmList = state.modelList.data!
                    .where((element) => element.status == "confirmed")
                    .toList();

                paidList = state.modelList.data!
                    .where((element) => element.status == "paid")
                    .toList();
                pendingList = state.modelList.data!
                    .where((element) => element.status == "pending")
                    .toList();

                requestList = state.modelList.data!
                    .where((element) => element.status == "request")
                    .toList();

                declinedList = state.modelList.data!
                    .where((element) => element.status == "declined")
                    .toList();
              }
            }, builder: (context, state) {
              log("Status ${state.status}");

              if (state.status == TransactionHistoryStatus.loading) {
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
                    state.modelList.data!.isEmpty
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 11,
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
                                        " ${context.read<TransactionHistoryCubit>().currentPage <= state.modelList.meta!.pagination!.totalPages ? context.read<TransactionHistoryCubit>().currentPage : state.modelList.meta!.pagination!.totalPages.toString()}",
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
                        enableTwoLevel: true,
                        controller: refreshController,
                        enablePullUp: true,
                        reverse: false,
                        onRefresh: () async {
                          refreshController.requestRefresh();
                          await context
                              .read<TransactionHistoryCubit>()
                              .getTransactionHistory(
                                pageNumber:
                                    "${context.read<TransactionHistoryCubit>().currentPage - 1}",
                                status: isCredit == true
                                    ? "confirmed"
                                    : isDebit == true
                                        ? "paid"
                                        : isPending == true
                                            ? "pending"
                                            : isDeclined == true
                                                ? "declined"
                                                : isRequest == true
                                                    ? "request"
                                                    : "",
                              );

                          refreshController.refreshCompleted();
                        },
                        onLoading: () async {
                          refreshController.requestLoading();
                          if (context
                                  .read<TransactionHistoryCubit>()
                                  .currentPage <=
                              state.modelList.meta!.pagination!.totalPages) {
                            await context
                                .read<TransactionHistoryCubit>()
                                .getTransactionHistory(
                                  pageNumber:
                                      "${context.read<TransactionHistoryCubit>().currentPage + 1}",
                                  status: isCredit == true
                                      ? "confirmed"
                                      : isDebit == true
                                          ? "paid"
                                          : isPending == true
                                              ? "pending"
                                              : isDeclined == true
                                                  ? "declined"
                                                  : isRequest == true
                                                      ? "request"
                                                      : "",
                                );
                            refreshController.loadComplete();
                          }
                        },
                        child: state.modelList.data!.isEmpty
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10)
                                        .r,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomText(
                                            "There is no transaction to load, Pull"
                                                .tr(),
                                            textAlign: TextAlign.center,
                                            style: Styles.robotoStyle(
                                              FontWeight.w500,
                                              16.0.sp,
                                              AppColor.primaryColor,
                                              context,


                                            )),
                                        Icon(Icons.arrow_downward_rounded),
                                        CustomText("down".tr(),
                                            textAlign: TextAlign.center,
                                            style: Styles.robotoStyle(
                                              FontWeight.w500,
                                              16.0.sp,
                                              AppColor.primaryColor,
                                              context,


                                            )),
                                      ],
                                    ),
                                    CustomText("to load previous transactions".tr(),
                                        textAlign: TextAlign.center,
                                        style: Styles.robotoStyle(
                                          FontWeight.w500,
                                          16.0.sp,
                                          AppColor.primaryColor,
                                          context,

                                        )),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                itemCount: isCredit == true
                                    ? confirmList.length
                                    : isDebit == true
                                        ? paidList.length
                                        : isPending == true
                                            ? pendingList.length
                                            : isDeclined == true
                                                ? declinedList.length
                                                : isRequest == true
                                                    ? requestList.length
                                                    : state
                                                        .modelList.data!.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  log("PAGE ${state.modelList.meta!.pagination!.currentPage!}");
                                  log("Status ${state.modelList.data![index].status}");
                                  // var model = state.modelList.data![index];

                                  var model = isCredit == true
                                      ? confirmList[index]
                                      : isDebit == true
                                          ? paidList[index]
                                          : isPending == true
                                              ? pendingList[index]
                                              : isDeclined == true
                                                  ? declinedList[index]
                                                  : isRequest == true
                                                      ? requestList[index]
                                                      : state.modelList
                                                          .data![index];
                                  return transectionDetailListTile(model);
                                }),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget transectionDetailListTile(TransectionData model) {
    var amount = double.parse(model.amount.toString()).toStringAsFixed(2);
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TrasectionDetailScreen(model: model),
        ),
      ),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20).r,
        margin: EdgeInsets.symmetric(vertical: 1).r,
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    model.typelabeled!.isEmpty
                        ? ""
                        : model.typelabeled.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Styles.robotoStyle(
                      FontWeight.w500,
                      15.3,
                      AppColor.lightBlackColor,context
                    ),
                  ),
                  space(8),
                  model.retailer!.isEmpty
                      ? Container()
                      : CustomText("${model.retailer.toString()}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Styles.robotoStyle(
                            FontWeight.w300,
                            12.0,
                            AppColor.lightBlackColor,context
                          )),
                  // Row(
                  //         children: [
                  //           CustomText("Type".tr(),
                  //               maxLines: 1,
                  //               overflow: TextOverflow.ellipsis,
                  //               style: Styles.robotoStyle(
                  //                 FontWeight.w300,
                  //                 12.0,
                  //                 AppColor.lightBlackColor,
                  //               )),
                  //           Expanded(
                  //             child: CustomText(": ${model.retailer.toString()}",
                  //                 maxLines: 1,
                  //                 overflow: TextOverflow.ellipsis,
                  //                 style: Styles.robotoStyle(
                  //                   FontWeight.w300,
                  //                   12.0,
                  //                   AppColor.lightBlackColor,
                  //                 )),
                  //           ),
                  //         ],
                  //       ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 8)
                              .r,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: model.status == "confirmed" ||
                                        model.status == "paid"
                                    ? AppColor.greenColor
                                    : model.status == "pending"
                                        ? AppColor.yellowColor
                                        : model.status == "declined"
                                            ? AppColor.redColor
                                            : model.status == "request"
                                                ? Colors.purple
                                                : AppColor.primaryColor,
                                width: 1.5.w,
                              ),
                              borderRadius: BorderRadius.circular(6).r),
                          child: FittedBox(
                            child: CustomText(model.statuslabeled.toString(),
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: Styles.robotoStyle(
                                  FontWeight.normal,
                                  12.0,
                                  model.status == "confirmed" ||
                                          model.status == "paid"
                                      ? AppColor.greenColor
                                      : model.status == "pending"
                                          ? AppColor.yellowColor
                                          : model.status == "declined"
                                              ? AppColor.redColor
                                              : model.status == "request"
                                                  ? Colors.purple
                                                  : AppColor.primaryColor,context
                                )),
                          ),
                        ),
                        // Container(
                        //   padding: const EdgeInsets.symmetric(
                        //           horizontal: 14, vertical: 4)
                        //       .r,
                        //   decoration: BoxDecoration(
                        //       border: Border.all(
                        //         color: model.status == "confirmed".tr()
                        //             ? AppColor.greenColor
                        //             : model.status == "pending".tr()
                        //                 ? AppColor.redColor
                        //                 : AppColor.yellowColor,
                        //         width: 1.5.w,
                        //       ),
                        //       borderRadius: BorderRadius.circular(6).r),
                        //   child: Center(
                        //     child: CustomText(model.status,
                        //         style: Styles.robotoStyle(
                        //           FontWeight.normal,
                        //           14.0,
                        //           model.status == "confirmed".tr()
                        //               ? AppColor.greenColor
                        //               : model.status == "pending".tr()
                        //                   ? AppColor.redColor
                        //                   : AppColor.yellowColor,
                        //         )),
                        //   ),
                        // ),
                        space(5),
                        CustomText("View Details".tr(),
                            style: Styles.robotoStyle(
                              FontWeight.w300,
                              13.0,
                              AppColor.lightBlackColor,context
                            )),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomText(
                          "$currency$amount",
                          style: Styles.robotoStyle(
                            FontWeight.bold,
                            16,
                            AppColor.primaryColor,context
                          ),
                        ),
                        space(8),
                        CustomText(date(model.createdOnDate),
                            style: Styles.robotoStyle(
                              FontWeight.w300,
                              12.0,
                              AppColor.greyColor,context
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget upperBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10).r,
      child: Column(
        children: [
          textAndBack(context),
          space(10),
          customTabBar(),
        ],
      ),
    );
  }

  Widget customTabBar() {
    return StatefulBuilder(builder: (context, setState) {
      return Container(
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: scrollController,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10).r,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ///1
                    actionButton(
                      text: "All".tr(),
                      isActive: isAll,
                      onTap: () async {
                        setState(() {
                          isAll = true;
                          isCredit = false;
                          isDebit = false;
                          isPending = false;
                          isDeclined = false;
                          isRequest = false;
                        });
                        await context
                            .read<TransactionHistoryCubit>()
                            .getTransactionHistory(pageNumber: "1", status: "");
                      },
                    ),

                    ///2
                    actionButton(
                      text: "Pending".tr(),
                      isActive: isPending,
                      onTap: () async {
                        setState(() {
                          isAll = false;
                          isCredit = false;
                          isDebit = false;
                          isPending = true;
                          isDeclined = false;
                          isRequest = false;
                        });
                        await context
                            .read<TransactionHistoryCubit>()
                            .getTransactionHistory(
                                pageNumber: "1", status: "pending");
                      },
                    ),

                    ///3
                    actionButton(
                      text: "Confirmed".tr(),
                      isActive: isCredit,
                      onTap: () async {
                        setState(() {
                          isAll = false;
                          isCredit = true;
                          isDebit = false;
                          isPending = false;
                          isDeclined = false;
                          isRequest = false;
                        });
                        await context
                            .read<TransactionHistoryCubit>()
                            .getTransactionHistory(
                                pageNumber: "1", status: "confirmed");
                      },
                    ),

                    ///4
                    actionButton(
                      text: "Request".tr(),
                      isActive: isRequest,
                      onTap: () async {
                        setState(() {
                          isAll = false;
                          isCredit = false;
                          isDebit = false;
                          isPending = false;
                          isDeclined = false;
                          isRequest = true;
                        });
                        await context
                            .read<TransactionHistoryCubit>()
                            .getTransactionHistory(
                                pageNumber: "1", status: "request");
                      },
                    ),

                    ///5
                    actionButton(
                      text: "Paid".tr(),
                      isActive: isDebit,
                      onTap: () async {
                        setState(() {
                          isAll = false;
                          isCredit = false;
                          isDebit = true;
                          isPending = false;
                          isDeclined = false;
                          isRequest = false;
                        });
                        await context
                            .read<TransactionHistoryCubit>()
                            .getTransactionHistory(
                                pageNumber: "1", status: "paid");
                      },
                    ),

                    ///6
                    actionButton(
                      text: "Declined".tr(),
                      isActive: isDeclined,
                      onTap: () async {
                        setState(() {
                          isAll = false;
                          isCredit = false;
                          isDebit = false;
                          isPending = false;
                          isDeclined = true;
                          isRequest = false;
                        });
                        await context
                            .read<TransactionHistoryCubit>()
                            .getTransactionHistory(
                                pageNumber: "1", status: "declined");
                      },
                    ),
                  ],
                ),
              ),
            ),
            if (scrollController!.positions.isNotEmpty)
              Positioned(
                right: rightPosition,
                left: leftPosition,
                top: 0,
                bottom: 0,
                child: GestureDetector(
                  onTap: () {
                    var pixels = scrollController!.position.pixels;
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (scrollController!.position.minScrollExtent <=
                          pixels) {
                        scrollController!.animateTo(
                          scrollController!.position.maxScrollExtent,
                          duration: Duration(seconds: 1),
                          curve: Curves.ease,
                        );
                        setState(() {});
                      }
                      if (scrollController!.position.maxScrollExtent ==
                          pixels) {
                        scrollController!.animateTo(
                          scrollController!.position.minScrollExtent,
                          duration: Duration(seconds: 1),
                          curve: Curves.ease,
                        );
                        setState(() {
                          iconData = Icons.arrow_downward_rounded;
                        });
                      }
                    });
                    setState(() {});
                  },
                  behavior: HitTestBehavior.opaque,
                  child: RotatedBox(
                    quarterTurns: rotatePosition,
                    child: ClipPath(
                      clipper: CustomClip(),
                      child: Container(
                        padding: const EdgeInsets.only(top: 2).r,
                        width: 80,
                        height: 30,
                        color: AppColor.primaryColor.withOpacity(0.5),
                        child: Icon(
                          iconData,
                          color: AppColor.whiteColor,
                          size: 20.r,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }

  Widget actionButton({
    required String text,
    required VoidCallback onTap,
    required bool isActive,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11).r,
          decoration: BoxDecoration(
            color: isActive ? AppColor.primaryColor : AppColor.whiteColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: isActive
              ? CustomText(text,
                  textAlign: TextAlign.center,
                  style: Styles.robotoStyle(
                      FontWeight.bold, 13, AppColor.whiteColor,context))
              : CustomText(text,
                  textAlign: TextAlign.center,
                  style: Styles.robotoStyle(
                      FontWeight.normal, 11, AppColor.blackColor,context))),
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
              "Transection History".tr(),
              style: Styles.robotoStyle(
                FontWeight.bold,
                25,
                AppColor.blackColor,context
              ),
            ),
            SizedBox(width: 10.w),
            Image.asset(
              "images/calendar.png",
              width: 29.w,
              height: 24.h,
            ),
          ],
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

  String date(dt) {
    DateTime dateTime = DateTime.parse(dt);
    return DateFormat('MMM dd,yyy').format(dateTime);
  }
}

class CustomClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double radius = 30;

    Path path = Path();
    path
      ..moveTo(size.width / 2, 0)
      ..arcToPoint(Offset(size.width, size.height),
          radius: Radius.circular(radius))
      ..lineTo(0, size.height)
      ..arcToPoint(
        Offset(size.width / 2, 0),
        radius: Radius.circular(radius),
      )
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
