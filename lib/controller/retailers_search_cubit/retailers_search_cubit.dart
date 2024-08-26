import 'package:bloc/bloc.dart';
import 'package:cashback/controller/shared_preferences.dart';
import 'package:cashback/controller/testserver.dart';
import 'package:cashback/model/retailers_search_model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../services/apis.dart';
part 'retailers_search_state.dart';

class RetailersSearchCubit extends Cubit<RetailersSearchState> {
  RetailersSearchCubit() : super(RetailersSearchInitial());

  Future<void> searchRetailer(String storeName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await prefs.getString("country_id") ?? "";
    var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
    finalServer=checkServer;
    var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};
    var request = http.MultipartRequest('GET', Uri.parse(
        // '${checkServer}/api/retailers?include=categories&search=$storeName&fields=identifier,storeName,storeImgURL,storeCashback,coupons_count,products_count,favoriters'));
        '${finalServer}/api/retailers?search=$storeName&fields=identifier,storeName,storeImgURL,storeCashback,coupons_count,products_count,favoriters'));

    request.headers.addAll(headers);
    emit(RetailersSearchLoading());

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      RetailerSearchController.data = RetailersSearchModel.fromRawJson(
          await response.stream.bytesToString());
      emit(RetailersSearchLoaded());
    } else {
      emit(RetailersSearchError());
      print(response.reasonPhrase);
    }
  }
}

class RetailerSearchController {
  static RetailersSearchModel data = RetailersSearchModel(
    data: [],
  );
}
