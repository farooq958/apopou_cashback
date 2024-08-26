import 'package:cashback/model/login_model.dart';
import 'package:flutter/material.dart';

class LoginController {

  static LoginModel data = LoginModel(
      tokenType: '',
      data: Data(
        userId: 0,
        username: '',
        email: '',
        fname: '',
        lname: '',
        gender: '',
        address: '',
        address2: '',
        city: '',
        state: '',
        zip: '',
        country: 0,
        phone: '',
        paymentMethod: '',
        regSource: '',
        refClicks: 0,
        refId: 0,
        refBonus: 0,
        newsletter: 0,
        ip: '',
        status: '',
        authProvider: '',
        authUid: '',
        unsubscribeKey: '',
        loginSession: '',
        lastLogin: '',
        loginCount: 0,
        lastIp: '',
        created: DateTime.now(),
        blockReason: '',
        validated: 0,
        sha1: 0,
        providerName: '',
        providerId: '',
        deletedAt: '',
      ),
      accessToken: '');
}
