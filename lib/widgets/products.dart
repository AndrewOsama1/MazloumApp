import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mazloum_app/screens/detail_product_screen.dart';

import '../constants.dart';
import '../models/product_model.dart';
import '../provider/cart_provider.dart';
import '../services/product_service.dart';

class Products extends StatefulWidget {
  final bool showOff;
  final String? title;
  final List<String>? category,color,brand;
  const Products({Key? key, this.showOff = true,  this.title, this.category, this.color, this.brand}) : super(key: key);

  @override
  State<Products> createState() => ProductsState();
}

class ProductsState extends State<Products> {
  final PagingController<int, ProductModel> pagingController = PagingController(firstPageKey:1);



  @override
  void initState() {
    pagingController.addPageRequestListener((lastIndex) {
      _fetchPage(lastIndex);});
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
  return  SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
         if(widget.title != null) SizedBox(
           height: 100,
           child: Padding(
             padding: const EdgeInsets.all(8.0),
             child: Row(
               children: [
                 Expanded(child : Text("Best Selling ${widget.title!}",style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 20),)),

                 ElevatedButton(onPressed: (){}, child: const Text("See more"))
               ],
             ),
           ),
         ),
          Flexible(
            child: PagedGridView<int, ProductModel>(
                shrinkWrap: true,
                physics: widget.showOff ? const NeverScrollableScrollPhysics() : const AlwaysScrollableScrollPhysics(),
                pagingController: pagingController,
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: MediaQuery.of(context).size.height * 0.50,
                  crossAxisCount: MediaQuery.of(context).size.width ~/ 150,
                ),
                builderDelegate: PagedChildBuilderDelegate<ProductModel>(
                  itemBuilder: (context, item, index) {
                    return InkWell(
                      onTap: (){
                      /*  GetIt.instance<CartProvider>().add(item);
                        ElegantNotification.success(
                            title:  Text("Update"),
                            description:  Text("Your data has been updated")
                        ).show(context);*/
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailProductScreen(product: item)));
                        },
                      child: ProductItem(item: item),
                    );
                  },
                ),
              ),
          ),
        ],
      ),

  );
  }
  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int page) async {
    print(widget.color);
    try {
      List<ProductModel> newItems = await ProductService().getAllProductsw(page: page,color: widget.color,category: widget.category,brand: widget.brand);
      if (newItems.length < 10 || widget.showOff) {
        pagingController.appendLastPage(newItems);
      } else {
        pagingController.appendPage(newItems, page+1);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }
}
class ProductItem extends StatelessWidget {
  final ProductModel item;
  const ProductItem({
    Key? key, required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(

      child: Card(child: Column(children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:  Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(borderRadius: const BorderRadius.only(topRight: Radius.circular(5),topLeft: Radius.circular(5)),
                    child: CachedNetworkImage(fit: BoxFit.cover, imageUrl: "${Constants.imgURL}${item.images![0]}")),
                Positioned(
                  bottom: -10,
                  right: -10,
                  child: Transform(
                    transform:  Matrix4.identity()..scale(0.6),
                    child:  const Chip(
                      label:  Text(
                        "AR",
                        overflow: TextOverflow.ellipsis,
                        style:  TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                      ),
                      backgroundColor: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Flexible(
          fit: FlexFit.loose,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0,vertical: 1),
            child: Text(item.name!,style: const TextStyle(fontSize: 12),),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: Text(item.details!,style: const TextStyle(overflow: TextOverflow.ellipsis,fontSize: 12,color: Colors.grey)),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("${item.price ?? 0} L.E",style: const TextStyle( decoration:
            TextDecoration.lineThrough)),
            SizedBox(height: 3,),
            Text("${item.salePrice ?? 0} L.E",style: const TextStyle(color: Colors.red,fontWeight: FontWeight.w600),),
          ],
        ),
      ])),
    );
  }
}
