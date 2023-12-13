import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mazloum_app/models/product_model.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../constants.dart';

class FlashSale extends StatelessWidget {
  final ProductModel product;
  const FlashSale({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Column(children: [
     Row(
       children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(height:100,width:150,child: ClipRRect(borderRadius:BorderRadius.circular(8),child: CachedNetworkImage(imageUrl:"${Constants.imgURL}${product.images![0]}",fit: BoxFit.cover))),
      ),
         Column(
           children: [
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 3.0,vertical: 1),
               child: Text(product.name!,style: const TextStyle(overflow: TextOverflow.ellipsis,fontSize:8),),
             ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   Text("${product.price ?? 0} L.E",style: const TextStyle( decoration:
                   TextDecoration.lineThrough)),
                   const SizedBox(width: 20,),
                   Text("${product.salePrice ?? 0} L.E",style: const TextStyle(color: Colors.red,fontWeight: FontWeight.w600),),
                 ],
               ),
             ),
           ],
         ),
       ],
     ),
     LinearPercentIndicator(
       barRadius: const Radius.circular(12),
       lineHeight: 8.0,
       backgroundColor: Colors.grey[350],
       progressColor: Colors.red,
     ),
     Padding(
       padding: const EdgeInsets.all(8.0),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           const Text("Sold: 0",style: TextStyle(fontSize: 11,fontWeight: FontWeight.w500),),
           Text("Remaining: ${product.quantity}",style: const TextStyle(fontSize: 11,fontWeight: FontWeight.w500))
         ],
       ),
     ),

   ],);
  }

}