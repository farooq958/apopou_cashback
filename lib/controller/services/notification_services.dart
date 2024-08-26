import 'dart:developer';

import 'package:cashback/controller/shared_preferences.dart';
import 'package:cashback/model/notifications/notification.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'apis.dart';

class NotificationServices {
  Future<NotificationModel> getNotifications(String pageNumber) async {
    // List<NotificationModel> list = [];
    var dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await prefs.getString("country_id") ?? "";
    var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
    try {
      var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};
      var res = await dio.get(
          "${checkServer}/api/user/get/notifications?sort_by=created_at&page=$pageNumber",
          options: Options(headers: headers));

      // if (res.statusCode == 200) {
      //   if (res.data['data'] is List) {
      //     res.data['data'].forEach((e) {
      //       list.add(NotificationModel.fromMap(e));
      //     });
      //
      //     return list;
      //   }
      // }
      if (res.statusCode == 200) {
        var data = NotificationModel.fromJson(res.data);
        log("Model1 $data");
        return data;
      }

      throw "API Error";
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteOneNotification({int? id}) async {
    var dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await prefs.getString("country_id") ?? "";
    var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
    log("testing res status: ${id}");
    try {
      var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};
      var res = await dio.post(
          "${checkServer}/api/user/delete-single/notifications/$id",
          options: Options(headers: headers));
      log("testing res status: ${res.statusCode}");
      if (res.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteAllNotification() async {
    var dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await prefs.getString("country_id") ?? "";
    var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
    try {
      var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};
      var res = await dio.post(
          "${checkServer}/api/user/delete-all/notifications",
          options: Options(headers: headers));
      log("testing res status: ${res.statusCode}");
      if (res.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }
}
