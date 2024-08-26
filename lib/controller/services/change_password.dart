import 'dart:developer';
import 'package:cashback/controller/testserver.dart';
import 'package:cashback/view/editProfile/change_password.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../shared_preferences.dart';
import 'apis.dart';

class ChangePasswordService {
  Future<bool> ChangePassword(
    String currentPassword,
    String newPassword,
  ) async {
    var dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await prefs.getString("country_id") ?? "";
    var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
    finalServer=checkServer;
    var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};
    try {
      var res = await dio.post(
        "${finalServer}/api/changePassword",
        queryParameters: {
          "newPassword": newPassword,
          "currentPassword": currentPassword,
        },
        options: Options(
          headers: headers,
        ),
      );
      log("Data ${res.data['message']}");

      Map<String, dynamic> map = res.data;
      var isContain = map.values.contains("Password Changed!");
      if (isContain) {
        log("IS Contain $isContain");
        return true;
      }

      return false;
    } catch (e) {
      rethrow;
    }
  }
}
