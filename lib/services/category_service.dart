import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mazloum_app/models/category_model.dart';

import '../constants.dart';
class CategoryService {
  Future<List<CategoryModel>> getAllCategories({int page = 1,String lang = 'en',int pageSize = 10}) async {
    var response = await http.get(Uri.parse("${Constants
        .baseURL}/products/categories"), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json'});
    List<CategoryModel>? products;
    if (response.statusCode == 200) {
      try {
        final json = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
        products = <CategoryModel>[];
        json['data'].forEach((v) { products!.add(CategoryModel.fromJson(v)); });
      } catch (e) {
        print(e.toString());
      }
    }
    return products ?? [];

  }
}