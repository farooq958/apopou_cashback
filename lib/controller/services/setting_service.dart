import 'dart:developer';
import 'package:cashback/controller/testserver.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'apis.dart';

class SettingService {
  static Future<List<dynamic>> getReferAFriend() async {
    var dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await prefs.getString("country_id") ?? "";
    var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
    finalServer = checkServer;
    try {
      var res = await dio.get(
        "${finalServer}/api/settings/get-all?key=validate_refer_credit,refer_friend_terms_url",
      );
      if (res.statusCode == 200) {
        log("RESPONSE ${res.data['data']}");
        var list = res.data['data'] as List<dynamic>;
        return list;
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }
}
