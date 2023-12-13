import 'package:flutter/material.dart';
import 'package:mazloum_app/constants.dart';
import 'package:mazloum_app/models/category_model.dart';
import 'package:mazloum_app/services/category_service.dart';
import 'package:mazloum_app/services/product_service.dart';
import 'package:mazloum_app/widgets/carousel.dart';
import 'package:mazloum_app/widgets/flash_sale.dart';
import 'package:mazloum_app/widgets/products.dart';

import '../models/product_model.dart';

class HomeScreen extends StatelessWidget {
   const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FutureBuilder<List<ProductModel>>(
                  future: ProductService().getAllProductsw(page: 1,pageSize: 10),
                  builder: (context, snapshot) => snapshot.hasData ?  Card(shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),side: BorderSide(color: Colors.grey[350]!) ),
                     child: SizedBox(height:200,width:double.infinity,
                         child: Column(

                           children: [
                             const Padding(
                               padding: EdgeInsets.all(8.0),
                               child: Align(alignment:AlignmentDirectional.centerStart,child: Text("Flash Sale",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),)),
                             ),
                             Expanded(child: Carousel(length: snapshot.data?.length ?? 0,list: snapshot.data!.map((e) =>  FlashSale(product: e)).toList()) ),
                           ],
                         ))) : const SizedBox.shrink(),
               ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Align(alignment:AlignmentDirectional.centerStart,child: Text("Shop by Category",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),)),
                ),
                SizedBox(
                  height: 150,
                  child: FutureBuilder<List<CategoryModel>>(builder: (context, snapshot) => snapshot.hasData ?
                      ListView.builder(itemCount: snapshot.data?.length ?? 0,shrinkWrap: true,scrollDirection: Axis.horizontal,itemBuilder: (context, index) =>
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                SizedBox(height:100,width:100,child: FittedBox(fit: BoxFit.fill,child: CircleAvatar(backgroundImage: NetworkImage("${Constants.imgURL}${snapshot.data![index].image!}")))),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  child: Text(snapshot.data![index].name!),
                                ),
                              ],
                            ),
                          )) : const SizedBox.shrink(),
                    future: CategoryService().getAllCategories(),),
                ),
                const Divider(thickness: 1),
              const Products(title: "Indoor tiles",)

              ],
            ),
          ),
        ),
      ),
    );
  }
}

