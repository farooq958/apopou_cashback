import 'dart:developer';
import 'package:cashback/controller/testserver.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/user_model.dart';
import '../shared_preferences.dart';
import 'apis.dart';

class UserService {
  Future<UserModel> getUserData() async {
    var dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await prefs.getString("country_id") ?? "";
    var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
    //print(checkServer.toString()+"serverrr");
    var headers = {'Authorization': 'Bearer ${await prefs.getString("token")}'};
    try {
      var res = await dio.get("${finalServer}/api/user",
          options: Options(headers: headers));

      log("Data user  ${res.data['data']}");
      if (res.statusCode == 200) {
        Map<String, dynamic> data = res.data['data'];

        UserModel userModel = UserModel.fromMap(data);

        return userModel;
      }
      return UserModel();
    } catch (e) {
      rethrow;
    }
  }
}
