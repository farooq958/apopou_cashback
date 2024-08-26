import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashback/view/custom_widgets/app_color.dart';
import 'package:cashback/view/custom_widgets/custom_text_widget.dart';
import 'package:cashback/view/custom_widgets/image_widgets.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CachedImage2 extends StatelessWidget {
  final String url;
  final double? scale;
  final double? radius;
  final bool? isCircle;
  final double? containerRadius;
  final double? bottomRadius;
  final double? topRadius;
  final BoxFit? fit;
  final double? width;
  final double? height;

  const CachedImage2({
    super.key,
    required this.url,
    this.scale = 1,
    this.radius = 50,
    this.isCircle = false,
    this.containerRadius = 0,
    this.topRadius,
    this.bottomRadius,
    this.fit = BoxFit.fill,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(

      imageUrl: url,

      placeholder: (context, url) => isCircle!
          ? Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColor.primaryColor,
          ),
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: CircularProgressIndicator(
            color: AppColor.primaryColor,
          ),
        ),
      )
          : Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(containerRadius!),
        ),
        child: const Center(
          child: CircularProgressIndicator(
            color: AppColor.primaryColor,
          ),
        ),
      ),
      errorWidget: (context, url, error) {

        return
          isCircle!
              ?
          CircleAvatar(
              radius: radius,backgroundColor: Colors.transparent,
              backgroundImage: const NetworkImage("https://firebasestorage.googleapis.com/v0/b/hbk-blankets.appspot.com/o/logo.png?alt=media&token=409f2508-9b66-44ac-9c82-ec19a1046cd6")


          ):
             Center(child: CustomText("No Bar Image Available ", textScaleFactor: 1.0,
               style: Styles.robotoStyle2(
                 fontSize: 20.0.sp,
                 color: Colors.black,
                 fontWeight: FontWeight.w700, context: context,
               ),));
  //AssetImageWidget(url: 'images/dummy_bar.png',scale: 5,width: 120,);

      },

      imageBuilder: (context, imageProvider) => isCircle!
          ? CircleAvatar(
        radius: radius,
        backgroundImage: imageProvider,
      )
          : ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(topRadius ?? containerRadius!),
          topLeft: Radius.circular(topRadius ?? containerRadius!),
          bottomLeft: Radius.circular(bottomRadius ?? containerRadius!),
          bottomRight: Radius.circular(bottomRadius ?? containerRadius!),
        ),
        child: Image(

          image: imageProvider,
          width: width,
          height: height,
          fit: fit,
        ),
      ),
    );
  }
}