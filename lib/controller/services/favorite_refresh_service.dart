import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/favourite_model.dart';
import '../all_favourite_controller.dart';
import 'apis.dart';
import 'package:http/http.dart' as http;

class FavouriteLoadAgain {
  static Future<bool> favouriteLoadAgain() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await prefs.getString("country_id") ?? "";
    var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
    log("Server $checkServer");

    var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};

    var request = http.Request(
        'GET',
        Uri.parse(
            '${checkServer}/api/user/${prefs.getString("uid")}/favorites?page=${AllFavouriteController.page.toString()}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    String str = await response.stream.bytesToString();
    AllFavouriteController.data = FavouriteModel.fromRawJson(str);
    AllFavouriteController.listData.addAll(AllFavouriteController.data.data);
    // AllFavouriteController.page = AllFavouriteController.page + 1;
    log("LOAD AGAIN ${AllFavouriteController.listData}");
    return true;
  }
}
