import 'dart:async';

import 'package:flutter/services.dart';

class FlutterMpgsSdk {
  static const MethodChannel _channel =
      const MethodChannel('flutter_mpgs_sdk');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
  static Future init({ String? gatewayId,  String? region, apiVersion}) async {
    await _channel.invokeMethod('init',
        {'gatewayId': gatewayId, 'region': region, 'apiVersion': apiVersion});
  }

  static Future<void> updateSession(
      { String? sessionId,
         String? cardHolder,
         String? cardNumber,
         String? year,
         String? month,
         String? cvv}) async {
    print(sessionId);
    {
      await _channel.invokeMethod('updateSession', {
        'sessionId': sessionId,
        'cardHolder': cardHolder,
        'cardNumber': cardNumber,
        'year': year,
        'month': month,
        'cvv': cvv
      });
    }
  }
}
class Region {
  static const String MTF = "test-";
  static const String ASIA_PACIFIC = "ap-";
  static const String EUROPE = "eu-";
  static const String NORTH_AMERICA = "na-";
}
