import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bloc/bloc.dart';
import 'package:cashback/controller/all_featured_controller.dart';
import 'package:cashback/controller/all_products_controller.dart';
import 'package:cashback/controller/shared_preferences.dart';
import 'package:cashback/controller/testserver.dart';
import 'package:cashback/model/add_to_fav_model.dart';
import 'package:cashback/model/remove_fav.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'services/apis.dart';

part 'add_to_fav_state.dart';

class AddToFavCubit extends Cubit<AddToFavState> {
  AddToFavCubit() : super(AddToFavInitial());

  Future<void> addToFav(
      {required int id,
      required BuildContext context,
      required int index,
      required String type}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await prefs.getString("country_id") ?? "";
    var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
    var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};
    print(finalServer+"from1");
    var request = http.MultipartRequest(
        'POST', Uri.parse('${finalServer}/api/user/add/retailer-favorites'));
    request.fields.addAll({'retailer_id': id.toString()});

    request.headers.addAll(headers);
   // dialogSucess(context);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
     // Navigator.pop(context);
      AddToFav data = AddToFav.fromJson(await response.stream.bytesToString());
      if (data.success) {
        if (type == "all") {
          log("testing res status");
          AllProductsController.listData[index].favoriters = 1;
        }
        if (type == "feature") {
          AllFeatureController.listData[index].favoriters = 1;
        }
        if (type == "fav") {}
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> removeFav({
    required int id,
    required BuildContext context,
    required int index,
    required String type,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await prefs.getString("country_id") ?? "";
    var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
    var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('${finalServer}/api/user/remove/retailer-favorites'));
    request.fields.addAll({'retailer_id': id.toString()});

    request.headers.addAll(headers);
   // dialogSucess(context);
    http.StreamedResponse response = await request.send();
    print("Mai Hun Response Or ap $response");
    if (response.statusCode == 200) {
      RemoveFavModel data =
          RemoveFavModel.fromRawJson(await response.stream.bytesToString());
      if (data.success) {
        //Navigator.pop(context);
        if (type == "all") {
          AllFeatureController.listData[index].favoriters = 0;
        }
        if (type == "feature") {
          AllFeatureController.listData[index].favoriters = 0;
        }
        if (type == "fav") {}
      }
    } else {
      // errorDialog(context);
      print(response.reasonPhrase);
    }
  }

  dialogSucess(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => new Dialog(
              insetPadding: EdgeInsets.all(50),
              backgroundColor: Colors.white,
              child: new Container(
                  alignment: FractionalOffset.center,
                  height: 80.0,
                  width: 10,
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Colors.red,
                  ))),
            ));
  }

  errorDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.BOTTOMSLIDE,
      desc: 'Already Added to Favourites'.tr(),
      btnOkColor: Colors.red,
      btnOkOnPress: () {},
    )..show();
  }
}
