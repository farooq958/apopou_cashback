import 'package:cashback/controller/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../model/balance/transaction_history_model.dart';
import '../custom_widgets/app_color.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:cashback/view/imports.dart';

class TrasectionDetailScreen extends StatefulWidget {
  final TransectionData model;
  const TrasectionDetailScreen({
    super.key,
    required this.model,
  });

  @override
  State<TrasectionDetailScreen> createState() => _TrasectionDetailScreenState();
}

class _TrasectionDetailScreenState extends State<TrasectionDetailScreen> {
  String currency = "";

  @override
  void initState() {
    currencyGet();
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
          child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textAndBack(context),
            space(15),
            buildRow(
                title: "Value Date",
                subtitle: widget.model.createdOnDate.toString()),
            buildRow(
              title: "Store Name".tr(),
              subtitle: widget.model.retailer!.isEmpty
                  ? "No Name"
                  : widget.model.retailer.toString(),
            ),
            buildRow(
                title: "Transaction Type",
                subtitle: widget.model.paymentType.toString()),
            buildRow(
              title: "Status",
              subtitle: widget.model.statuslabeled.toString(),
            ),
            buildRow(
                title: "Transaction Amount",
                subtitle:
                    "$currency${double.parse(widget.model.amount.toString()).toStringAsFixed(2)}"),
            buildRow(
                title: "Payment Details",
                subtitle: widget.model.paymentDetails.toString()),
            buildRow(
                title: "Reference ID",
                subtitle: widget.model.referenceID.toString()),

            // buildRow(
            //     title: "Transaction Commision",
            //     subtitle: model.transectionCommision.toString()),
          ],
        ),
      )),
    );
  }

  Widget buildRow({required String title, required String subtitle}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 15).r,
      margin: EdgeInsets.symmetric(vertical: 1).r,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomText(
                title.tr(),
                style: Styles.robotoStyle(
                  FontWeight.bold,
                  18,
                  AppColor.primaryColor,context
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
              AppColor.blackColor,context
            ),
          ),
        ],
      ),
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
            "Transection Details".tr(),
            style: Styles.robotoStyle(
              FontWeight.bold,
              25.sp,
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

  String date(dt) {
    DateTime dateTime = DateTime.parse(dt);
    return DateFormat('MMM dd, yyy').add_jm().format(dateTime);
  }
}
