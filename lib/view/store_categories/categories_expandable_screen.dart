import 'dart:developer';
import 'package:cashback/controller/AppConstants.dart';
import 'package:cashback/controller/categoryCubit/ParentCategory/parent_category_cubit.dart';
import 'package:cashback/controller/services/category_services.dart';
import 'package:cashback/controller/testserver.dart';
import 'package:cashback/model/servicesModel/parentCategory.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:cashback/view/market_place/marketplace.dart';
import 'package:cashback/view/store_categories/sub_categories_detail_screen.dart';
import 'package:cashback/view/store_details.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:cashback/view/imports.dart';
import '../../controller/services/apis.dart';

class CategoriesExpanable extends StatefulWidget {
  final bool guest;
  const CategoriesExpanable({Key? key, required this.guest}) : super(key: key);

  @override
  State<CategoriesExpanable> createState() => _CategoriesExpanableState();
}

class _CategoriesExpanableState extends State<CategoriesExpanable> {
  List _elements = [];
  bool isLoaded = false;

  @override
  void initState() {
    context.read<ParentCategoryCubit>().getParentCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
            width: 1.sw,
            height: 1.sh,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: AppConstants.screenPadding,
                    child: Column(
                      children: [
                        Expanded(
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  size: 25.sp,
                                  color: Colors.black,
                                ),
                              )),
                        ),

                        ///store categories
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: CustomText(
                              'Κατηγορίες Καταστημάτων',
                              style: Styles.robotoStyle(
                                FontWeight.w900,
                                26.0.sp,
                                const Color(0xFF363636),
                                context,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: BlocBuilder<ParentCategoryCubit, ParentCategoryState>(
                    builder: (context, state) {
                      if (state.status == ParentCategoryStatus.loading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (state.status == ParentCategoryStatus.success) {
                        _elements = [];
                        state.list.forEach((e) {
                          print(e.ICO);
                          _elements.add({
                            'id': e.identifier,
                            'name': e.categoryTitle,
                            'su': e.sucategories,
                            "icon": e.ICO,
                            'group': e.categoryTitle.substring(0, 1)
                          });
                        });
                      }
                      return GroupedListView<dynamic, String>(
                        elements: _elements,
                        groupBy: (element) => element['group'],
                        groupComparator: (value1, value2) =>
                            value2.compareTo(value1),
                        itemComparator: (item1, item2) =>
                            item1['name'].compareTo(item2['name']),
                        order: GroupedListOrder.DESC,
                        useStickyGroupSeparators: true,
                        groupSeparatorBuilder: (String value) =>SizedBox(height: 0.sp,),
                        itemBuilder: (c, element) {
                          return Container(
                            margin: EdgeInsets.only(
                              bottom: 20.sp,
                            ),
                            padding: EdgeInsets.only(right: 15.sp),
                            color: Colors.white,
                            child: ExpandablePanel(
                                theme: ExpandableThemeData(
                                    tapHeaderToExpand: true,
                                    hasIcon: true,
                                    headerAlignment:
                                        ExpandablePanelHeaderAlignment.center,
                                    alignment: Alignment.center),
                                header: Container(
                                  padding: EdgeInsets.all(12.sp),
                                  height: 59.0.sp,

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.white,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isLoaded = true;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                              // color: Colors.green,
                                              constraints: BoxConstraints(
                                                maxHeight: 80.0.sp,
                                                maxWidth: 80.0.sp,
                                                minHeight: 80.0.sp,
                                                minWidth: 80.0.sp,
                                              ),
                                              alignment: Alignment.centerLeft,
                                              child: SvgPicture.network(
                                                "${finalServer}${element['icon']}",
                                                width: 80.sp,
                                                height: 80.sp,
                                              )),
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Expanded(
                                            flex: 5,
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Align(
                                                            alignment: Alignment
                                                                .bottomLeft,
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                //! todo
                                                                log("tewsting ${element['id']}  ${element['name']}");
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (_) =>
                                                                            MarketPlace(
                                                                              catName: element['name'],
                                                                              guest: widget.guest,
                                                                              data: element['id'],
                                                                            )));
                                                              },
                                                              child: CustomText(
                                                                '${element['name']}',
                                                                style:
                                                                    GoogleFonts
                                                                        .roboto(
                                                                  fontSize:
                                                                      14.0.sp,
                                                                  color: const Color(
                                                                      0xFF363636),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
                                                                ),
                                                              ),
                                                            )),
                                                      ),
                                                      Expanded(
                                                        child: Align(
                                                          alignment: Alignment
                                                              .bottomRight,
                                                          // child: Icon(
                                                          //   Icons
                                                          //       .keyboard_arrow_down_rounded,
                                                          //   size: 24.sp,
                                                          // ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                // SizedBox(
                                                //   height: 4.sp,
                                                // ),
                                              ],
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                                collapsed: Container(
                                  height: 0.sp,
                                  color: Colors.grey,
                                ),
                                expanded: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.sp, vertical: 5.sp),
                                    child: ListView.builder(
                                        itemCount: element['su'].length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              // log("INDEX ${_elements[index]["id"]}");
                                              // var i = _elements.indexWhere(
                                              //     (e) =>
                                              //         e["id"] == element['id']);
                                              // log("IIIII $i");
                                              Category cat =
                                                  element['su']?[index];

                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      MarketPlace(
                                                    data: cat.category_id,
                                                    catName: cat.name,
                                                    guest: widget.guest,
                                                  ),
                                                ),
                                              );

                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) =>
                                              //             SubCategoryDetailScreen(
                                              //                 getFavouriteState:
                                              //                     () {
                                              //                   setState(() {});
                                              //                 },
                                              //                 index: index,
                                              //                 guest:
                                              //                     widget.guest,
                                              //                 id: cat
                                              //                     .category_id)));
                                            },
                                            child: Container(

                                              margin:
                                                  EdgeInsets.only(top: 10.sp),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: CustomText(
                                                        '${element['su'][index].name}',
                                                        style:
                                                            Styles.robotoStyle(
                                                              FontWeight.w500,
                                                              18.0.sp,
                                                              const Color(0xFF363636),
                                                              context,

                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Icon(
                                                        Icons
                                                            .arrow_forward_ios_rounded,
                                                        size: 15.sp,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        }))),
                          );
                        },
                      );
                    },
                  ),
                )
              ],
            )),
      ),
    );
  }
}
