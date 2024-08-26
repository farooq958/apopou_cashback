import 'dart:developer';
import 'package:cashback/controller/testserver.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'apis.dart';

class HelpService {
  static Future<String> getHelpUrl() async {
    var dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await prefs.getString("country_id") ?? "";
    var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
    finalServer=checkServer;
    var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};
    try {
      var res = await dio.get(
        "${finalServer}/api/settings/help-url",
        options: Options(
          headers: headers,
        ),
      );
      log("RESPONSE HELP ${res.data}");
      if (res.statusCode == 200) {
        log("200 CODE ${res.data['data']['setting_value']}");
        return res.data['data']['setting_value'];
      }
      return "";
    } catch (e) {
      rethrow;
    }
  }
}
