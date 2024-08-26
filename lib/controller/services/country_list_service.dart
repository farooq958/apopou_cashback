import 'dart:convert';
import 'dart:developer';
import 'package:cashback/controller/services/apis.dart';
import 'package:cashback/model/countries_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../shared_preferences.dart';

class CountryListService {
  Future<List<CountryListModel>> getCountryList() async {
    var dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};
    try {
      var res = await dio.get(ApiUrls.getCountryList,
          options: Options(headers: headers));
      if (res.statusCode == 200) {
        log("1");
        var data = res.data['data'] as List<dynamic>;
        log("2");
        List<CountryListModel> list = [];
        data.forEach((e) {
          log("EE $e");
          list.add(CountryListModel.fromJson(e));
        });
        log("List $list");
        return list;
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }
}
