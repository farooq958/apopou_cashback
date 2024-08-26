import 'dart:developer';
import 'package:cashback/controller/AppConstants.dart';
import 'package:cashback/controller/all_products_controller.dart';
import 'package:cashback/controller/cashback_icons.dart';
import 'package:cashback/controller/categories_cubit.dart';
import 'package:cashback/controller/retailers_search_cubit/retailers_search_cubit.dart';
import 'package:cashback/model/retailers_search_model.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:cashback/view/homeSearch/search_detail_screen.dart';
import 'package:cashback/view/store_details.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cashback/view/imports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/all_favourite_controller.dart';
import '../../controller/all_favourite_products_cubit.dart';
import '../../controller/searchHeightCubit.dart';
import 'search_items_favorite.dart';

class SearchClickScreen extends StatefulWidget {
  bool guest;

  SearchClickScreen({
    required this.guest,
  });

  @override
  State<SearchClickScreen> createState() => _SearchClickScreenState();
}

class _SearchClickScreenState extends State<SearchClickScreen> {
  FocusNode node = FocusNode();

  List<String> assetsArray = [
    "images/marketplace.png",
    "images/electronics.png",
    "images/home.png",
    "images/home.png",
  ];
  List<String> categories = [
    "Marketplaces",
    "Electronics",
    "Home Appliances",
    "Electronics",
  ];

  TextEditingController search = TextEditingController();

  @override
  void initState() {
    context.read<CategoriesCubit>().categories();
    super.initState();
  }

