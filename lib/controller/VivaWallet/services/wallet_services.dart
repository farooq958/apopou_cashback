import 'dart:developer';
import 'dart:io';

import 'package:cashback/controller/VivaWallet/services/walletControllers.dart';
import 'package:cashback/controller/services/apis.dart';
import 'package:cashback/controller/shared_preferences.dart';
import 'package:cashback/controller/testserver.dart';
import 'package:cashback/model/WalletModel/unsubsribe_premium_model.dart';
import 'package:cashback/model/WalletModel/wallet_url_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class WalletServices{

  loadUrlForWeb()
  async {
    try{
      String? token= SharePrefs.prefs?.getString('token');
      print("tokennnnnnnnn");
      print(token);

      var headers = {
        'Authorization': 'Bearer $token'
      };
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var server = await prefs.getString("country_id") ?? "";
      var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
      finalServer=checkServer;
      print("servername"+'$finalServer/api/user/recurring-payments/get-token' );
      var request = http.Request('GET', Uri.parse('$finalServer/api/user/recurring-payments/get-token'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
//print(await response.stream.bytesToString());
      if (response.statusCode == 200) {
       walletUrlController = walletUrlFromJson(await response.stream.bytesToString());
      }
      else {
        print("test"+response.reasonPhrase.toString());
      }
      print("test"+response.reasonPhrase.toString());
return  response.statusCode;
    }on SocketException catch (e) {
      debugPrint(e.toString());
      debugPrint('Internet connection is down.');
      return 10;
    } on Exception catch (e) {
      debugPrint('sent data api exception: $e');
      return 0;
    }


  }
sendTransactionId(String transactionId)
async {
  try{
    String? token= SharePrefs.prefs?.getString('token');

    var headers = {
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest('GET', Uri.parse('https://api-test.apopou.gr/api/get/transaction-id'));
    request.fields.addAll({
      'transactionId': transactionId
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
//print(await response.stream.bytesToString());
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
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

unSubscribePremium()
async {
  String? token= SharePrefs.prefs?.getString('token');

  var headers = {
    'Authorization': 'Bearer $token'
  };
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var server = await prefs.getString("country_id") ?? "";
  var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
  finalServer=checkServer;
  var request = http.Request('POST', Uri.parse('${finalServer}/api/user/unsubscribe-subscription'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  var res=await response.stream.bytesToString();
  log('response delete  ${res}');
print(res);
  if (response.statusCode == 200) {
  return unsubscribeModelFromMap(res);
}
else {
  return 0;

}

}

}