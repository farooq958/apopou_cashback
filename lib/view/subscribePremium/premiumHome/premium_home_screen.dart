import 'dart:developer';

import 'package:cashback/controller/premiumControllers/PremiumUser/premium_user_cubit.dart';
import 'package:cashback/controller/services/premiun_service_api.dart';
import 'package:cashback/view/imports.dart';
import 'package:cashback/controller/AppConstants.dart';
import 'package:cashback/controller/VivaWallet/services/walletControllers.dart';
import 'package:cashback/controller/VivaWallet/wallet_url_cubit.dart';
import 'package:cashback/controller/premiumControllers/Services/all_coupon_services.dart';
import 'package:cashback/controller/premiumControllers/couponCubit/coupon_cubit.dart';
import 'package:cashback/controller/premiumControllers/premium_favourite_cubit.dart';
import 'package:cashback/controller/services/apis.dart';
import 'package:cashback/controller/services/dialog_show_cubit.dart';
import 'package:cashback/controller/shared_preferences.dart';
import 'package:cashback/controller/testserver.dart';
import 'package:cashback/model/premium/all_coupon_model.dart';
import 'package:cashback/view/auth/login_screen.dart';
import 'package:cashback/view/custom_widgets/app_color.dart';
import 'package:cashback/view/custom_widgets/dialogue.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:cashback/view/notification/notification_screen.dart';
import 'package:cashback/view/subscribePremium/components/parent_category_tile.dart';
import 'package:cashback/view/subscribePremium/components/premium_coupon_widget.dart';
import 'package:cashback/view/subscribePremium/subscribe_successful_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_validator/string_validator.dart';
import '../../../controller/premiumControllers/PremiumAllCoupons/all_coupon_premium_cubit.dart';
import '../../../controller/premiumControllers/Services/premium_controllers.dart';
import '../../../controller/premiumControllers/parentCategoryCubit/premium_parent_category_cubit.dart';
import 'package:cashback/controller/premiumControllers/PremiumAllCoupons/all_coupon_premium_cubit.dart';

class PremiumHomeScreen extends StatefulWidget {
  final bool guest;
  final bool isPremium;
  const PremiumHomeScreen(
      {Key? key, required this.guest, required this.isPremium})
      : super(key: key);

  @override
  State<PremiumHomeScreen> createState() => _PremiumHomeScreenState();
}

int pageNo = 0;

class _PremiumHomeScreenState extends State<PremiumHomeScreen> {
  bool isPremium = false;
  final RefreshController refreshControllerPremium =
      RefreshController(initialRefresh: false);

  // final PagingController<int, Datum> _pagingController =
  // PagingController(firstPageKey: 0);
  String countryId = "";
  String categoryId = "";
  bool isAll = true;
  String premiumCheck = '';
  int outTab = 0;
  //var favouriteCoupons=[];
  String check = "fromall";
  getCountryId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await SharePrefs.init();
    var id = await prefs.getString("country_id") ?? "";



