import 'package:cashback/view/custom_widgets/app_color.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cashback/view/imports.dart';
class PaymentMethodUpperTile extends StatelessWidget {
  const PaymentMethodUpperTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.11,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 25).r,
      decoration: BoxDecoration(
        color: AppColor.primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30).r,
          topRight: Radius.circular(30).r,
        ),
      ),
      child: Center(
        child: CustomText(
          "Select Payment Method".tr(),
          style: Styles.robotoStyle(
            FontWeight.w600,
            24,
            AppColor.whiteColor,context
          ),
        ),
      ),
    );
  }
}
