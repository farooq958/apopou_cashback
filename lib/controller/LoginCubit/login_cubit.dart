import 'package:bloc/bloc.dart';
import 'package:cashback/controller/login_controller.dart';
import 'package:cashback/controller/testserver.dart';
import 'package:cashback/model/login_model.dart';
import 'package:cashback/view/bottom_navigation_screen.dart';
import 'package:cashback/view/custom_widgets/snack_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import "package:easy_localization/easy_localization.dart";
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../services/apis.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  /// login
  Future<void> userLogin({
    required BuildContext context,
    required String? email,
    required String? password,
    required String? fcmToken,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await prefs.getString("country_id") ?? "";
    var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
    emit(LoginLoading());
    if (email!.isEmpty || password!.isEmpty) {
      Snackbar.showSnack(
          context: context, message: 'Please enter email & password.'.tr());
    } else {
      print(email);
     await prefs.setString('email', email);
      print(password);
      //finalServer= email=="test@gmail.com"?testUrl:checkServer;
      finalServer = checkServer;
      print(finalServer+"server name");
      //log("SERVER $server");
      var request =
          http.MultipartRequest('POST', Uri.parse('$finalServer/api/login'));
      request.fields.addAll({
        'username': email,
        'password': password,
        'reg_source': fcmToken!.isNotEmpty ? fcmToken : ""
      });

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String str = await response.stream.bytesToString();
        print(str);
        try {
          LoginController.data = LoginModel.fromJson(str);

          await prefs.setString("token", LoginController.data.accessToken);
          print("### token= ${LoginController.data.accessToken}");
          print("### token2= ${LoginController.data.data.userId.toString()}");
          await prefs.setString(
              "uid", LoginController.data.data.userId.toString());

          emit(LoginSuccess());

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BottomNavigationScreen(
                        guest: false, isPremium: false,
                      )));
        } catch (e) {
          emit(LoginError());
          Snackbar.showSnack(
              context: context, message: 'Incorrect Email or Password'.tr());
        }
      } else {
        emit(LoginError());
        Snackbar.showSnack(
            context: context, message: 'Incorrect Email or Password'.tr());
        print(response.reasonPhrase);
      }
    }
  }
}
