import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_color.dart';
import 'package:cashback/view/imports.dart';
Future<dynamic> bottomSheet({
  required BuildContext context,
  required VoidCallback onGalleryTap,
  required VoidCallback onCameraTap,
}) {
  return showModalBottomSheet(
      backgroundColor: AppColor.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25).r,
          topRight: Radius.circular(25).r,
        ),
      ),
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25).r,
                  topRight: Radius.circular(25).r,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  bottomSheetListTile(
                    context,
                    Icons.image,
                    "From Gallery",
                    onGalleryTap,
                  ),
                  SizedBox(height: 10),
                  bottomSheetListTile(
                    context,
                    Icons.camera,
                    "From Camera",
                    onCameraTap,
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        );
      });
}

ListTile bottomSheetListTile(
  BuildContext context,
  IconData iconData,
  String text,
  VoidCallback onTap,
) {
  return ListTile(
    leading: CircleAvatar(
      radius: 24.r,
      backgroundColor: AppColor.primaryColor,
      child: Icon(iconData, color: AppColor.whiteColor, size: 24.r),
    ),
    title: CustomText(text,
        style: Styles.robotoStyle(FontWeight.bold, 15, AppColor.blackColor,context)),
    onTap: onTap,
  );
}
