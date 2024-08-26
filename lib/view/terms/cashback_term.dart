import 'package:cashback/controller/AppConstants.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cashback/view/imports.dart';
class CashBackTerms extends StatelessWidget {
  final String desc;
  const CashBackTerms({super.key, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEFEEEE),
      body: SafeArea(
        child: Container(
          margin: AppConstants.screenPadding,
          width: 1.sw,
          height: 1.sh,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                space(),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: 30.sp,
                    color: Colors.black,
                  ),
                ),
                space(),
                CustomText(
                  "ΟΡΟΙ ΚΑΤΑΣΤΗΜΑΤΟΣ",
                  style: Styles.robotoStyle2(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w900, context: context,
                  ),
                ),
                space(),
                Container(child: Image.asset("images/marketplace.png")),
                space(),
                Container(
                  child: SingleChildScrollView(
                    child: Text.rich(
                      // textAlign: TextAlign.justify,
                      TextSpan(
                          style: Styles.robotoStyle2(
                            fontSize: 16.0.sp,
                            color: const Color(0xFF363636), context: context,
                          ),
                          children: [
                            TextSpan(
                              text: '${desc}',
                              style: Styles.robotoStyle2(context: context),
                            ),
                          ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget space() {
    return SizedBox(
      height: 20.sp,
    );
  }
}
