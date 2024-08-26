import 'package:cashback/controller/premiumControllers/hiddenattribute/hidden_attribute_cubit.dart';
import 'package:cashback/model/premium/all_coupon_model.dart';
import 'package:cashback/view/custom_widgets/app_color.dart';
import 'package:cashback/view/custom_widgets/image_widgets.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:cashback/view/subscribePremium/components/image_widget.dart';
import 'package:clipboard/clipboard.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cashback/view/imports.dart';
class PremiumCouponDetail extends StatefulWidget {
  var data;
   PremiumCouponDetail({Key? key, required this.data}) : super(key: key);

  @override
  State<PremiumCouponDetail> createState() => _PremiumCouponDetailState();
}

class _PremiumCouponDetailState extends State<PremiumCouponDetail> {
  
  @override
  void initState() {
    // TODO: implement initState
    
  context.read<HiddenAttributeCubit>().getHiddenAttributes(widget.data.identifier);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 12).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20).r,
                    child: Icon(
                      Icons.arrow_back,
                      size: 32.r,
                      color: Colors.black,
                    ),
                  ),
                ),
                Stack(
                  children: [
                    CustomPaint(
                      size: Size(1.sw, (1.sw * 0.5).toDouble()),
                      painter: PremiumFillPainter(),
                      child: Container(height: 650.h),
                    ),
                    CustomPaint(
                      size: Size(1.sw, (1.sw * 0.5).toDouble()),
                      painter: PremiumFillWithDot(),
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 20.sp,
                            right: 20.sp,
                            top: 20.sp,
                            bottom: 10.sp),
                        height: 650.h,
                        width: double.infinity,
                        child: BlocConsumer<HiddenAttributeCubit, HiddenAttributeState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    HiddenAttrModel hm=HiddenAttrModel(identifier: 0, autoLinkId: '', offerType: '', title: '', couponCode: '', redirectUrl: '', description: '', exclusive:0, noOfLikes: 0, noOfTodayVisits: 0, noOfVisits: 0, sortOrder: 0, viewed: 0, status: Status.ACTIVE, retailerName: '', retailerImg: '', validFrom: DateTime.now(), validTo: DateTime.now(), addedOnDate: DateTime.now(), lastVisitedOnDate:'', offerTypeText: '', barcodeQrUrl: '');
    if(state is HiddenAttributeLoaded)
      {
        hm = state.data;

        print("bar data "+hm.barcodeQrUrl);
      }

    return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                      horizontal: 33, vertical: 18)
                                  .r,
                              child: CachedImage2(url:hm.barcodeQrUrl,
                              fit: BoxFit.fill,
                                width: 1.sw,
                               // height: ,
                                scale: 5,
                              )
                                ,

                             // child:  QrImage(
                             //
                             //      data: hm.barcodeQrUrl,
                             //      version: QrVersions.auto,
                             //      size: 1.sh/3.5.sp,
                             //      gapless: true,
                             //      embeddedImage: NetworkImage(hm.barcodeQrUrl),
                             //      // embeddedImageStyle: QrEmbeddedImageStyle(
                             //      //   size: Size(80, 80),
                             //      // ),
                             //    )

                            ),
                            SizedBox(height: 2.h),
                            DottedBorder(
                              borderType: BorderType.RRect,
                              radius: Radius.circular(4).r,
                              padding: EdgeInsets.zero,
                              color: Color(0xff07c4bc),
                              strokeWidth: 1,
                              dashPattern: [6, 3],
                              child: Container(
                                width: 200.w,
                                padding: EdgeInsets.symmetric(vertical: 8).r,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4).r,
                                  color: Color(0xff07c4bc).withOpacity(0.1),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      flex:2,
                                      child: Center(
                                        child: CustomText(
                                          hm.couponCode==""?"NO COUPON CODE": hm.couponCode,
                                          style: TextStyle(
                                            color: Color(0xff07c4bc),
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap:()
                                      {
                                      FlutterClipboard.copy(hm.couponCode).then(( value ) =>
                                      print('copied'));

                                      },
                                      child: Icon(
                                        Icons.copy_outlined,
                                        color: Color(0xff07c4bc),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 40.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  widget.data.retailerImg,
                                  width: 55.w,
                                  height: 50.h,
                                  fit: BoxFit.fill,
                                ),
                                SizedBox(width: 8.h),
                                CustomText(
                                  widget.data.retailerName,
                                  style: Styles.robotoStyle2(
                                    fontSize: 30.0.sp,
                                    color: const Color(0xFF363636),
                                    fontWeight: FontWeight.w700, context: context,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15.h),
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: CustomText(
                                hm.title,
                                style: Styles.robotoStyle2(
                                  fontSize: 22.0.sp,
                                  color: const Color(0xFF363636),
                                  fontWeight: FontWeight.w900, context: context,
                                ),
                              ),
                            ),
                            SizedBox(height: 30.h),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 18.0),
                                child: CustomText(
                                  "Terms & Conditions",
                                  style: Styles.robotoStyle2(
                                    fontSize: 16.0.sp,
                                    color: const Color(0xFF363636),
                                    fontWeight: FontWeight.w700, context: context,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Expanded(

                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 18.0),
                                  child: CustomText(
                                    hm.description,

                                    style: Styles.robotoStyle2(
                                      fontSize: 16.0.sp,
                                      color: Colors.grey.shade400,
                                      fontWeight: FontWeight.w500, context: context,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 5,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 25.h),
                            CustomText(
                              "${ hm.lastVisitedOnDate.toString()!=""?"Expires ${hm.lastVisitedOnDate.toString().substring(0,11)}":""}",
                              style: Styles.robotoStyle2(
                                fontSize: 16.0.sp,
                                color: AppColor.primaryColor,
                                fontWeight: FontWeight.w900, context: context,
                              ),
                            ),
                          ],
                        );
  },
),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PremiumFillPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path0 = Path();
    path0.moveTo(size.width, 0);
    path0.lineTo(size.width, size.height * 0.4042667);
    path0.quadraticBezierTo(size.width * 0.9340000, size.height * 0.3966667,
        size.width * 0.9317333, size.height * 0.5008000);
    path0.quadraticBezierTo(size.width * 0.9331667, size.height * 0.6042000,
        size.width, size.height * 0.5994667);
    path0.lineTo(size.width, size.height);
    path0.lineTo(0, size.height);
    path0.lineTo(0, size.height * 0.6000000);
    path0.quadraticBezierTo(size.width * 0.0695000, size.height * 0.5954667,
        size.width * 0.0696667, size.height * 0.4930667);
    path0.quadraticBezierTo(size.width * 0.0693333, size.height * 0.4000667, 0,
        size.height * 0.3923333);
    path0.lineTo(0, 0);
    path0.lineTo(size.width, 0);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PremiumFillWithDot extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = Color(0xffCCCCCC)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.sp;

    Path path0 = Path();
    path0.moveTo(size.width, 0);
    path0.lineTo(size.width, size.height * 0.4042667);
    path0.quadraticBezierTo(size.width * 0.9340000, size.height * 0.3966667,
        size.width * 0.9317333, size.height * 0.5008000);
    path0.quadraticBezierTo(size.width * 0.9331667, size.height * 0.6042000,
        size.width, size.height * 0.5994667);
    path0.lineTo(size.width, size.height);
    path0.lineTo(0, size.height);
    path0.lineTo(0, size.height * 0.6000000);
    path0.quadraticBezierTo(size.width * 0.0695000, size.height * 0.5954667,
        size.width * 0.0696667, size.height * 0.4930667);
    path0.quadraticBezierTo(size.width * 0.0693333, size.height * 0.4000667, 0,
        size.height * 0.3923333);
    path0.lineTo(0, 0);
    path0.lineTo(size.width, 0);
    path0.close();

    canvas.drawPath(
        dashPath(
          path0,
          dashArray: CircularIntervalList<double>(<double>[15.0, 6]),
        ),
        paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
