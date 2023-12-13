import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mazloum_app/models/color_model.dart';
import 'package:mazloum_app/models/product_model.dart';

import '../constants.dart';


class ProductService {
   Future<List<ProductModel>> getAllProductsw({int page = 1,String lang = 'en',int pageSize = 10,List<String>? color,List<String>? brand,List<String>? category}) async {
     final queryParameters = {
       'pageSize': "10",
       'pageNumber': "$page",
     };



     if(category != null && category.isNotEmpty) queryParameters['category'] = category.join(",");
     if(brand != null && brand.isNotEmpty) queryParameters['brand'] = brand.join(",");
     if(color != null && color.isNotEmpty) queryParameters['color'] = color.join(",");
     final uri =  Uri.https("www.mazloumtiles.online",'/api/en/products', queryParameters);
     print(uri);
    var response = await http.get(Uri.https("www.mazloumtiles.online",'/api/en/products', queryParameters), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json'});
    print(response.body);
    List<ProductModel> newItems = [];
      try {
        final json = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));


        for (var element in json.entries) {
          element.value.forEach((v) {newItems.add(ProductModel.fromJson(v));});
        }
      } catch (e) {
        print(e.toString());
      }

    return newItems;

  }
  //https://www.mazloumtiles.online/api/products/maxPrice
   Future<double> getMaxPrice() async {
     var response = await http.get(Uri.parse("https://www.mazloumtiles.online/api/products/maxPrice"), headers: {
       'Content-Type': 'application/json',
       'Accept': 'application/json'});
    double maxPrice = 0.0;
     try {
       final json = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
       maxPrice =   json['maximumPrice'] * 1.0;
     } catch (e) {
       print(e.toString());
     }
     return maxPrice;

   }
   Future<ColorModel> getColors() async {
     var response = await http.get(Uri.parse("${Constants.baseURL}/colors"), headers: {
       'Content-Type': 'application/json',
       'Accept': 'application/json'});
     ColorModel colorModel = ColorModel();
     try {
       final json = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
       colorModel =   ColorModel.fromJson(json);
     } catch (e) {
       print(e.toString());
     }
     return colorModel;
   }
}