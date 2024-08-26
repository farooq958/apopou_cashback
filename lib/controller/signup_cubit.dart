import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cashback/controller/shared_preferences.dart';
import 'package:cashback/controller/testserver.dart';
import 'package:cashback/model/sign_up_model.dart';
import 'package:cashback/view/bottom_navigation_screen.dart';
import 'package:cashback/view/custom_widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'services/apis.dart';
part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  Future<bool> signUp(
      String username,
      String email,
      String password,
      // String countryId,
      // String ref,
      BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await prefs.getString("country_id") ?? "";
    var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
    log("CheckServerfromsighnup $finalServer");
    finalServer=checkServer;
    var request =
        http.MultipartRequest('POST', Uri.parse('${finalServer}/api/register'));
    request.fields.addAll({
      'fname': username,
      'username': email,
      'password': password,
      'country': server == "1" ? "83" : "56",
      // 'ref': ref,
    });
    emit(SignupLoading());
    http.StreamedResponse response = await request.send();

    log(".... ${response.statusCode}  ${response.stream}");

    log("RESPONSE ${response.reasonPhrase}");

    if (response.statusCode == 200) {
      String str = await response.stream.bytesToString();

      log("..... ${str}");

      emit(SignupSucess());
      try {
        SignUpController.data = Signup.fromJson(str);

        prefs.setString("token", SignUpController.data.accessToken);

        prefs.setString("uid", SignUpController.data.data.userId.toString());

        return true;
      } catch (e) {
        log("testing ${e.toString()}");
        Snackbar.showSnack(
            context: context, message: "User Already Exist".tr());
        return false;
      }
    } else {
      log("RESPONSE ${response.reasonPhrase}");
      return false;
    }
  }
}

class SignUpController {
  static Signup data = Signup(
      tokenType: '',
      accessToken: '',
      data: Data(
          userId: 1,
          created: DateTime.now(),
          fname: '',
          ip: '',
          sha1: 343,
          username: ''));
}
