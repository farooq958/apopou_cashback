import 'dart:developer';

import 'package:cashback/controller/services/retailerServices.dart';
import 'package:cashback/controller/services/service_marketplace.dart';
import 'package:cashback/model/market/marketPlace.dart';
import 'package:cashback/model/retailer/couponModel.dart';
import 'package:cashback/model/retailer/retailerModel.dart';

class RetailerRepo {
  final RetailerServices retailerServices;

  RetailerRepo({required this.retailerServices});

  Future<RetailerModel> getSingleRetailer({int? id}) async {
    try {
      var res = await retailerServices.getSingleRetailer(id: id);
      return res;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<CouponModel>> getCoupon({int? id}) async {
    try {
      var res = await retailerServices.getCoupon(id: id);
      return res;
    } catch (e) {
      throw e.toString();
    }
  }
}
