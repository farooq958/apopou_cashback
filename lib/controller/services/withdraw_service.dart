import 'dart:convert';
import 'dart:developer';
import 'package:cashback/controller/testserver.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'apis.dart';

class WithDrawService {
  // Future<bool> WithDrawPayment(Map<String, dynamic> map) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var server = await prefs.getString("country_id") ?? "";
  //   var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
  //   var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};
  //   try {
  //     var res = await http.post(
  //       Uri.parse("${checkServer}/api/user/withdraw/request"),
  //       body: map,
  //       headers: headers,
  //     );
  //     log("Status Code ${res.statusCode}");
  //     log("Res Body ${res.body}");
  //     if (res.statusCode != 200) {
  //       throw ("Error");
  //     }
  //     return true;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<Map<String, dynamic>> WithDrawPayment(Map<String, dynamic> map) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await prefs.getString("country_id") ?? "";
    var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
    finalServer=checkServer;
    var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};
    try {
      var res = await http.post(
        Uri.parse("${finalServer}/api/user/withdraw/request"),
        body: map,
        headers: headers,
      );
      log("Status Code ${res.statusCode}");
      log("Res Body ${res.body}");
      var data = json.decode(res.body);

      if (res.statusCode == 200) {
        return data;
        // if (data["min_payout"] is List || data["low_balance"] is List) {
        //   log("${data['min_payout'][0]} ${data['low_balance'][0]}");
        // }

      }
      return {};
    } catch (e) {
      rethrow;
    }
  }
}
