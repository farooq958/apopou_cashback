import 'package:cashback/controller/VivaWallet/loadingweb_cubit.dart';
import 'package:cashback/controller/VivaWallet/services/walletControllers.dart';
import 'package:cashback/view/custom_widgets/app_color.dart';
import 'package:cashback/view/custom_widgets/dialogue.dart';
import 'package:cashback/view/custom_widgets/text_style.dart';
import 'package:cashback/view/subscribePremium/components/payment_method_upper_tile.dart';
import 'package:cashback/view/subscribePremium/components/unsubcribe_dialogue.dart';
import 'package:cashback/view/subscribePremium/subscribe_successful_screen.dart';
import 'package:cashback/view/subscribePremium/un_subscribe_screen.dart';
import 'package:cashback/view/web_view/web_view.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cashback/view/imports.dart';
class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
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
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor.lightWhiteColor.withOpacity(0.1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30).r,
                      topRight: Radius.circular(30).r,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PaymentMethodUpperTile(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12).r,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 22,
                                top: 24,
                              ).r,
                              child: CustomText(
                                "Payment Method".tr(),
                                style: Styles.robotoStyle(
                                  FontWeight.w700,
                                  20.sp,
                                  AppColor.blackColor,context
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                               // context.read<LoadingWebCubit>().loadingWeb(true);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return InAppWebView(url: walletUrlController.data,fromPayment: true,);
                                      // SubscribeSuccessfulScreen(),
                                    },
                                  ),
                                );
                                // await AppDialog.dialog(
                                //     context, UnSubscribeDialogue());
                              },
                              behavior: HitTestBehavior.opaque,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: Radius.circular(16).r,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 17,
                                    horizontal: 15,
                                  ).r,
                                  color: AppColor.primaryColor,
                                  strokeWidth: 1,
                                  dashPattern: [6, 3],
                                  child: Image.asset(
                                    "images/viva_wallet.png",
                                    width: 140.w,
                                    height: 32.h,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
