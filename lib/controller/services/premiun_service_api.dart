import 'dart:developer';

import 'package:cashback/controller/testserver.dart';
import 'package:cashback/model/premium/premium_user_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'apis.dart';

class PremiumCheck{



  static Future<String> getPremiumCheck() async {
    var dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await prefs.getString("country_id") ?? "";
    var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
    finalServer=checkServer;
    try {
      var res = await dio.get(
        "${finalServer}/api/settings/get-all?key=premium_coupons",
      );

      if (res.statusCode == 200) {
        log("premium check Response ${res.data['data']}");


        return res.data['data'][0]['setting_value'];
      }
      return '';
    } catch (e) {
      rethrow;
    }
  }
  static Future<PremiumUserModel?> getPremiumUserData() async {
    var dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await prefs.getString("country_id") ?? "";
    var headers = {'Authorization': 'Bearer ${await prefs.getString("token")}'};
    var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
    finalServer=checkServer;
    print("the server");
    print( "${finalServer}/api/premium/user");
    try {
      var res = await dio.get(
        "${finalServer}/api/premium/user",
        options: Options(headers: headers)
      );

      if (res.statusCode == 200) {
        log("premium user Data ${res.data['data']}");

        PremiumUserModel pd = PremiumUserModel.fromMap(res.data['data']);



        return pd;
      }
      return null;
    } catch (e) {
      return null;
      rethrow;
    }
  }

}