import 'dart:developer';

import 'package:cashback/controller/testserver.dart';
import 'package:cashback/model/balance/click_history_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import '../apis.dart';

class ClickHistoryService {
  Future<ClickHistoryModel> getClickHistory(id, String pageNumber) async {
    var dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await prefs.getString("country_id") ?? "";
    var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
    finalServer=checkServer;
    var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};
    try {
      var res = await dio.get(
        "${finalServer}/api/user/$id/clicks?sort_by=dateAdded&page=$pageNumber",
        options: Options(headers: headers),
      );
      if (res.statusCode == 200) {
        // var data = res.data['data'] as List<dynamic>;
        // List<ClickHistoryModel> list = [];
        // data.forEach((e) {
        //   list.add(ClickHistoryModel.fromMap(e));
        // });
        // log("List $list");
        // return list;
        log("Data Res ${res.data}");
        var data = ClickHistoryModel.fromJson(res.data);
        // log("Click History Model $data");
        // log("Click History Res ${res.data}");

        return data;
      }
      return ClickHistoryModel();
    } catch (e) {
      log("service error $e");
      rethrow;
    }
  }
}
