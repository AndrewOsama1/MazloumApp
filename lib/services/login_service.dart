import 'dart:async';
import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:mazloum_app/models/address_model.dart';
import 'package:mazloum_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class LoginService {
   Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'};

   Future<void> login(String email,String password) async {
    print("${Constants.baseURL}/login");
    print( jsonEncode({'email':email,'password':password}));
    var response = await http.post(Uri.parse("${Constants
        .baseURL}/login"), headers: headers,body: jsonEncode({'email':email,'password':password}));

    print(response.body);
    updateCookie(response);
    try {
      final json = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
      final temp = UserModel.fromJson(json);
      temp.cache  = headers['cookie'] ?? "";
      GetIt.instance<SharedPreferences>().setString('user', jsonEncode(temp));
    } catch (e) {
      print(e.toString());
    }

  }
   Future<List<AddressModel>> getAddresses() async {

     headers['cookie'] =  UserModel.fromJson(jsonDecode(GetIt.instance<SharedPreferences>().getString('user')!)).cache ?? "";
     print(headers['cookie']);
    var response = await http.get(Uri.parse("${Constants.baseURL}/user/profile/address"), headers: headers);
    print(response.body);
    List<AddressModel> list = [];
    try {
      final json = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
      json.forEach((v) => list.add(AddressModel.fromJson(v)));
    } catch (e) {
      print(e.toString());
    }
    return list;
  }
   void updateCookie(http.Response response) {
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers['cookie'] = (index == -1) ? rawCookie : rawCookie.substring(0, index);

    }
  }
}