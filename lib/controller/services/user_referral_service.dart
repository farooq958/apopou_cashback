import 'dart:convert';
import 'dart:developer';
import 'package:cashback/controller/testserver.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/user_referral_model.dart';
import 'apis.dart';

class UserReferralService {
  Future<UserReferralModel> getUserReferral(String pageNumber) async {
    var dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await prefs.getString("country_id") ?? "";
    var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
    finalServer=checkServer;
    var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};
    try {
      var res = await dio.get(
          "${finalServer}/api/user/referal/all?sort_by=status&page=$pageNumber",
          options: Options(headers: headers));
      log("Referral Response ${res.data}");
      if (res.statusCode != 200) {
        throw ("No Data");
      }
      var data = res.data["data"] as List<dynamic>;
      log("Data2 ${UserReferralModel.fromJson(res.data)}");
      return UserReferralModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getInviteReferralCode() async {
    var dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await prefs.getString("country_id") ?? "";
    var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
    var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};

    var res = await dio.get(
      "${checkServer}/api/settings/get-all?key=ref_url",
      // options: Options(headers: headers)
    );
    // log("RRR ${res.data}");

    if (res.statusCode != 200) {
      return null;
    } else {
      return res.data;
    }
    // var data = res.data["data"] as List<dynamic>;
    // log("Data2 ${UserReferralModel.fromJson(res.data)}");
  }
}
