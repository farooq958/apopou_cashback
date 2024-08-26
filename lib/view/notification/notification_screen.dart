import 'dart:developer';

import 'package:cashback/controller/notificationsCubit/deleteOneNotificationCubit/delete_one_notification_cubit.dart';
import 'package:cashback/controller/notificationsCubit/notificationCubit/notification_cubit.dart';
import 'package:cashback/controller/services/notification_services.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:cashback/view/home_screen.dart';
import 'package:cashback/view/auth/login_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../controller/AppConstants.dart';
import '../custom_widgets/app_color.dart';
import 'package:cashback/view/imports.dart';

class NotificationScreen extends StatefulWidget {
  final bool guest;

  NotificationScreen({Key? key, required this.guest}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isClearAll = false;
  bool isNotificationAvailable = false;
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    context.read<NotificationCubit>().getNotifications("1");
    if (widget.guest == true) {
      // prodcutScrollerController!.dispose();
      // featuredScrollerController!.dispose();
      // faouriteScrollerController!.dispose();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white.withOpacity(0.935),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 25.sp,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13.0),
              child: CustomText("Ειδοποιήσεις",
                  style: Styles.robotoStyle(
                    FontWeight.w900,
                    28.0.sp,
                    const Color(0xFF363636),
                    context,
                    height: 1.22,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      if (isNotificationAvailable == false) {
                        buildShowModalBottomSheet(context, 0);
                        setState(() {
                          isClearAll = true;
                        });
                      }
                    },
                    child: SizedBox(
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete_forever,
                            color: Colors.black54,
                            size: 16.sp,
                          ),
                          CustomText("Καθαρισμός",
                              style: GoogleFonts.alata(
                                fontSize: 14.0.sp,
                                color: Colors.black54,
                                fontWeight: FontWeight.w900,
                                height: 1.22,
                              ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            BlocBuilder<NotificationCubit, NotificationsState>(
              builder: (context, state) {
                isNotificationAvailable =
                    state.list.data!.length == 0 ? true : false;

                log("log is not available ${isNotificationAvailable}");
                if (state.status == NotificationsStatus.loading) {
                  return Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColor.primaryColor,
                      ),
                    ),
                  );
                }

                if (state.status == NotificationsStatus.loading) {
                  return Center(
                    child: CustomText("${state.error}"),
                  );
                }

                return Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      state.list.data!.isEmpty
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.only(
                                top: 5,
                                bottom: 12,
                                left: 15,
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
                                          " ${context.read<NotificationCubit>().currentPage <= state.list.meta!.pagination!.totalPages ? context.read<NotificationCubit>().currentPage : state.list.meta!.pagination!.totalPages.toString()}",
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
                            refreshController.requestRefresh();
                            await context
                                .read<NotificationCubit>()
                                .getNotifications(
                                  "${context.read<NotificationCubit>().currentPage - 1}",
                                );

                            refreshController.refreshCompleted();
                          },
                          onLoading: () async {
                            refreshController.requestLoading();
                            if (context.read<NotificationCubit>().currentPage <=
                                state.list.meta!.pagination!.totalPages) {
                              await context
                                  .read<NotificationCubit>()
                                  .getNotifications(
                                    "${context.read<NotificationCubit>().currentPage + 1}",
                                  );
                              refreshController.loadComplete();
                            }
                          },
                          child: state.list.data!.isEmpty
                              ? Center(
                                  child: CustomText("Δεν υπάρχουν ειδοποιήσεις",
                                      style: Styles.robotoStyle(
                                        FontWeight.w900,
                                        17.0.sp,
                                        AppColor.primaryColor,
                                        context,

                                        height: 1.22,
                                      )),
                                )
                              : ListView.builder(
                                  itemCount: state.list.data!.length,
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return buildNotificationCard(
                                      context,
                                      state.list.data?[index].title,
                                      state.list.data?[index].text,
                                      state.list.data?[index].identifier,
                                    );
                                  }),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Container buildNotificationCard(
    BuildContext context,
    String? title,
    String? desc,
    int? id,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
      padding: const EdgeInsets.all(8.0),
      // width: MediaQuery.of(context).size.width,
      height: 80.h,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(6)),
                  child: Icon(
                    Icons.notifications_none,
                    color: AppConstants.appDarkColor,
                    size: 25.sp,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(title.toString(),
                          style: Styles.robotoStyle(
                            FontWeight.w900,
                            13.0.sp,
                            const Color(0xFF363636),
                            context,

                            height: 1.22,
                          )),
                      SizedBox(height: 3.h),
                      Container(
                        width: MediaQuery.of(context).size.width * .70,
                        child: CustomText(desc.toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: GoogleFonts.actor(
                              fontSize: 12.0.sp,
                              color: Colors.black54,
                              fontWeight: FontWeight.w900,
                              height: 1.22,
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 2, right: 2).r,
              child: InkWell(
                onTap: () {
                  buildShowModalBottomSheet(context, id!);
                  setState(() {
                    isClearAll = false;
                  });
                },
                child: const Icon(
                  Icons.more_vert,
                  size: 15,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  buildShowModalBottomSheet(context, int id) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10).r,
          height: 165.h,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          child: Column(
            //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                  isClearAll
                      ? "Θέλετε να διαγραφούν όλες οι ειδοποιήσεις"
                      : "Θέλετε να διαγραφεί αυτή η ειδοποίηση",
                  style: Styles.robotoStyle(
                    FontWeight.w900,
                    16.0.sp,
                    Colors.black,
                    context,

                    height: 1.22,
                  )),
              SizedBox(
                height: 15.w,
              ),
              GestureDetector(
                onTap: () async {
                  // todo one delete
                  log("testing one delete ${id}");

                  if (id == 0) {
                    var result =
                        await NotificationServices().deleteAllNotification();
                    if (result == true) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: CustomText(
                          "Οι ειδοποιήσεις διαγράφηκαν με επιτυχία",
                        ),
                        behavior: SnackBarBehavior.floating,
                      ));

                      /// todo Change
                      context.read<NotificationCubit>().getNotifications("1");
                    }
                  } else {
                    var res = await context
                        .read<DeleteOneNotificationCubit>()
                        .deleteNotification(id: id);
                    Navigator.pop(context);

                    if (res) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: CustomText(
                          "Η ειδοποίηση διαγράφηκε με επιτυχία",
                        ),
                        behavior: SnackBarBehavior.floating,
                      ));

                      /// todo Change
                      context.read<NotificationCubit>().getNotifications("1");
                    }
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.delete,
                      color: AppConstants.appDarkColor,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText('Διαγραφή',
                            style: Styles.robotoStyle(
                              FontWeight.w900,
                              15.0.sp,
                              AppConstants.appDarkColor,
                              context
                             ,
                              height: 1.22,
                            )),
                        CustomText(
                            isClearAll
                                ? 'Όλες οι ειδοποιήσεις θα διαγραφούν μόνιμα'
                                : 'Η ειδοποίηση θα διαγραφεί μόνιμα',
                            style: Styles.robotoStyle(
                              FontWeight.w900,
                              13.0.sp,
                             Colors.black54,
                              context
                             ,
                              height: 1.22,
                            )),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.w,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.reply,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText('Ακύρωση',
                            style: Styles.robotoStyle(
                              FontWeight.w900,
                              15.0.sp,
                             Colors.black54,
                              context
                            ,
                              height: 1.22,
                            )),
                        CustomText('Επιστροφή στις ειδοποιήσεις',
                            style: Styles.robotoStyle(
                              FontWeight.w900,
                              15.0.sp,
                              Colors.black54,
                              context,
                              height: 1.22,
                            )),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
