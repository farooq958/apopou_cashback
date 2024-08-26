import 'dart:developer';

import 'package:cashback/controller/testserver.dart';
import 'package:cashback/model/servicesModel/parentCategory.dart';
import 'package:cashback/model/servicesModel/subCategoryModel.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'apis.dart';

class CategoryServices {
  Future<List<ParentCategory>> getParentCategory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await prefs.getString("country_id") ?? "";
    var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
    finalServer=checkServer;
    var dio = Dio();
    try {
      var res =
          await dio.get("${finalServer}/api/categories/parent?subcategories");
      log("Parent Category ${res.data}");
      if (res.statusCode == 200) {
        if (res.data['data'] is List) {
          List<ParentCategory> list = [];
          res.data['data'].forEach((e) {
            list.add(ParentCategory.fromMap(e));
          });
          return list;
        }
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<SubCategoryModel> getSubCategory({int? id}) async {
    var dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await prefs.getString("country_id") ?? "";
    var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
    try {
      var res = await dio.get("${checkServer}/api/store/subcategories/$id/all");

      if (res.statusCode == 200) {
        log("api is working ....");
        if (res.data['data'] is List) {
          SubCategoryModel? list;
          res.data['data'].forEach((e) {
            list = SubCategoryModel.fromMap(e);
          });

          return list!;
        }
      }
      throw "Error";
    } catch (e) {
      rethrow;
    }
  }
}
