import 'package:cashback/view/custom_widgets/app_color.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentMethodButtonWidget extends StatelessWidget {
  final String imageUrl;
  final bool isActive;
  final VoidCallback onTap;
  const PaymentMethodButtonWidget({
    super.key,
    required this.imageUrl,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        child: Container(
          color: AppColor.whiteColor,
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: Radius.circular(12),
            padding: EdgeInsets.all(6),
            color:
                isActive == true ? AppColor.primaryColor : AppColor.greyColor,
            strokeWidth: 1,
            dashPattern: [10, 6],
            child: Container(
              height: 95.h,
              width: 140.w,
              child: Center(
                  child: Image.asset(
                imageUrl,
                width: 50.w,
                height: 50.h,
              )),
            ),
          ),
        ),
      ),
    );
  }
}
