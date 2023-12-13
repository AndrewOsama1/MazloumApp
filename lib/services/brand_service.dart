import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../models/brand_model.dart';
class BrandService {
  Future<BrandModel> getAllBrands() async {
    var response = await http.get(Uri.parse("${Constants
        .baseURL}/brands"), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json'});
    BrandModel brandModel = BrandModel();
    print(response.body);
      try {
        final json = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
        brandModel = BrandModel.fromJson(json);
      } catch (e) {
        print(e.toString());
      }
    return brandModel;
  }
}