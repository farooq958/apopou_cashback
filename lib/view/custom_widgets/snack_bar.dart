import 'package:flutter/material.dart';
import 'package:snack/snack.dart';
import 'package:cashback/view/imports.dart';
class Snackbar{
  static showSnack({required BuildContext context, required String message}){
    final bar = SnackBar(content: CustomText(message));
   bar.show(context);
  }
}