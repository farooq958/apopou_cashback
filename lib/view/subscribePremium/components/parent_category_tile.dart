import 'package:cashback/controller/services/apis.dart';
import 'package:cashback/controller/testserver.dart';
import 'package:cashback/model/premium/parent_category_model.dart';
import 'package:cashback/view/custom_widgets/app_color.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cashback/view/imports.dart';
class ParentCategoryTile extends StatelessWidget {
  final ParentCategoryDataModel model;
  final String countryId;
  final VoidCallback onTap;
  final bool isClicked;
  const ParentCategoryTile({
    Key? key,
    required this.model,
    required this.countryId,
    required this.onTap,
    required this.isClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print("imagePath");
    // print("path"+model.imgPath.toString()+ "path");
    // print(model.imgPath!.isEmpty);
    // print( "${finalServer}${model.imgPath.toString()}");
    return GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.only(right: 12).r,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(15.sp),
                margin: const EdgeInsets.only(bottom: 5).r,
                width: 97.33.sp,
                height: 70.0.sp,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11.0.sp),
                  color: Colors.white,
                  border: Border.all(
                    color:
                        isClicked ? AppColor.primaryColor : Colors.transparent,
                  ),
                ),
                child: model.imgPath!.isNotEmpty
                    ? Center(
                  /// ${countryId == "1" ? BaseUrl : cyprusBaseUrl}${model.imgPath.toString()}
                        child: SvgPicture.network(
                        "${finalServer}${model.imgPath.toString().trim()}",
                        width: 97.33.sp,
                        // headers: {
                        //   'Cookie':'_hjSessionUser_2775544=eyJpZCI6IjUyM2EwNjliLTUwM2MtNTA4ZC04NWQ1LTQxMTllOTIyZDg3MiIsImNyZWF0ZWQiOjE2ODE4ODgzNDQzOTYsImV4aXN0aW5nIjp0cnVlfQ==; _gcl_au=1.1.190808563.1698304391; _fbp=fb.1.1698304391575.1393081698; __gads=ID=cd50ca51f3d42149-226d23e66ee000a3:T=1698304391:RT=1698398385:S=ALNI_MaC0tHRd5vDYjuse_018mei0VM_5A; __gpi=UID=00000cc1c9f6c6ad:T=1698304391:RT=1698398385:S=ALNI_Maj-6i0ruZGaBklHYQOIG6XuESFkg; _ga_TY4FHRLE6B=GS1.1.1698398385.3.0.1698398385.60.0.0; _ga=GA1.2.483774706.1698304391'
                        // },
                        height: 70.0.sp,
                        fit: BoxFit.contain,
                      ))
                    : Image.asset(
                        "images/no_store.png",
                        width: 97.33.sp,
                        height: 70.0.sp,
                      ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomText(
                  model.name ?? "",
                  style: Styles.robotoStyle2(
                    fontSize: 14.0.sp,
                    color: const Color(0xFF363636),
                    fontWeight: FontWeight.w900, context: context,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ));
  }
}
