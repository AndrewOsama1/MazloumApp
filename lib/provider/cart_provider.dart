import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/product_model.dart';

class CartProvider with ChangeNotifier {
  final pref =   GetIt.instance<SharedPreferences>();
  List<ProductModel> cartItems = [];
  CartProvider(){
    String? cart = pref.getString('cart');
    if(cart != null) {
      final json = jsonDecode(cart);
      json.forEach((v) => cartItems.add(ProductModel.fromJson(v)));
    }
  }
  void add(ProductModel productModel){
    cartItems.add(productModel);
    print(jsonEncode(cartItems));
    pref.setString('cart', jsonEncode(cartItems));
    notifyListeners();
  }
  void removeAt(int index){
    cartItems.removeAt(index);
    print(jsonEncode(cartItems));
    pref.setString('cart', jsonEncode(cartItems));
    notifyListeners();
  }
}