  @override
  void dispose() {
    search.dispose();
    RetailerSearchController.data.data = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        AllFavouriteController.page = 1;
        AllFavouriteController.listData.clear();
        await context.read<AllFavouriteProductsCubit>().refreshFavourite();
        // setState(() {});
        // log("Kar kae");
        return true;
      },
      child: Scaffold(
        body: SizedBox(
          width: 1.sw,
          height: 1.sh,
          child: ListView(
            children: [
              SizedBox(
                height: 30.sp,
              ),
              Container(
                padding: AppConstants.screenPadding,
                height: 50.sp,
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: TextField(
                        autofocus: true,
                        focusNode: node,
                        controller: search,
                        style: TextStyle(color: Colors.black),
                        onChanged: (x) {
                          context.read<SearchHeightCubit>().setHeight(true);
                          if (x.isEmpty) {
                            context.read<SearchHeightCubit>().setHeight(false);
                            context
                                .read<RetailersSearchCubit>()
                                .searchRetailer("");
                            node.unfocus();
                          }
                          context
                              .read<RetailersSearchCubit>()
                              .searchRetailer(search.text.trim());
                        },
                        onSubmitted: (x) {
                          context
                              .read<RetailersSearchCubit>()
                              .searchRetailer(search.text.trim());
                        },
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.arrow_forward,
                                size: 24.sp,
                              ),
                              onPressed: () {
                                node.unfocus();
                                context
                                    .read<RetailersSearchCubit>()
                                    .searchRetailer(search.text.trim());
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0.sp),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30.0.sp),
                            ),
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey[800]),
                            hintText: "Type in your text".tr(),
                            fillColor: Colors.white70),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          context.read<SearchHeightCubit>().setHeight(false);
                          // context.read<RetailersSearchCubit>().searchRetailer("");
                          RetailerSearchController.data = RetailersSearchModel(
                            data: [],
                          );
                          setState(() {});
                          Navigator.pop(context);
                        },
                        child: CustomText(
                          'Cancel'.tr(),
                          style: Styles.robotoStyle(
                            FontWeight.w900,
                            14.0.sp,
                            const  Color(0xFF363636),
                            context,

                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: context.watch<SearchHeightCubit>().state == true
                    ? 20.sp
                    : 20.sp,
              ),
              AnimatedContainer(
                duration: Duration(seconds: 1),
                height: context.watch<SearchHeightCubit>().state == true
                    ? 0.sp
                    : 80.sp,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: AllProductsController.data.data.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // ? AllProductsController.data.data
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StoreDetails(
                                      getFavouriteState: () {
                                        setState(() {});
                                      },
                                      index: index,
                                      guest: widget.guest,
                                      id: AllProductsController
                                          .listData[index].identifier)));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: index == 0 ? 20.sp : 0, right: 40.sp),
                          height: 95,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Container(
                                  width: 70.sp,
                                  height: 70.0.sp,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(11.0.sp),
                                    color: Colors.white,
                                  ),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(11.0.sp),
                                    child: Image.network(
                                      AllProductsController
                                          .data.data[index].storeImgUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),

                              /// todo include category removed
                              Expanded(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: CustomText(
                                    AllProductsController
                                        .data.data[index].storeName,
                                    // AllProductsController
                                    //         .data.data[index].categories.data
                                    //         .asMap()
                                    //         .containsKey(0)
                                    //     ? AllProductsController
                                    //         .data.data[index].storeName
                                    //     // AllProductsController.data.data[index]
                                    //     //     .categories.data[0].categoryTitle
                                    //     : "N/A",
                                    style: Styles.robotoStyle(
                                      FontWeight.w900,
                                      14.0.sp,
                                      const  Color(0xFF363636),
                                      context,

                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: context.watch<SearchHeightCubit>().state == true
                    ? 0.sp
                    : 20.sp,
              ),
              //! categories feature search .....
              // Padding(
              //   padding: AppConstants.screenPadding,
              //   child: AnimatedContainer(
              //     // ? todo
              //     height: context.watch<SearchHeightCubit>().state == true
              //         ? 0.sp
              //         : 14.sp,
              //     duration: Duration(seconds: 1),
              //     child: Align(
              //       alignment: Alignment.centerLeft,
              //       child: CustomText(
              //         'Featured Categories'.tr(),
              //         style: Styles.robotoStyle(
              //           fontSize: 14.0.sp,
              //           color: const Color(0xFF363636),
              //           fontWeight: FontWeight.w900,
              //         ),
              //         textAlign: TextAlign.right,
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: context.watch<SearchHeightCubit>().state == true
              //       ? 0.sp
              //       : 20.sp,
              // ),
              // AnimatedContainer(
              //   // color: Colors.red,
              //   duration: Duration(seconds: 1),
              //   padding: AppConstants.screenPadding,
              //   child: BlocBuilder<CategoriesCubit, CategoriesState>(
              //     builder: (context, state) {
              //       return state is CategoriesLoading
              //           ? const Center(
              //               child: CircularProgressIndicator(),
              //             )
              //           : AnimatedContainer(
              //               duration: Duration(seconds: 1),
              //               height:
              //                   context.watch<SearchHeightCubit>().state == true
              //                       ? 0.sp
              //                       : 230.sp,
              //               child: Wrap(
              //                 spacing: 8, // space between items
              //                 children: context
              //                             .watch<SearchHeightCubit>()
              //                             .state ==
              //                         true
              //                     ? []
              //                     : [
              //                         for (var i = 0;
              //                             i <
              //                                 CategoriesController
              //                                     .data.data.length;
              //                             i++) ...[
              //                           GestureDetector(
              //                             onTap: () {
              //                               log("testing index ${i + 1}");
              //                               Navigator.push(
              //                                   context,
              //                                   MaterialPageRoute(
              //                                       builder: (context) =>
              //                                           MarketPlace(
              //                                             data:
              //                                                 CategoriesController
              //                                                     .data
              //                                                     .data[i]
              //                                                     .identifier,
              //                                             guest: false,
              //                                             catName:
              //                                                 CategoriesController
              //                                                     .data
              //                                                     .data[i]
              //                                                     .categoryTitle,
              //                                           )));
              //                             },
              //                             child: Container(
              //                                 height: context
              //                                             .watch<
              //                                                 SearchHeightCubit>()
              //                                             .state ==
              //                                         true
              //                                     ? 0.sp
              //                                     : 35.sp,
              //                                 child: AnimatedContainer(
              //                                   duration: Duration(seconds: 1),
              //                                   margin: const EdgeInsets.only(
              //                                       right: 5, bottom: 5),
              //                                   padding: const EdgeInsets.all(9),
              //                                   decoration: BoxDecoration(
              //                                     borderRadius:
              //                                         BorderRadius.circular(5.0),
              //                                     color: const Color(0xFFE8E8E8),
              //                                   ),
              //                                   child: CustomText(CategoriesController
              //                                       .data.data[i].categoryTitle),
              //                                 )),
              //                           ),
              //                         ],
              //                       ],

              //                 // CategoriesController.data.data
              //                 //     .map((e) => AnimatedContainer(
              //                 //           duration: Duration(seconds: 1),
              //                 //           margin: const EdgeInsets.only(
              //                 //               right: 5, bottom: 5),
              //                 //           padding: const EdgeInsets.all(9),
              //                 //           decoration: BoxDecoration(
              //                 //             borderRadius:
              //                 //                 BorderRadius.circular(5.0),
              //                 //             color: const Color(0xFFE8E8E8),
              //                 //           ),
              //                 //           child: CustomText(e.categoryTitle),
              //                 //         )
              //                 //         ).toList()
              //                 // ,]
              //               ),
              //             );
              //     },
              //   ),
              // ),

              AnimatedContainer(
                duration: Duration(seconds: 1),
                height: 18.sp,
                child: Padding(
                  padding: AppConstants.screenPadding,
                  child: CustomText(
                    'Αποτελέσματα Αναζήτησης Καταστημάτων',
                    style: Styles.robotoStyle(
                      FontWeight.w900,
                      14.0.sp,
                      const  Color(0xFF363636),
                      context,

                    ),
                  ),
                ),
              ),
              BlocBuilder<RetailersSearchCubit, RetailersSearchState>(
                builder: (context, state) {
                  if (state is RetailersSearchLoaded) {
                    return AnimatedContainer(
                      duration: Duration(seconds: 1),
                      margin: EdgeInsets.only(top: 10.sp),
                      height: context.watch<SearchHeightCubit>().state == true
                          ? MediaQuery.of(context).size.height * .75
                          : 450.sp,
                      //280
                      child: RetailerSearchController.data.data.length == 0
                          ? Container(
                              height: 100.sp,
                              width: 100.sp,
                              child: Center(
                                child: CustomText(
                                  "Δεν βρέθηκαν καταστήματα",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  RetailerSearchController.data.data.length,
                              itemBuilder: (context, index) {
                                log("DATAAAA ${RetailerSearchController.data.data[index].favoriters}");
                                return customTile(index);

                                //old work
                                // GestureDetector(
                                //   onTap: () {
                                //     Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //             builder: (context) => StoreDetails(
                                //                 getFavouriteState: () {
                                //                   setState(() {});
                                //                 },
                                //                 index: index,
                                //                 guest: widget.guest,
                                //                 id: RetailerSearchController
                                //                     .data
                                //                     .data[index]
                                //                     .identifier)));
                                //   },
                                //   child: Container(
                                //     padding: EdgeInsets.all(10.sp),
                                //     margin: EdgeInsets.only(bottom: 10.sp),
                                //     width: 334.0,
                                //     height: 111.0,
                                //     decoration: BoxDecoration(
                                //       borderRadius: BorderRadius.circular(5.0),
                                //       color: Colors.white,
                                //     ),
                                //     child: Row(
                                //       children: [
                                //         Expanded(
                                //           child: Container(
                                //             width: 80.0.sp,
                                //             height: 80.0.sp,
                                //             decoration: BoxDecoration(
                                //               borderRadius:
                                //                   BorderRadius.circular(5.0),
                                //             ),
                                //             child: Image.network(
                                //                 RetailerSearchController.data
                                //                     .data[index].storeImgUrl
                                //                     .toString()),
                                //           ),
                                //         ),
                                //         Expanded(
                                //           flex: 4,
                                //           child: Container(
                                //             padding:
                                //                 EdgeInsets.only(left: 20.sp),
                                //             child: Column(
                                //               children: [
                                //                 Expanded(
                                //                   child: Row(
                                //                     children: [
                                //                       Expanded(
                                //                         child: Align(
                                //                           alignment:
                                //                               Alignment.topLeft,
                                //                           child: FittedBox(
                                //                             fit: BoxFit
                                //                                 .scaleDown,
                                //                             child: CustomText(
                                //                               RetailerSearchController
                                //                                   .data
                                //                                   .data[index]
                                //                                   .storeName,
                                //                               style: GoogleFonts
                                //                                   .roboto(
                                //                                 fontSize:
                                //                                     16.0.sp,
                                //                                 color: const Color(
                                //                                     0xFF363636),
                                //                                 fontWeight:
                                //                                     FontWeight
                                //                                         .w900,
                                //                               ),
                                //                             ),
                                //                           ),
                                //                         ),
                                //                       ),
                                //                       Expanded(
                                //                         child: Align(
                                //                           alignment: Alignment
                                //                               .topCenter,
                                //                           child: FittedBox(
                                //                             fit: BoxFit
                                //                                 .scaleDown,
                                //                             child: CustomText(
                                //                               RetailerSearchController
                                //                                   .data
                                //                                   .data[index]
                                //                                   .storeCashback
                                //                                   .toString(),
                                //                               style: GoogleFonts
                                //                                   .roboto(
                                //                                 fontSize:
                                //                                     20.0.sp,
                                //                                 color: const Color(
                                //                                     0xFFFC4F08),
                                //                                 fontWeight:
                                //                                     FontWeight
                                //                                         .w900,
                                //                               ),
                                //                               textAlign:
                                //                                   TextAlign
                                //                                       .center,
                                //                             ),
                                //                           ),
                                //                         ),
                                //                       ),
                                //                     ],
                                //                   ),
                                //                 ),
                                //                 Expanded(
                                //                     child: Row(
                                //                   children: [
                                //                     Expanded(
                                //                       child: Align(
                                //                         alignment: Alignment
                                //                             .centerLeft,
                                //                         child: FittedBox(
                                //                           fit: BoxFit.scaleDown,
                                //                           child: CustomText(
                                //                             RetailerSearchController
                                //                                     .data
                                //                                     .data[index]
                                //                                     .categories
                                //                                     .data
                                //                                     .asMap()
                                //                                     .containsKey(
                                //                                         0)
                                //                                 ? RetailerSearchController
                                //                                     .data
                                //                                     .data[index]
                                //                                     .categories
                                //                                     .data[0]
                                //                                     .categoryTitle
                                //                                 : "N/A",
                                //                             style: GoogleFonts
                                //                                 .roboto(
                                //                               fontSize: 14.0.sp,
                                //                               color: const Color(
                                //                                   0xFF363636),
                                //                               fontWeight:
                                //                                   FontWeight
                                //                                       .w500,
                                //                             ),
                                //                           ),
                                //                         ),
                                //                       ),
                                //                     ),
                                //                     Expanded(
                                //                       child: FittedBox(
                                //                         fit: BoxFit.scaleDown,
                                //                         child: CustomText(
                                //                           'Cashback Up to ',
                                //                           style: GoogleFonts
                                //                               .roboto(
                                //                             fontSize: 14.0.sp,
                                //                             color: const Color(
                                //                                 0xFFA7A7A7),
                                //                             fontWeight:
                                //                                 FontWeight.w500,
                                //                           ),
                                //                           textAlign:
                                //                               TextAlign.center,
                                //                         ),
                                //                       ),
                                //                     )
                                //                   ],
                                //                 )),
                                //                 Expanded(
                                //                   flex: 2,
                                //                   child: Row(
                                //                     children: [
                                //                       Expanded(
                                //                         flex: 2,
                                //                         child: Column(
                                //                           children: [
                                //                             Expanded(
                                //                               child: Row(
                                //                                 children: [
                                //                                   Expanded(
                                //                                     child:
                                //                                         Align(
                                //                                       alignment:
                                //                                           Alignment
                                //                                               .centerLeft,
                                //                                       child:
                                //                                           Icon(
                                //                                         Cashback
                                //                                             .coupon,
                                //                                         color: AppConstants
                                //                                             .appDarkColor,
                                //                                       ),
                                //                                     ),
                                //                                   ),
                                //                                   Expanded(
                                //                                     flex: 2,
                                //                                     child:
                                //                                         Align(
                                //                                       alignment:
                                //                                           Alignment
                                //                                               .centerLeft,
                                //                                       child:
                                //                                           FittedBox(
                                //                                         fit: BoxFit
                                //                                             .scaleDown,
                                //                                         child:
                                //                                             CustomText(
                                //                                           RetailerSearchController
                                //                                               .data
                                //                                               .data[index]
                                //                                               .couponsCount
                                //                                               .toString(),
                                //                                           style:
                                //                                               Styles.robotoStyle(
                                //                                             fontSize:
                                //                                                 16.0.sp,
                                //                                             color:
                                //                                                 const Color(0xFF363636),
                                //                                             fontWeight:
                                //                                                 FontWeight.w900,
                                //                                           ),
                                //                                         ),
                                //                                       ),
                                //                                     ),
                                //                                   )
                                //                                 ],
                                //                               ),
                                //                             ),
                                //                             Expanded(
                                //                               child: Align(
                                //                                 alignment: Alignment
                                //                                     .centerLeft,
                                //                                 child:
                                //                                     FittedBox(
                                //                                   fit: BoxFit
                                //                                       .scaleDown,
                                //                                   child: CustomText(
                                //                                     'Coupons'
                                //                                         .tr(),
                                //                                     style: GoogleFonts
                                //                                         .roboto(
                                //                                       fontSize:
                                //                                           14.0.sp,
                                //                                       color: const Color(
                                //                                           0xFFA7A7A7),
                                //                                       fontWeight:
                                //                                           FontWeight
                                //                                               .w500,
                                //                                     ),
                                //                                   ),
                                //                                 ),
                                //                               ),
                                //                             )
                                //                           ],
                                //                         ),
                                //                       ),
                                //                       Expanded(
                                //                         flex: 2,
                                //                         child: Column(
                                //                           children: [
                                //                             Expanded(
                                //                               child: Row(
                                //                                 children: [
                                //                                   Expanded(
                                //                                     child:
                                //                                         Align(
                                //                                       alignment:
                                //                                           Alignment
                                //                                               .centerLeft,
                                //                                       child:
                                //                                           Icon(
                                //                                         Cashback
                                //                                             .bag,
                                //                                         color: AppConstants
                                //                                             .appDarkColor,
                                //                                       ),
                                //                                     ),
                                //                                   ),
                                //                                   Expanded(
                                //                                     flex: 2,
                                //                                     child:
                                //                                         Align(
                                //                                       alignment:
                                //                                           Alignment
                                //                                               .centerLeft,
                                //                                       child:
                                //                                           FittedBox(
                                //                                         fit: BoxFit
                                //                                             .scaleDown,
                                //                                         child:
                                //                                             CustomText(
                                //                                           RetailerSearchController
                                //                                               .data
                                //                                               .data[index]
                                //                                               .productsCount
                                //                                               .toString(),
                                //                                           style:
                                //                                               Styles.robotoStyle(
                                //                                             fontSize:
                                //                                                 16.0.sp,
                                //                                             color:
                                //                                                 const Color(0xFF363636),
                                //                                             fontWeight:
                                //                                                 FontWeight.w900,
                                //                                           ),
                                //                                         ),
                                //                                       ),
                                //                                     ),
                                //                                   )
                                //                                 ],
                                //                               ),
                                //                             ),
                                //                             Expanded(
                                //                               child: Align(
                                //                                 alignment: Alignment
                                //                                     .centerLeft,
                                //                                 child:
                                //                                     FittedBox(
                                //                                   fit: BoxFit
                                //                                       .scaleDown,
                                //                                   child: CustomText(
                                //                                     'Products'
                                //                                         .tr(),
                                //                                     style: GoogleFonts
                                //                                         .roboto(
                                //                                       fontSize:
                                //                                           14.0.sp,
                                //                                       color: const Color(
                                //                                           0xFFA7A7A7),
                                //                                       fontWeight:
                                //                                           FontWeight
                                //                                               .w500,
                                //                                     ),
                                //                                   ),
                                //                                 ),
                                //                               ),
                                //                             )
                                //                           ],
                                //                         ),
                                //                       ),
                                //                       Expanded(
                                //                         child: Align(
                                //                           alignment: Alignment
                                //                               .bottomCenter,
                                //                           child:
                                //                               SearchItemFavorite(
                                //                             index: index,
                                //                             guest: widget.guest,
                                //                             updateFavorite: () {
                                //                               setState(() {});
                                //                             },
                                //                           ),
                                //                         ),
                                //                       ),

                                //                       // Expanded(
                                //                       //   child: RetailerSearchController
                                //                       //               .data
                                //                       //               .data[index]
                                //                       //               .favoriters ==
                                //                       //           0
                                //                       //       ? Align(
                                //                       //           alignment: Alignment
                                //                       //               .bottomCenter,
                                //                       //           child:
                                //                       //               GestureDetector(
                                //                       //             behavior:
                                //                       //                 HitTestBehavior
                                //                       //                     .opaque,
                                //                       //             onTap: () {
                                //                       //               // var data = RetailerSearchController
                                //                       //               //     .data.data
                                //                       //               //     .where((element) =>
                                //                       //               //         element
                                //                       //               //             .identifier ==
                                //                       //               //         RetailerSearchController
                                //                       //               //             .data
                                //                       //               //             .data[index]
                                //                       //               //             .identifier)
                                //                       //               //     .toList();
                                //                       //               // log("ddddd ${data[index].favoriters}");
                                //                       //               context
                                //                       //                   .read<
                                //                       //                       AddToFavCubit>()
                                //                       //                   .addToFav(
                                //                       //                       id: AllProductsController
                                //                       //                           .listData[
                                //                       //                               index]
                                //                       //                           .identifier,
                                //                       //                       context:
                                //                       //                           context,
                                //                       //                       index:
                                //                       //                           index,
                                //                       //                       type:
                                //                       //                           'all')
                                //                       //                   .whenComplete(
                                //                       //                       () {
                                //                       //                 setState(
                                //                       //                     () {});
                                //                       //               });
                                //                       //             },
                                //                       //             child: Icon(
                                //                       //                 Icons
                                //                       //                     .favorite,
                                //                       //                 color: Colors
                                //                       //                     .grey),
                                //                       //           ),
                                //                       //         )
                                //                       //       : Align(
                                //                       //           alignment: Alignment
                                //                       //               .bottomCenter,
                                //                       //           child:
                                //                       //               GestureDetector(
                                //                       //             behavior:
                                //                       //                 HitTestBehavior
                                //                       //                     .opaque,
                                //                       //             onTap: () {
                                //                       //               context
                                //                       //                   .read<
                                //                       //                       RemoveFavCubit>()
                                //                       //                   .removeFav(
                                //                       //                       id: AllProductsController
                                //                       //                           .listData[
                                //                       //                               index]
                                //                       //                           .identifier,
                                //                       //                       context:
                                //                       //                           context,
                                //                       //                       index:
                                //                       //                           index,
                                //                       //                       type:
                                //                       //                           "all")
                                //                       //                   .whenComplete(
                                //                       //                       () {
                                //                       //                 setState(
                                //                       //                     () {});
                                //                       //               });
                                //                       //             },
                                //                       //             child: Icon(
                                //                       //                 Icons
                                //                       //                     .favorite,
                                //                       //                 color: Colors
                                //                       //                     .red),
                                //                       //           ),
                                //                       //         ),
                                //                       // ),
                                //                     ],
                                //                   ),
                                //                 )
                                //               ],
                                //             ),
                                //           ),
                                //         )
                                //       ],
                                //     ),
                                //   ),
                                // );
                              }),
                    );
                  } else if (state is RetailersSearchLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Container();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget customTile(int index) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SearchDetailScreen(
                    getFavouriteState: () {
                      setState(() {});
                    },
                    index: index,
                    guest: widget.guest,
                    id: RetailerSearchController.data.data[index].identifier)));
      },
      child: Container(
        padding: EdgeInsets.all(10.sp),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4).r,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
              width: 75.0.sp,
              height: 75.0.sp,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Image.network(RetailerSearchController
                  .data.data[index].storeImgUrl
                  .toString()),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        RetailerSearchController.data.data[index].storeName,
                        style: Styles.robotoStyle(
                          FontWeight.w900,
                          16.0.sp,
                          const  Color(0xFF363636),
                          context,

                        ),
                      ),
                      CustomText(
                        RetailerSearchController.data.data[index].storeCashback
                            .toString(),
                        style: Styles.robotoStyle(
                          FontWeight.w900,
                          20.0.sp,
                          const Color(0xFFFC4F08),
                          context,

                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: CustomText(
                      'Cashback'.tr(),
                      style: Styles.robotoStyle(
                        FontWeight.w500,
                        15.0.sp,
                        const Color(0xFFA7A7A7),
                        context,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Cashback.coupon,
                                color: AppConstants.appDarkColor,
                              ),
                              SizedBox(width: 5),
                              CustomText(
                                RetailerSearchController
                                    .data.data[index].couponsCount
                                    .toString(),
                                style: Styles.robotoStyle(
                                  FontWeight.w900,
                                  16.0.sp,
                                  const Color(0xFF363636),
                                  context,

                                ),
                              ),
                            ],
                          ),
                          CustomText(
                            'Coupons'.tr(),
                            style: Styles.robotoStyle(
                              FontWeight.w500,
                                14.0.sp,
                                const Color(0xFFA7A7A7),
                              context,

                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20).r,
                        child: SearchItemFavorite(
                          index: index,
                          guest: widget.guest,
                          updateFavorite: () {
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
