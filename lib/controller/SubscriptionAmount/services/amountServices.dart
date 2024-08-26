import 'dart:io';

import 'package:cashback/controller/SubscriptionAmount/services/subscription_amount_controller.dart';
import 'package:cashback/controller/shared_preferences.dart';
import 'package:cashback/controller/testserver.dart';
import 'package:cashback/model/subscription_amount_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class SubscriptionAmountServices{

  loadSubscriptionAmount()
  async {
    try{
      String? token= SharePrefs.prefs?.getString('token');
      var headers = {
        'Authorization': 'Bearer $token'
      };
      var request = http.Request('GET', Uri.parse('$finalServer/api/get/subscription-amount'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
         subscriptionAmountController = subscriptionAmountFromJson(await response.stream.bytesToString());
      }
  else {
  print(response.reasonPhrase);
  }
    }on SocketException catch (e) {
      debugPrint(e.toString());
      debugPrint('Internet connection is down.');
      return 10;
    } on Exception catch (e) {
      debugPrint('sent data api exception: $e');
      return 0;
    }


  }


}