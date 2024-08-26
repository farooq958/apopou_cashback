import 'package:cashback/view/custom_widgets/app_color.dart';
import 'package:cashback/view/subscribePremium/components/subscribe_unsubscribe.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SubscribeSuccessfulScreen extends StatelessWidget {
  const SubscribeSuccessfulScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: SubscribeAndUnsubscribe(
              image: 'images/payment_done.png',
              title: "Payment Successfully Done".tr(),
              subTitle:
                  "Payment done now you become a premium member of app".tr(),
              onTap: () {


                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
    );
  }
}
