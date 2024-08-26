import 'dart:developer';
import 'package:cashback/controller/testserver.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'apis.dart';

class CurrencyService {
  // static Future<String> getCurrency() async {
  //   var dio = Dio();
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var server = await prefs.getString("country_id") ?? "";
  //   var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
  //   // var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};
  //   try {
  //     var res = await dio.get(
  //       "${checkServer}/api/settings/get-all?key=currency",
  //       // options: Options(
  //       //   headers: headers,
  //       // ),
  //     );

  //     if (res.statusCode == 200) {
  //       log("Currency Response ${res.data['data'][0]['setting_value']}");
  //       return res.data['data'][0]['setting_value'];
  //     }
  //     return "";
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  static Future<Map<String, dynamic>> getCurrency() async {
    var dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await prefs.getString("country_id") ?? "";
    var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
    finalServer=checkServer;
    try {
      var res = await dio.get(
        "${finalServer}/api/settings/get-all?key=currency,yearly_maintenance_fee",
      );

      if (res.statusCode == 200) {
        log("Currency Response ${res.data['data']}");
        return res.data;
      }
      return {};
    } catch (e) {
      rethrow;
    }
  }
}
