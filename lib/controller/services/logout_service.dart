import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '../shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'apis.dart';

class LogoutService {
  static Future<bool> logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await prefs.getString("country_id") ?? "";
    var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
    var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};
    var request = http.Request('POST', Uri.parse('${checkServer}/api/logout'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      log("api getting successfully");
      log(await response.stream.bytesToString());
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }
}
