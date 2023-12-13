import 'dart:async';
import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:mazloum_app/models/session_model.dart';
import 'package:mazloum_app/provider/login_provider.dart';


import '../constants.dart';

class PaymentService {
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json','cookie': GetIt.instance<LoginProvider>().cookie};

  Future<SessionModel> createSession(bool mobile,int addressId) async {
    print(jsonEncode({'mobile':false,'addressId':addressId}));
    print(headers['cookie']);

    var response = await http.post(Uri.parse("${Constants.baseURL}/payment/session/create"), headers: headers,body: jsonEncode({'mobile':mobile,'addressId':addressId}));
    SessionModel sessionModel = SessionModel();
    try {
      final json = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
      sessionModel = SessionModel.fromJson(json);
    } catch (e) {
      print(e.toString());
    }
    return sessionModel;
  }
  Future<SessionModel> updateSession() async {
    var response = await http.post(Uri.parse("${Constants.baseURL}/payment/session/create"), headers: headers,body: jsonEncode({'mobile':false}));
    print(response.body);
    SessionModel sessionModel = SessionModel();
    try {
      final json = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
      sessionModel = SessionModel.fromJson(json);
    } catch (e) {
      print(e.toString());
    }
    return sessionModel;
  }
}