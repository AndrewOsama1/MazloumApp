import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class LoginProvider extends ChangeNotifier{
  String cookie =  "";
  LoginProvider(){

    GetIt.instance.isReady<SharedPreferences>().then((_) => updateCookie(UserModel.fromJson(jsonDecode(GetIt.instance<SharedPreferences>().getString('user')!)).cache ?? ""));
  }

  void updateCookie(String c){
    cookie = c;
    notifyListeners();
  }
}