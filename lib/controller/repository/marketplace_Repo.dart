// class VerifyCodeRepository {
//   final VerifyCodeServices verifyCodeServices;
//
//   VerifyCodeRepository({required this.verifyCodeServices});
//
//   Future<dynamic> verifyCodeOtp(int PhoneNumber, String Otp) async {
//     try {
//       var res = await verifyCodeServices.VerifyCode(PhoneNumber, Otp);
//       log("res repo ${res}");
//       return res;
//     } on CustomError catch (e) {
//       throw CustomError(error: e.toString());
//     }
//   }
// }

import 'dart:developer';

import 'package:cashback/controller/services/service_marketplace.dart';
import 'package:cashback/model/market/marketPlace.dart';

class MarketPlaceCategoryResposity {
  final MarketPlaceService allProductCategoryService;

  MarketPlaceCategoryResposity({required this.allProductCategoryService});

  Future<List<MarketPlaceModel>> MarketPlaceRepository(int id) async {
    try {
      var res = await allProductCategoryService.marketCategory(id);
      return res;
    } catch (e) {
      log("repository errror${e.toString()}");
      return [];
    }
  }
}
