// http://localhost:8000/

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../shared_preferences.dart';
import 'apis.dart';

class HistoryService {
  static Future<bool> callHistoryApi({int? id}) async {
    var dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await prefs.getString("country_id") ?? "";
    var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
    try {
      var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};
      var res = await dio.post("${checkServer}/api/retailer/clickhistory",
          data: {"retailer_id": id}, options: Options(headers: headers));

      log("testing logs ${res.data}");
      if (res.statusCode == 200) {
        log("api is working .... ");

        return true;
      }

      throw "Error";
    } catch (e) {
      rethrow;
    }
  }
}
