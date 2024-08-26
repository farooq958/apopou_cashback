import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cashback/controller/shared_preferences.dart';
import 'package:cashback/controller/testserver.dart';
import 'package:cashback/view/home_screen.dart';
import 'package:cashback/view/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'AppConstants.dart';
import 'services/apis.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutInitial());
  Future<bool> logout(
      {required BuildContext context, required bool guest}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await prefs.getString("country_id") ?? "";
    var checkServer = server == "1" ? BaseUrl : cyprusBaseUrl;
    finalServer=checkServer;
    var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};

    var request = http.Request('POST', Uri.parse('${finalServer}/api/logout'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      log("api getting successfully");
      log(await response.stream.bytesToString());
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }
}

showLoaderDialog(BuildContext context,
    {required VoidCallback onTap, required VoidCallback onCancelTap}) {
  AlertDialog alert = AlertDialog(
    insetPadding: EdgeInsets.zero,
    content: SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.width * 0.78,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20),
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("images/logoutIcon.png"))),
          ),
          SizedBox(
            height: 20.h,
          ),
          const Text(
            "Θέλετε να αποσυνδεθείτε?",
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
          SizedBox(
            height: 60.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: onCancelTap,
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  width: 145.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: const Color(0xffA7A7A7)),
                  child: const Center(
                    child: Text(
                      "Ακύρωση",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              InkWell(
                onTap: onTap,
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  width: 145.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppConstants.appDarkColor),
                  child: const Center(
                    child: Text("Αποσύνδεση",
                        //  "ΑΠΟΣΥΝΔΕΣΗ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
