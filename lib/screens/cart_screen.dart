import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mazloum_app/constants.dart';
import 'package:mazloum_app/provider/cart_provider.dart';
import 'package:mazloum_app/screens/detail_product_screen.dart';
import 'package:mazloum_app/screens/payment_screen.dart';
import 'package:mazloum_app/screens/shipping_screen.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
    List<ProductModel> products = [];

  @override
  Widget build(BuildContext context) {
    products = context.watch<CartProvider>().cartItems;
    return Scaffold(body:
    Column(children: [
     products.isNotEmpty ? Expanded(
              child:  Container(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                height: MediaQuery.of(context).size.height * 0.53,
                child: AnimatedList(
                  shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    initialItemCount: products.length,
                    itemBuilder: (context, index, animation) {
                  return  Slidable(
                    useTextDirection: true,
                      startActionPane: ActionPane(
                      motion: const DrawerMotion(),
                      dismissible: DismissiblePane(onDismissed: (){
                      setState((){   context.read<CartProvider>().removeAt(index);});
                      ElegantNotification.success(description: const Text("Removed successfully")).show(context);
                      },), children: [CustomSlidableAction(onPressed: null, child: Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: MaterialButton(
                          onPressed: (){
                            setState((){   context.read<CartProvider>().removeAt(index);});
                          },
                          color: Colors.red.withOpacity(0.15),
                          elevation: 0,
                          height: 60,
                          minWidth: 60,
                          shape: const CircleBorder(),
                          child: const Icon(Icons.delete, color: Colors.red, size: 30,),
                        ),
                      ))],),
                    key: Key(products[index].id!.toString()),

                    child: cartItem(products[index], index, animation)
                  );
                }),
              )) :
      Expanded(child: Center(
        child:
         Image.asset("images/img_1.png")

      )),
       Container(
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton.icon(
            onPressed: products.isNotEmpty ? (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage()));
            } : null,
            icon: const Icon(Icons.credit_card_sharp),  //icon data for elevated button
            label: Row(
              children:  [
                const Text("Proceed to checkout"),
                 const Spacer(),
                 if(products.isNotEmpty) Text("${products.map((e) => e.price! * e.quantity!).reduce((value, element) => value + element)} L.E"),
              ],
            ), //label text
            style: ElevatedButton.styleFrom(
                primary: Colors.black
            ),
          ),
        ),

    ]));
  }
    cartItem(ProductModel product, int index, animation) {
      return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailProductScreen(product: product)));
        },
        child: SlideTransition(
          position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero
          ).animate(animation),
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  offset: const Offset(0, 2),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Row(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        "${Constants.imgURL}${products[index].images![0]}",
                        fit: BoxFit.cover,
                        height: 100,
                        width: 100,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(product.briefDetails!, style: TextStyle(color: Colors.orange.shade400, fontSize: 14,),),
                          const SizedBox(height: 5,),
                          Text(product.name!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            '${product.price} L.E',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          const SizedBox(height: 10),
                        ]
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MaterialButton(
                        minWidth: 10,
                        padding: const EdgeInsets.all(0),
                        onPressed: () {
                          setState(() {
                           product.quantity = product.quantity! - 1;
                          });
                        },
                        shape: const CircleBorder(),
                        child: Icon(Icons.remove_circle_outline, color: Colors.grey.shade400, size: 30,),
                      ),
                      Center(child: Text(product.quantity.toString(), style: TextStyle(fontSize: 20, color: Colors.grey.shade800),),),
                      MaterialButton(
                        padding: const EdgeInsets.all(0),
                        minWidth: 10,
                        splashColor: Colors.yellow[700],
                        onPressed: () {
                          setState(() {
                            product.quantity = product.quantity! + 1;
                          });
                        },
                        shape: const CircleBorder(),
                        child: const Icon(Icons.add_circle, size: 30,),
                      ),
                    ],
                  ),
                ]
            ),
          ),
        ),
      );
    }
}
