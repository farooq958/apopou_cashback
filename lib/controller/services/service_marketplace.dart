import 'dart:convert';
import 'dart:developer';

import 'package:cashback/controller/subCategoryController.dart';
import 'package:cashback/controller/testserver.dart';
import 'package:cashback/model/market/marketPlace.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'apis.dart';

class MarketPlaceService {
  MarketPlaceService();
  Future<List<MarketPlaceModel>> marketCategory(int id) async {
    var dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await prefs.getString("country_id") ?? "";
    var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
    finalServer=checkServer;
    List<MarketPlaceModel> marketProductlist = [];
    log("testing all id ${id}");

    try {
      // var res = await dio.get(
      //     "${checkServer}/api/category/$id/retailers?include=categories&fields=identifier,storeName,storeImgURL,storeCashback,featuredStore,noOfVisits,favoriters,coupons_count,products_count&page=${SubCategoryController.page}");
      var res = await dio.get(
          "${finalServer}/api/category/$id/retailers?fields=identifier,storeName,storeImgURL,storeCashback,featuredStore,noOfVisits,favoriters,coupons_count,products_count&page=${SubCategoryController.page}");
      var data = json.decode(json.encode(res.data));

      log("MarketPlace Api Res ${res.data}");
      if (res.statusCode == 200) {
        if (res.data['data'] is List) {
          SubCategoryController.list = [];
          res.data['data'].forEach((e) {
            // marketProductlist.add(MarketPlaceModel.fromMap(e));
            SubCategoryController.list.add(MarketPlaceModel.fromMap(e));
          });
          // SubCategoryController.page = SubCategoryController.page + 1;

          log("SubCategory ${SubCategoryController.list.length}");

          if (SubCategoryController.page == 1) {
            log("testing all numbers ${res.data['meta']['pagination']}");
            log("testing all numbers  ${res.data['meta']['pagination']['count']}  : ${res.data['meta']['pagination']['total_pages']} ::: ${res.data['meta']['pagination']['count'] * res.data['meta']['pagination']['total_pages']}");
            SubCategoryController.total = res.data['meta']['pagination']
                    ['count'] *
                res.data['meta']['pagination']['total_pages'];

            SubCategoryController.totalPages =
                res.data["meta"]["pagination"]["total_pages"];

            log("Total Pages ${SubCategoryController.totalPages}");

            // SubCategoryController.total =
            //     res.data['meta']['pagination']['total'];
            log("testing res ${marketProductlist}");
          }
          return marketProductlist;
        }
      }

      throw "Error";
    } catch (e) {
      log("service error  ${e.toString()}");
      return [];
    }
  }
}
