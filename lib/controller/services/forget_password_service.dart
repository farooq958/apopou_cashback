import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'apis.dart';

class ForgotPassService {
  static Future<String> forgotPassUrl() async {
    var dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await prefs.getString("country_id") ?? "";
    var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
    var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};
    try {
      var res = await dio.get(
        "${checkServer}/api/settings/forgot-url",
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
