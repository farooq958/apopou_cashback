import 'package:cashback/model/balance/click_history_model.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../custom_widgets/app_color.dart';
import 'package:cashback/view/imports.dart';

class HistoryDetailScreen extends StatelessWidget {
  final ClickHistoryData model;
  const HistoryDetailScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textAndBack(context),
              space(15),
              buildListTile(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListTile(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 25).r,
      margin: EdgeInsets.symmetric(vertical: 1).r,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildCustomText(title: "Click ID", subtitle: model.identifier.toString(), contex: context),
          divider(),
          buildCustomText(title: "Store Name", subtitle: model.retailor.toString(),contex: context),
          divider(),
          buildCustomText(
              title: "Retailer ID", subtitle: model.retailerID.toString(),contex: context),
          divider(),
          buildCustomText(title: "Click IP", subtitle: model.clickIp.toString(),contex: context),
          divider(),
          buildCustomText(title: "Date", subtitle: model.dateAdded.toString(), contex: context),
        ],
      ),
    );
  }

  Widget buildCustomText({required String title, required String subtitle,required BuildContext contex}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomText(
              title.tr(),
              style: Styles.robotoStyle(
                FontWeight.bold,
                18,
                AppColor.primaryColor,contex
              ),
            ),
          ],
        ),
        space(5),
        CustomText(
          subtitle,
          style: Styles.robotoStyle(
            FontWeight.normal,
            17,
            AppColor.blackColor,contex
          ),
        ),
      ],
    );
  }

  Container divider() {
    return Container(
      height: 1.h,
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 15).r,
      color: AppColor.greyColor,
    );
  }

  Widget textAndBack(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12).r,
      child: Column(
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
            "History Details".tr(),
            style: Styles.robotoStyle(
              FontWeight.bold,
              26,
              AppColor.blackColor,context
            ),
          ),
          space(15),
        ],
      ),
    );
  }

  Widget space(double height) {
    return SizedBox(
      height: height.h,
    );
  }
}
