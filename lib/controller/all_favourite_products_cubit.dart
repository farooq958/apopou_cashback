import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cashback/controller/all_favourite_controller.dart';
import 'package:cashback/controller/services/favorite_refresh_service.dart';
import 'package:cashback/controller/shared_preferences.dart';
import 'package:cashback/controller/testserver.dart';
import 'package:cashback/model/favourite_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'services/apis.dart';
part 'all_favourite_products_state.dart';

class AllFavouriteProductsCubit extends Cubit<AllFavouriteProductsState> {
  AllFavouriteProductsCubit() : super(AllFavouriteProductsInitial());
  Future<bool> allFavouriteProducts({required bool reload}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = await prefs.getString("country_id") ?? "";
    var email= await prefs.getString("email");
    var checkServer = id == "1" ? BaseUrl : cyprusBaseUrl;
  //  finalServer= email=="test@gmail.com"?testUrl:checkServer;
    finalServer=checkServer;
    log("Server $finalServer");
    if (AllFavouriteController.page <=
        AllFavouriteController.data.meta.pagination.totalPages) {
      var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};

      var request = http.Request(
          'GET',
          Uri.parse(
              '${finalServer}/api/user/${prefs.getString("uid")}/favorites?page=${AllFavouriteController.page.toString()}'));

      request.headers.addAll(headers);
      emit(AllFavouriteProductsLoading());
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String str = await response.stream.bytesToString();
        try {
          log("FAVORITE RESPONSE ${response.statusCode}");
          AllFavouriteController.data = FavouriteModel.fromRawJson(str);
          AllFavouriteController.listData
              .addAll(AllFavouriteController.data.data);
          AllFavouriteController.page = AllFavouriteController.page + 1;

          if (reload) {
            emit(AllFavouriteProductsRelaod());
            await Future.delayed(const Duration(milliseconds: 800));
            emit(AllFavouriteProductsLoaded());
          } else {
            emit(AllFavouriteProductsLoaded());
          }

          return true;
        } catch (e) {
          return false;
        }
      } else {
        emit(AllFavouriteProductsError());
        print(response.reasonPhrase);
        return false;
      }
    } else {
      return false;
    }
  }

  Future allInit() async {
    emit(AllFavouriteProductsInitial());
  }

  Future<bool> refreshFavourite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // var server = await prefs.getString("country_id") ?? "";
    // var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
    log("Server $finalServer");
    if (AllFavouriteController.page <=
        AllFavouriteController.data.meta.pagination.totalPages) {
      log("0");
      var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};

      var request = http.Request(
          'GET',
          Uri.parse(
              '${finalServer}/api/user/${prefs.getString("uid")}/favorites?page=${AllFavouriteController.page.toString()}'));

      request.headers.addAll(headers);
      emit(AllFavouriteProductsLoading());
      http.StreamedResponse response = await request.send();
      log("1");

      if (response.statusCode == 200) {
        log("2");
        String str = await response.stream.bytesToString();
        try {
          AllFavouriteController.listData.clear();
          log("3");

          AllFavouriteController.data = FavouriteModel.fromRawJson(str);
          log("FAVORITE RESPONSE ${str}");
          AllFavouriteController.listData
              .addAll(AllFavouriteController.data.data);

          log("Data ${AllFavouriteController.listData}");
          log("4");
          emit(AllFavouriteProductsLoaded());
          log("5");
          return true;
        } catch (e) {
          log("6");
          return false;
        }
      } else {
        log("7");
        emit(AllFavouriteProductsError());
        print(response.reasonPhrase);
        return false;
      }
    } else {
      return false;
    }
  }
}
