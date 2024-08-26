
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cashback/controller/premiumControllers/Services/premium_controllers.dart';
import 'package:cashback/controller/services/apis.dart';
import 'package:cashback/controller/shared_preferences.dart';
import 'package:cashback/controller/testserver.dart';
import 'package:cashback/model/premium/all_coupon_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ServicesAllCoupons{
  static List favouriteCoupons=[];

  loadAllPremiumCouponData(int pageNo,id,check)
  async {

    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var server = await prefs.getString("country_id") ?? "";
      var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
      finalServer=checkServer;
      print(finalServer+"server check");
      print(check);
      var request;
      if(check =="fromall") {
       request=http.Request(
            'GET', Uri.parse("${finalServer}/api/premium-coupons?page=$pageNo"));
      }
      else if(check=="fromfav")
        {
          String? userId= SharePrefs.prefs?.getString('uid');
          String? token= SharePrefs.prefs?.getString('token');
          var headers = {
            'Authorization': 'Bearer   $token'
          };
          ///pass user id from shared prefs.  ${prefs.get()}

          request=http.Request(
              'GET', Uri.parse("${finalServer}/api/premium-coupons/$userId/favorites"));
          request.headers.addAll(headers);
        }
      else if(check=="fromindividual")
          {
            String? userId= SharePrefs.prefs?.getString('uid');
            String? token= SharePrefs.prefs?.getString('token');
            var headers = {
              'Authorization': 'Bearer $token'
            };
            print('in individual');
            print(id);
            request= http.Request('GET', Uri.parse("${finalServer}/api/premium-coupons/retailers/$id"));
            request.headers.addAll(headers);
          }
      else
        {
       request= http.Request('GET', Uri.parse("${finalServer}/api/premium-coupons/categories/$id?page=$pageNo"));
        }
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var res = await response.stream.bytesToString();
        var stat = jsonDecode(res);
        log("premium response");
        log(stat.toString());
        var dat = stat['data'] as List;
      //  print(jsonDecode(res));
        print(dat.length);


        log(dat.toString());
      //  print(allCouponPremiumController.meta.pagination.currentPage);
        if (dat.isNotEmpty)

          {///print();
            ///
            var dto=List<HiddenAttrModel>.from(stat['data'].map((x) => HiddenAttrModel.fromJson(x)));
            if(pageNo >1){
              print(allCouponPremiumController.meta.pagination.totalPages.toString()+" total pages");
              print(allCouponPremiumController.meta.pagination.currentPage.toString()+" current page from api");
              print(pageNo.toString() +" next page manual");
            if(allCouponPremiumController.meta.pagination.totalPages >=pageNo)
              {
                dto.sort((a, b) =>
                    b.retailerName.compareTo(a.retailerName));
                allCouponPremiumController.data.addAll(dto);
              }
            }
            else
              {

          allCouponPremiumController = allCouponsPremiumModelFromJson(
            res);

              }
      }
        else
          {
            allCouponPremiumController=AllCouponsPremiumModel(data: [], meta: Meta(pagination: Pagination(total: 0, count: 0, perPage: 0, currentPage: 0, totalPages: 0, links: Links()),));
          }
      }
      else {
        print("error log");
        print("Status Code");
        print(response.statusCode);
        print("headers");
        print(response.headers);
        print("base request");
        print(response.request);
        print(response.reasonPhrase!+"reoson phrase");
        print("error log**");
      }



      return response.statusCode;
    }on SocketException catch (e) {
      debugPrint(e.toString());
      debugPrint('Internet connection is down.');
      return 10;
    } on Exception catch (e) {
      debugPrint('sent data api exception: $e');
      return 0;
    }




  }

  addPremiumCouponData(couponId)
  async {

    try{
      //var server = await prefs.getString("country_id") ?? "";
//var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
      String? userId= SharePrefs.prefs?.getString('uid');
      String? token= SharePrefs.prefs?.getString('token');
      var headers = {
        'Authorization': 'Bearer $token'
      };
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var server = await prefs.getString("country_id") ?? "";
      var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
      finalServer=checkServer;
      var request = http.MultipartRequest('POST', Uri.parse('${finalServer}/api/premium-coupons/add/coupon-favorites'));
      request.fields.addAll({
        'coupon_id': couponId.toString()
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
 var data1= await response.stream.bytesToString();
        ///print();
        print(data1);
 var data= jsonDecode(data1);
// print(data['message']);
if(data['success']!=null && data['success']==true ){
  addToFavouriteMessageController = data['message'].toString();
print(addToFavouriteMessageController);

}

      }
      else {
        print(response.reasonPhrase);
      }



      return response.statusCode;
    }on SocketException catch (e) {
      debugPrint(e.toString());
      debugPrint('Internet connection is down.');
      return 10;
    } on Exception catch (e) {
      debugPrint('sent data api exception: $e');
      return 0;
    }




  }
  removePremiumCouponData(couponId)
  async {

    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var server = await prefs.getString("country_id") ?? "";
var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
      String? userId= SharePrefs.prefs?.getString('uid');
      String? token= SharePrefs.prefs?.getString('token');
      finalServer=checkServer;
      var headers = {
        'Authorization': 'Bearer $token'
      };
      var request = http.MultipartRequest('POST', Uri.parse('$finalServer/api/premium-coupons/remove/coupon-favorites'));
      request.fields.addAll({
        'coupon_id': couponId.toString()
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data1= await response.stream.bytesToString();
        ///print();
        //  print();
        var data= jsonDecode(data1);
// print(data['message']);
        if(data['success']!=null && data['success']==true ){
          removeFromFavouriteMessageController = data['message'].toString();
         //print(addToFavouriteMessageController);

        }

      }
      else {
        print(response.reasonPhrase);
      }



      return response.statusCode;
    }on SocketException catch (e) {
      debugPrint(e.toString());
      debugPrint('Internet connection is down.');
      return 10;
    } on Exception catch (e) {
      debugPrint('sent data api exception: $e');
      return 0;
    }




  }
  getAllFavouriteCoupons() async {
    try {
      String? userId = SharePrefs.prefs?.getString('uid');
      String? token = SharePrefs.prefs?.getString('token');
      var headers = {
        'Authorization': 'Bearer   $token'
      };

      ///pass user id from shared prefs.  ${prefs.get()}
print(finalServer +"serverfinal");
print(userId);
print(token);
      var request = http.Request(
          'GET', Uri.parse(
          "${finalServer}/api/premium-coupons/$userId/favorites"));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {

        ///print();

        var data=jsonDecode(await response.stream.bytesToString());
        log("data from favourite$data");
       // print(data['data']);
        return data['data'] as List ;


    }
    else {
    log(response.statusCode.toString()+"res");
    }



    return response.statusCode;
    } on SocketException catch (e) {
      debugPrint(e.toString());
      debugPrint('Internet connection is down.');
      return 10;
    } on Exception catch (e) {
      debugPrint('sent data api exception: $e');
      return 0;
    }
  }


  getHiddenAttribute(couponId)
  async {
    String? token = SharePrefs.prefs?.getString('token');
    var headers = {
      'Authorization': 'Bearer $token'
    };
    print('$finalServer/api/premium-coupons/$couponId/hidden-atts');
    var request = http.Request('GET', Uri.parse('$finalServer/api/premium-coupons/$couponId/hidden-atts'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

var dto = jsonDecode(await response.stream.bytesToString());
print(dto['data']);
    if (response.statusCode == 200) {
     return HiddenAttrModel.fromJson(dto["data"]);
  }
  else {
 return 0;
  }


  }

}
//await dio.get("${testUrl}/api/premium-coupons/categories/$id");
//var server = await prefs.getString("country_id") ?? "";
//var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;