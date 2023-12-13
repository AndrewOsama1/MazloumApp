import 'package:flutter/material.dart';
import 'package:mazloum_app/constants.dart';
import 'package:mazloum_app/widgets/mazloum_app_bar.dart';
import 'package:mazloum_app/models/product_model.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import '../provider/cart_provider.dart';

class DetailProductScreen extends StatelessWidget {
  final ProductModel product;
  const DetailProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
  return SafeArea(
    child: Scaffold(
      appBar:MazloumAppBar(title: product.name!,hasBack: true,isDetailed: true),
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
      SizedBox(height:height * 0.35,width: double.infinity,child: ClipRRect(borderRadius: const BorderRadius.only(topRight: Radius.circular(5),topLeft: Radius.circular(5)),
          child: Image.network("${Constants.imgURL}${product.images![0]}",fit: BoxFit.cover))),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(product.name!,style: const TextStyle(fontSize:16,color: Colors.black,fontWeight: FontWeight.w500)),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(product.details!,style: const TextStyle(fontSize:13,color: Colors.grey)),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text("${product.price!} L.E",style:  TextStyle( decoration:
            TextDecoration.lineThrough,fontSize: 15,color: Colors.grey.shade600)),
            const SizedBox(width: 50),
            Text("${product.salePrice!} L.E",style: const TextStyle(color: Colors.red,fontSize: 16  ,fontWeight: FontWeight.w800)),
            const Spacer(),
            IconButton(onPressed: (){
              _ar();
            }, icon: const Icon(Icons.view_in_ar,size: 35,))
          ],
        ),
      ),
      const Divider(thickness: 1,),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Text("SKU:",style: TextStyle(fontSize:12,color: Colors.black,fontWeight: FontWeight.w500)),
            const SizedBox(width: 10),
            Text(product.mazloumBarcode!,style:  TextStyle(fontSize:14,color: Colors.grey.shade600,fontWeight: FontWeight.w500)),
          ],
        ),
      ), Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children:  [
            const Text("Category:",style: TextStyle(fontSize:12,color: Colors.black,fontWeight: FontWeight.w500)),
            const SizedBox(width: 10),
            Text("Imported Pocelain & Laser",style:  TextStyle(fontSize:14,color: Colors.grey.shade600,fontWeight: FontWeight.w500)),
          ],
        ),
      ),
        const Spacer(),
       Align(
          alignment: FractionalOffset.bottomCenter,
          child:  DetailedProductQuantity(product: product),
        ),

    ],)),
  );
  }
  void _ar() async {
   // List<String> temp = _parseDim();
    var sendMap = <String, dynamic>{
      "image":"${Constants.imgURL}${product.images![0]}" ,
      "dimX": 2,
      "dimY": 2,
      "name": product.name ?? "",
      "brand": product.briefDetails ?? "",
      "tilesUnit": product.tilesInUnit ?? 1.0
    };

    var value;
    try {
      value = await Constants.platform.invokeMethod("printy",sendMap);
    } catch (e) {
      print(e.toString());
    }
    print(value);
  }
  //List<String> _parseDim() => product.specifications!.firstWhere((element) => element.specId == 3).valueNameEn.toString().replaceAll(new RegExp(r'[^0-9]^(.*)'),'').split("*").toList();

}

class DetailedProductQuantity extends StatefulWidget {
  const DetailedProductQuantity({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  State<DetailedProductQuantity> createState() => _DetailedProductQuantityState();
}

class _DetailedProductQuantityState extends State<DetailedProductQuantity> {
  int quantity = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MaterialButton(
          minWidth: 10,
          padding: const EdgeInsets.all(0),
          onPressed: () {
            setState(() {
              quantity--;
            });
          },
          shape: CircleBorder(),
          child: Icon(Icons.remove_circle_outline, color: Colors.grey.shade400, size: 30,),
        ),
        Center(child: Text(quantity.toString(), style: TextStyle(fontSize: 20, color: Colors.grey.shade800),),),
        MaterialButton(
          padding: const EdgeInsets.all(0),
          minWidth: 10,
          splashColor: Colors.yellow[700],
          onPressed: () {
            setState(() {
              quantity++;
            });
          },
          shape: const CircleBorder(),
          child: const Icon(Icons.add_circle, size: 30,),
        ),
        Expanded(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(onPressed: (){
            widget.product.quantity = quantity;
            context.read<CartProvider>().add(widget.product);
          }, child: Text("Add to cart")),
        )),
      ],
    );
  }
}