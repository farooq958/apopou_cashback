import 'dart:developer';

import 'package:cashback/controller/services/currency_service.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharePrefs {
  static SharedPreferences? prefs;
  static late PageController? tabPageController;

  static RefreshController refreshController =
      RefreshController(initialRefresh: false);

  static void activateHomeTabController() {
    tabPageController = PageController(initialPage: 0);
  }

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }
}

class CurrencyPrefs {
  static Future<void> setCurrency() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> map = await CurrencyService.getCurrency();
    var currency = map['data'][0]['setting_value'];
    var yearlyMaintenanceFee = map['data'][1]['setting_value'];
    await prefs.setString("currency", currency);
    await prefs.setString("yearly_maintenance_fee", yearlyMaintenanceFee);
  }

  static Future<String> getCurrency() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var currency = _prefs.getString("currency") ?? "€";
    log("Currency $currency");
    return currency;
  }

  static Future<String> getYearlyFee() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var yearlyMaintenanceFee =
        _prefs.getString("yearly_maintenance_fee") ?? "5";
    log("Currency $yearlyMaintenanceFee");
    return yearlyMaintenanceFee;
  }
}