    setState(() {
      countryId = id;
    });
  }

  // getFavourite() async {
  //   favouriteCoupons.clear();
  //   favouriteCoupons= await  ServicesAllCoupons().getAllFavouriteCoupons();
  //   setState(() {
  //
  //   });
  //   print(favouriteCoupons);
  // }
  @override
  void initState() {
    getCountryId();
    premiumCheckIt();
    //getFavourite();
    print("testt");

    var checkServer = countryId == "1" ? BaseUrl : cyprusBaseUrl;
    if (widget.guest == true) {
      finalServer = checkServer;
      setState(() {});
    }
    finalServer = checkServer;
    pageNo = 1;
    if (check == "fromall") {
      context
          .read<AllCouponPremiumCubit>()
          .loadPremiumMainData(pageNo, "", check, widget.guest, "fromnottap");

      // _pagingController.addPageRequestListener((pageKey) {
      //   context.read<AllCouponPremiumCubit>().loadPremiumMainData(pageKey,"",check);
      // });
    } else {
      context.read<AllCouponPremiumCubit>().loadPremiumMainData(
          pageNo, categoryId, check, widget.guest, "fromnottap");

      // _pagingController.addPageRequestListener((pageKey) {
      //   context.read<AllCouponPremiumCubit>().loadPremiumMainData(pageKey,categoryId,check);
      // });
    }
    context.read<WalletUrlCubit>().getWalletUrl();
    context.read<PremiumUserCubit>().getPremiumUserData();
    // print(favouriteCoupons);
    Future.wait([
      context.read<PremiumParentCategoryCubit>().getCategories(),

      // context.read<CouponCubit>().getCoupons(categoryId),
    ]);

    super.initState();
  }

  Future premiumCheckIt() async {
    var c = await PremiumCheck.getPremiumCheck();
    //var d = await PremiumCheck.getPremiumUserData();
    setState(() {
      premiumCheck = c;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondaryColor,
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
                expandedHeight: 175.h,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.zero,
                  background: Column(
                    children: [
                      ///top Row
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 2,
                          left: 15,
                          right: 15,
                        ).r,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "images/logo_orange.png",
                                  fit: BoxFit.fill,
                                  width: 85.w,
                                  height: 37.h,
                                ),
                                Container(
                                  width: 42.w,
                                  height: 24.h,
                                  // margin: const EdgeInsets.only(left: 5).r,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10).r,
                                  ),
                                  child: countryId == "1"
                                      ? Center(
                                          child: Image.network(
                                          "https://apopou.gr/images/greece.jpg",
                                          width: 25.w,
                                          height: 12,
                                        ))
                                      : Center(
                                          child: Image.network(
                                          "https://apopou.gr/images/cyprus.jpg",
                                          width: 25.w,
                                          height: 12,
                                        )),
                                ),
                                BlocListener<DialogShowCubit, bool>(
                                  listener: (context, sState) {
                                    // TODO: implement listener
                                    if (sState == true) {
                                      AppDialog.dialog(
                                          context, SubscribeSuccessfulScreen());
                                    }
                                  },
                                  child: BlocListener<PremiumUserCubit,
                                      PremiumUserState>(
                                    listener: (context, state) {
                                      if (state is PremiumUserSuccess) {
                                        //  print("tesss" + walletUrlController.data);
                                        if (state.premiumData.isActive == 0) {
                                          isPremium = false;
                                        }
                                        else if(state.premiumData.isActive==2)
                                          {
                                            DateTime now =DateTime.now();

                                            DateTime? expiryDate=state.premiumData.expiredAt;

                                            log("expire Date and now date ${expiryDate} + ${now}");

                                            Duration difference = expiryDate!.difference(now);

                                            log("difference is ${difference} difference in days is ${difference.inDays}");
                                            if (difference.isNegative) {
                                               isPremium = false; // Setting the local variable to false
                                            //  print("User's premium status: $isPremium");
                                            } else if(difference.inDays < 31) {
                                              // Do something if the expiry time has not passed yet
                                              isPremium=true;
                                            }
                                            else
                                              {
                                                isPremium=false;
                                              }




                                          }

                                        else {
                                          isPremium = true;
                                        }
                                        setState(() {});
                                      }

                                      // TODO: implement listener
                                    },
                                    child: BlocBuilder<PremiumUserCubit,
                                        PremiumUserState>(
                                      builder: (context, state) {
                                        if (state is PremiumUserSuccess) {
                                          // print("tesss"+state.data);
                                          return state.premiumData.isActive ==
                                                      0 ||
                                                  state.premiumData.isActive ==
                                                      2
                                              ? SizedBox()
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                              left: 12,
                                                              bottom: 3)
                                                          .r,
                                                  child: SvgPicture.asset(
                                                    "images/premium_icon.svg",
                                                    color: premiumCheck == '1'
                                                        ? null
                                                        : Colors.grey,
                                                  ),
                                                );
                                        } else {
                                          return SizedBox();
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => NotificationScreen(
                                              guest: widget.guest,
                                            )));
                              },
                              child: Container(
                                width: 40.0.sp,
                                height: 40.0.sp,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Icon(
                                  Icons.notifications_none,
                                  color: AppConstants.appDarkColor,
                                  size: 25.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// Parent Categories
                      BlocBuilder<PremiumParentCategoryCubit,
                          PremiumParentCategoryState>(
                        builder: (context, state) {
                          if (state.status == ParentCategoryStatus.loading) {
                            return SizedBox(
                              height: 130.h,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: AppColor.primaryColor,
                                ),
                              ),
                            );
                          }
                          return SizedBox(
                            height: 130.h,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              padding:
                                  const EdgeInsets.only(top: 15, left: 15).r,
                              itemCount: state.model.data!.length,
                              itemBuilder: (context, index) {
                                final item = state.model.data![index];
                                return ParentCategoryTile(
                                  onTap: () {
                                    //  allCouponPremiumController=AllCouponsPremiumModel(data: [], meta: Meta(pagination: Pagination(total: 0, count: 0, perPage: 0, currentPage: 0, totalPages: 0, links: Links())));

                                    outTab = 1;
                                    categoryId = item.identifier.toString();
                                    check = "notall";
                                    // _pagingController.refresh();
                                    // _pagingController.removePageRequestListener((pageKey) { });
                                    // print(categoryId);
                                    pageNo = 1;

                                    // context
                                    //     .read<CouponCubit>()
                                    //     .getCoupons(item.identifier.toString());
                                    context
                                        .read<AllCouponPremiumCubit>()
                                        .loadPremiumMainData(pageNo, categoryId,
                                            check, widget.guest, "fromnottap");
                                    // context.read<AllCouponPremiumCubit>().loadPremiumMainData(pageNo, categoryId, check);

                                    // _pagingController.addPageRequestListener((pageKey) {
                                    //   context.read<AllCouponPremiumCubit>().loadPremiumMainData(pageKey,categoryId,check);
                                    // });
                                    setState(() {});
                                  },
                                  isClicked:
                                      categoryId == item.identifier.toString()
                                          ? true
                                          : false,
                                  model: item,
                                  countryId: countryId,
                                ).animate().slideX();
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: Column(
            children: [
              /// Tabs
              Container(
                padding: const EdgeInsets.all(4).r,
                margin: const EdgeInsets.only(left: 12, right: 12).r,
                decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.circular(5).r,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: InkWell(
                        onTap: () async {
                          pageNo = 1;
                          context
                              .read<AllCouponPremiumCubit>()
                              .loadPremiumMainData(pageNo, "", "fromall",
                                  widget.guest, "fromnottap");
                          setState(() {
                            isAll = true;
                            categoryId = "";
                            check = "fromall";
                            outTab = 0;
                          });
                          refreshControllerPremium.requestRefresh();
                        },
                        child: Container(
                          height: 45.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isAll && outTab == 0
                                ? AppColor.primaryColor
                                : AppColor.whiteColor,
                            borderRadius: BorderRadius.circular(5).r,
                          ),
                          child: CustomText(
                            "All".tr(),
                            style: Styles.robotoStyle2(
                              fontSize: 14.0.sp,
                              color: isAll && outTab == 0
                                  ? AppColor.whiteColor
                                  : Color(0xff4D4D4D),
                              fontWeight: FontWeight.w900,
                              context: context,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: InkWell(
                        onTap: () {
                          if (widget.guest == true) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          }

                          setState(() {
                            isAll = false;
                            categoryId = "";
                            check = "fromfav";
                            outTab = 0;
                          });
                          refreshControllerPremium.requestRefresh();
                          context
                              .read<AllCouponPremiumCubit>()
                              .loadPremiumMainData(pageNo, categoryId, check,
                                  widget.guest, "fromnottap");
                        },
                        child: Container(
                          height: 45.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isAll == false && outTab == 0
                                ? AppColor.primaryColor
                                : AppColor.whiteColor,
                            borderRadius: BorderRadius.circular(5).r,
                          ),
                          child: CustomText(
                            "Favourite".tr(),
                            style: Styles.robotoStyle2(
                              fontSize: 14.0.sp,
                              color: isAll == false && outTab == 0
                                  ? AppColor.whiteColor
                                  : Color(0xff4D4D4D),
                              fontWeight: FontWeight.w900,
                              context: context,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              ///Coupons
              BlocListener<AllCouponPremiumCubit, AllCouponPremiumState>(
                listener: (context, state) {
                  // if(state is AllCouponPremiumLoaded)
                  //   {
                  //
                  //     final isLastPage =allCouponPremiumController.meta.pagination.totalPages > pageNo;
                  //     if (!isLastPage) {
                  //       _pagingController.appendLastPage(allCouponPremiumController.data);
                  //     } else {
                  //       final nextPageKey = ++pageNo;
                  //       _pagingController.appendPage(allCouponPremiumController.data, nextPageKey);
                  //     }
                  //   }
                  // TODO: implement listener
                },
                child:
                    BlocBuilder<AllCouponPremiumCubit, AllCouponPremiumState>(
                        builder: (context, state) {
                  if (state is AllCouponPremiumLoading) {
                    return Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColor.primaryColor,
                        ),
                      ),
                    );
                  } else if (state is AllCouponPremiumLoaded) {
                    if (pageNo == 1) {
                      allCouponPremiumController.data.sort(
                          (a, b) => b.retailerName.compareTo(a.retailerName));
                    }

                    return Expanded(
                      // child: PagedListView(
                      //   builderDelegate: PagedChildBuilderDelegate<Datum>(
                      //       noItemsFoundIndicatorBuilder: (context) {
                      //         return const CustomText("Nodata found");
                      //       }, itemBuilder: (context, user, index) {
                      //     return PremiumCouponWidget(model: user,);
                      //   }),
                      //   pagingController: _pagingController,
                      // ),
                      child: SmartRefresher(
                        enablePullUp: true,
                        reverse: false,
                        onRefresh: () async {
                          pageNo = 1;
                          refreshControllerPremium.requestRefresh();
                          //getFavourite();

                          var result;
                          if (check == "fromall") {
                            result = context
                                .read<AllCouponPremiumCubit>()
                                .loadPremiumMainData(
                                    pageNo, "", check, widget.guest, "fromtap");
                          } else {
                            result = context
                                .read<AllCouponPremiumCubit>()
                                .loadPremiumMainData(pageNo, categoryId, check,
                                    widget.guest, "fromtap");
                          }
                          if (await result == 200) {
                            refreshControllerPremium.refreshCompleted();
                          } else {
                            refreshControllerPremium.loadNoData();
                          }
                        },
                        onLoading: () async {
                          // state.marketPlaceList = SubCategoryController.list;
                          // refreshController.requestLoading();
                          // SubCategoryController.page =
                          //     SubCategoryController.page + 1;
                          // var result = await context
                          //     .read<MarketplaceCubit>()
                          //     .MarketPlace(widget.data);
                          // if (result) {
                          //   refreshController.loadComplete();
                          //   totalLength = SubCategoryController.list.length;
                          // } else {
                          //   refreshController.loadNoData();
                          // }

                          refreshControllerPremium.requestLoading();
                          print("pageNo+++++");
                          pageNo = pageNo + 1;
                          print(pageNo);
                          if (pageNo >
                              allCouponPremiumController
                                  .meta.pagination.totalPages) {
                            refreshControllerPremium.loadNoData();
                            refreshControllerPremium.loadComplete();
                          } else {
                            if (check == "fromall") {
                              await context
                                  .read<AllCouponPremiumCubit>()
                                  .loadPremiumMainData(pageNo, "", check,
                                      widget.guest, "fromnottap");
                            } else {
                              await context
                                  .read<AllCouponPremiumCubit>()
                                  .loadPremiumMainData(pageNo, categoryId,
                                      check, widget.guest, "fromnottap");
                            }
                            refreshControllerPremium.loadComplete();
                          }
                        },
                        controller: refreshControllerPremium,
                        child: pageNo == 1 &&
                                allCouponPremiumController.data.isEmpty
                            ? Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 20)
                                          .r,
                                  child: CustomText("No data available".tr(),
                                      textAlign: TextAlign.center,
                                      style: Styles.robotoStyle2(
                                        fontSize: 18.0.sp,
                                        color: AppColor.primaryColor,
                                        fontWeight: FontWeight.w500,
                                        context: context,
                                      )),
                                ),
                              )
                            : ListView.builder(
                                itemCount:
                                    allCouponPremiumController.data.length,
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final item =
                                      allCouponPremiumController.data[index];
                                  //print(index);

                                  bool isFav = false;

                                  for (var i
                                      in ServicesAllCoupons.favouriteCoupons) {
                                    // print(i["identifier"]);
                                    if (i['identifier'] == item.identifier) {
                                      //isFav=true;
                                      item.isFav = true;
                                      print("here2");
                                      break;
                                    }
                                  }

//print(index);
                                  // print(item.barcodeQrUrl+"ur");
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                            left: 12, right: 12, top: 15)
                                        .r,
                                    child: PremiumCouponWidget(
                                      controller: refreshControllerPremium,
                                      model: item,
                                      index: index,
                                      premiumCheck: premiumCheck,
                                      guest: widget.guest,
                                      isFavParent: isFav,
                                      check: check,
                                      isPremium: isPremium,
                                      onFromFavTap: (String) {
                                        allCouponPremiumController.data
                                            .removeAt(index);
                                        setState(() {});
                                      },
                                    ).animate().slideY(),
                                  );
                                },
                              ),
                      ),
                    );
                  } else if (state is AllCouponPremiumUnknownError) {
                    return Expanded(
                        child: Center(
                      child: CustomText("Something Went Wrong"),
                    ));
                  } else {
                    return Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColor.primaryColor,
                        ),
                      ),
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
