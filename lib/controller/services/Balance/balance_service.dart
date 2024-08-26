import 'dart:developer';
import 'package:cashback/controller/testserver.dart';
import 'package:cashback/model/balance/balance_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../apis.dart';

class BalanceService {
  Future<BalanceModel> getBalance() async {
    var dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await prefs.getString("country_id") ?? "";
    var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
    finalServer=checkServer;
    var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};
    try {
      var res = await dio.get("${finalServer}/api/get/user/balance?status=all",
          options: Options(headers: headers));
      log("Data ${res.data}");

      if (res.statusCode == 200) {
        BalanceModel balanceModel = BalanceModel.fromMap(res.data);
        log("Model $balanceModel");
        return balanceModel;
      }
      return BalanceModel();
    } catch (e) {
      rethrow;
    }
  }
}
