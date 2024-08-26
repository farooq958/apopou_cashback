import 'dart:developer';
import 'package:cashback/controller/testserver.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../shared_preferences.dart';
import 'apis.dart';

class DeActivateService {
  Future<bool> deActivateUser(String email) async {
    var dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await prefs.getString("country_id") ?? "";
    var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
    finalServer=checkServer;
    var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};
    try {
      var res = await dio.post(
        "${finalServer}/api/deactivateAccount",
        queryParameters: {"username": email},
        options: Options(
          headers: headers,
        ),
      );
      log("Data ${res.data}");
      if (res.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      rethrow;
    }
  }
}
