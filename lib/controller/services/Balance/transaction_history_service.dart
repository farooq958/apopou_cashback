import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../model/balance/transaction_history_model.dart';
import 'package:dio/dio.dart';

import '../apis.dart';

class TransactionHistoryService {
  // Future<List<TransectionHistoryModel>> getTransactionHistory() async {
  //   var dio = Dio();
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var server = await prefs.getString("country_id") ?? "";
  //   var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
  //   var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};
  //   try {
  //     var res = await dio.get(
  //       "${checkServer}/api/transaction/history/all?sort_by=status&page=10",
  //       options: Options(headers: headers),
  //     );
  //     // log("HISTORY RES ${res.data}");
  //     if (res.statusCode == 200) {
  //       var data = res.data['data'] as List<dynamic>;
  //       List<TransectionHistoryModel> list = [];
  //       data.forEach((e) {
  //         list.add(TransectionHistoryModel.fromMap(e));
  //       });
  //       // log("List $list");
  //       return list;
  //     }

  //     return [];
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<TransectionHistoryModel> getTrans(
      {String? pageNumber, String? status}) async {
    var dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await prefs.getString("country_id") ?? "";
    var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
    var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};
    try {
      var res = await dio.get(
        "${checkServer}/api/transaction/history/all?sort_by=createdOnDate&page=$pageNumber&status=$status",
        options: Options(headers: headers),
      );
      if (res.statusCode == 200) {
        // log("HISTORY RES ${res.data}");
        var data = TransectionHistoryModel.fromJson(res.data);
        log("Model1 $data");
        return data;
      }
      return TransectionHistoryModel();
    } catch (e) {
      rethrow;
    }
  }
}
