import 'dart:developer';
import 'package:cashback/controller/services/PushNotification/payload_stream.dart';
import 'package:cashback/controller/services/PushNotification/push_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../../../view/notification/notification_screen.dart';

class NotificationConfig {
  void messagingInitiation() async {
    // String? fcmToken = await FirebaseMessaging.instance.getToken();
    await FirebaseMessaging.instance.getNotificationSettings();

    // log('FCM Token:$fcmToken');
    FirebaseMessaging.onMessage.listen((e) async {
      print("OnMessage $e");
      // log("checking logs for messages on message ${e.messageId}  ${e.category}  ${e.from}  ${e.messageType}   ${e.contentAvailable}  data  ${e.data.entries}  title: ${e.ttl}");
      log(e.toMap().toString());
      PushNotificationServices()
          .showNotification(1, e.notification!.title!, e.notification!.body!);
    }).onError((error) {
      print("checking logs $error");
    });

    // FirebaseMessaging.onMessageOpenedApp.listen((e) async {
    //   var data = await e.notification!.body;
    //   print("On Message Opened App $data");
    //   log("checking logs for messages onMessageOpened ");
    //   // PushNotificationServices()
    //   //     .showNotification(1, e.notification!.title!, e.notification!.body!);
    // });

    FirebaseMessaging.onBackgroundMessage((e) async {
      // var data = await e.notification!.body;
      print("Running Background notification $e");
      PushNotificationServices()
          .showNotification(1, e.notification!.title!, e.notification!.body!);
      return;
    });
  }

  notificationPayload(BuildContext context) async {
    await PayloadStream.instance.getPayload.listen((event) {
      print("PAYLOAD CALLED $event");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NotificationScreen(guest: false),
        ),
      );
    });
  }
}
