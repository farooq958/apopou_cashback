import 'package:cashback/view/custom_widgets/app_color.dart';
import 'package:cashback/view/custom_widgets/dialogue.dart';
import 'package:cashback/view/subscribePremium/components/subscribe_unsubscribe.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class UnSubscribeScreen extends StatelessWidget {
  const UnSubscribeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: SubscribeAndUnsubscribe(
              image: 'images/unsubcribe_done.png',
              title: "Η απεγγραφή ολοκληρώθηκε",
              subTitle:
                  "Καταργήσατε με επιτυχία την εγγραφή σας από το πρόγραμμα premium .",
              onTap: () {

                Navigator.of(context).pop(true);
                AppDialog.dialog(context, UnSubscribeScreenNote());

              },
            ),
          ),
        ),
      ),
    );
  }
}


class UnSubscribeScreenNote extends StatelessWidget {
  const UnSubscribeScreenNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: SubscribeAndUnsubscribe(
              image: 'images/info_icon.png',
              title: "Σημείωση",
              subTitle:
              "your premium account is still active for 30 days since the date you paid".tr(),
              onTap: () {

                Navigator.of(context).pop(true);

              },
            ),
          ),
        ),
      ),
    );
  }
}
