import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../models/product_model.dart';
class SearchService {
  Future<List<ProductModel>> getSearch(String query) async {
    var response = await http.get(Uri.parse("${Constants
        .baseURL}/search/$query"), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json'});
    List<ProductModel> newItems = [];
    print(response.body);
    try {
      final json = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
        json.forEach((v) {newItems.add(ProductModel.fromJson(v));});
    } catch (e) {
      print(e.toString());
    }
    return newItems;

  }
}