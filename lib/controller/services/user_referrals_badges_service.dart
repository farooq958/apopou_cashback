import 'dart:developer';
import 'package:cashback/controller/testserver.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/user_referral_badges_model.dart';
import 'apis.dart';

class UserReferralBadgesService {
  Future<UserReferralBadgesModel> getBadges() async {
    var dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await prefs.getString("country_id") ?? "";
    var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
    finalServer=checkServer;
    var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};
    try {
      var res = await dio.get("${finalServer}/api/user/referal/get-all",
          options: Options(headers: headers));
      // log("RRRESPONSE 1 ${res.data}");
      if (res.statusCode != 200) {
        throw ("No Data");
      }
      log("RRRESPONSE 2 ${UserReferralBadgesModel.fromJson(res.data)}");
      return UserReferralBadgesModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }
}
