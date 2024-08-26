import 'dart:developer';
import 'package:cashback/controller/services/apis.dart';
import 'package:cashback/controller/testserver.dart';
import 'package:cashback/model/premium/parent_category_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PremiumParentCategoryService {
  Future<PremiumParentCategoryModel> getCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await prefs.getString("country_id") ?? "";
    var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
    finalServer=checkServer;
    var dio = Dio();
    try {
      print("servereee"+finalServer);
      var res = await dio.get("${finalServer}/api/premium-coupons/categories");
      if (res.statusCode == 200) {
        log("Response ${res.data}");


        // var dto = res.data['data'] as List<dynamic>;
        // dto.forEach((element) {
        //   print("mystery images");
        //   print(element['img_path']);
        //
        //
        // });
       // print(dto[0]['img_path']);

        log("Model Response ${PremiumParentCategoryModel.fromJson(res.data)}");
        // print("mystery response");
        // print(res.data);
        //print(PremiumParentCategoryModel.);
      //  print(PremiumParentCategoryModel)
        return PremiumParentCategoryModel.fromJson(res.data);
      }
      return PremiumParentCategoryModel(data: []);
    } catch (e) {
      log("Error $e");
      return PremiumParentCategoryModel(data: []);
    }
  }
}
