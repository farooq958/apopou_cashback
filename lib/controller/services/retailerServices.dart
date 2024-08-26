import 'dart:developer';
import 'package:cashback/controller/shared_preferences.dart';
import 'package:cashback/controller/testserver.dart';
import 'package:cashback/model/retailer/couponModel.dart';
import 'package:cashback/model/retailer/retailerModel.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'apis.dart';

class RetailerServices {
  Future<RetailerModel> getSingleRetailer({int? id}) async {
    var dio = Dio();
    RetailerModel? list;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await prefs.getString("country_id") ?? "";
    var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
    finalServer=checkServer;
    try {
      var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};
      var res = await dio.get("${finalServer}/api/retailers/$id",
          options: Options(headers: headers));
      log("DATAA from retailor ${res.data}");
      log("testing status ${res.statusCode}");
      if (res.statusCode == 200) {
        if (res.data['data'] != null) {
          list = RetailerModel.fromMap(res.data['data']);
        }
        log('listdata ${list?.storeTerms}');

        return list!;
      }

      throw "Error";
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CouponModel>> getCoupon({int? id}) async {
    var dio = Dio();
    List<CouponModel> list = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await prefs.getString("country_id") ?? "";
    var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
    finalServer=checkServer;

    try {
      var headers = {'Authorization': 'Bearer ${ await prefs.getString("token")}'};
print("url from change + ${finalServer}/api/retailers/$id/coupons?exclusive=0");
print(await prefs.getString("token"));
      var res = await dio.get("${finalServer}/api/retailers/$id/coupons?exclusive=0",
          options: Options(headers: headers));

      log("testing status coupon ${res.statusCode}");
      log('datacouponsingle ${res.data}');
      if (res.statusCode == 200) {
//print("herein200");
     list=List<CouponModel>.from(res.data["data"].map((x) => CouponModel.fromMap(x)));
//print("here200");
        if (res.data['data'].runtimeType is List) {


          // res.data['data'].forEach((e) {
          //   list.add(CouponModel.fromMap(e));
          // });


        }
log("dataoflistcoupon ${list}");
        return list;
      }

      throw "Error";
    } catch (e) {
      //throw e;
     // print("here");
      //print(e);
      rethrow;
    }
  }
}
