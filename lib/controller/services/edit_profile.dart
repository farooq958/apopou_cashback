import 'dart:developer';
import 'package:cashback/controller/testserver.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'apis.dart';

class EditProfileService {
  Future<bool> updateProfile(
    int id,
    String email,
    String fname,
    // String lname,
    // var country,
  ) async {
    var dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await prefs.getString("country_id") ?? "";
    var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
    finalServer=checkServer;
    var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};
    try {
      var res = await dio.put(
        "${finalServer}/api/user/$id",
        queryParameters: {
          'email': email,
          "fname": fname,
          // "lname": " ",
          // "country": country
        },
        options: Options(
          headers: headers,
        ),
      );

      log("Data  ${res.statusCode} ${res.data} ");
      if (res.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      rethrow;
    }
  }
}
