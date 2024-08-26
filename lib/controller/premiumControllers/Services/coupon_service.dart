// import 'dart:developer';
// import 'dart:io';
// import 'package:cashback/controller/services/apis.dart';
// import 'package:cashback/model/premium/coupon_model.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// class PremiumCouponService {
//   loadAllPremiumCouponData(int pageNo,int id,int check)
//   async {
//
//     try{
//       //var request =
//
//
//       http.StreamedResponse response = await request.send();
//
//       if (response.statusCode == 200) {
//         ///print();
//         allCouponPremiumController=allCouponsPremiumModelFromJson(await response.stream.bytesToString());
//
//       }
//       else {
//         print(response.reasonPhrase);
//       }
//
//
//
//       return response.statusCode;
//     }on SocketException catch (e) {
//       debugPrint(e.toString());
//       debugPrint('Internet connection is down.');
//       return 10;
//     } on Exception catch (e) {
//       debugPrint('sent data api exception: $e');
//       return 0;
//     }
//
//
//
//
//   }
//
// }
