import 'package:flutter/material.dart';
import 'package:mazloum_app/models/brand_model.dart';
import 'package:mazloum_app/models/color_model.dart';
import 'package:mazloum_app/services/brand_service.dart';
import 'package:mazloum_app/services/category_service.dart';
import 'package:mazloum_app/services/product_service.dart';
import 'package:mazloum_app/widgets/products.dart';

import '../models/category_model.dart';
class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<String> category = [],brand = [],colors = [];
  List<String> filterCategory = [],filterBrand = [],filterColors = [];
  final GlobalKey<ProductsState> _formKey = GlobalKey<ProductsState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<List<CategoryModel>> future;
  double maxPrice = 0.0;
  var selectedRange = const RangeValues(150.00, 1500.00);
  @override
  void initState() {
    future = CategoryService().getAllCategories();
    WidgetsBinding.instance.addPostFrameCallback((_) => showFilterModal().then((value) => setState((){})));
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(actions: [IconButton(onPressed: (){
        showFilterModal().then((value) => setState((){}));
      },icon: const Icon(Icons.filter_list))],backgroundColor: Colors.black,automaticallyImplyLeading: true),
      body:  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
          children: [
             Wrap(children: [...category.map((e) =>_customBadge(e,const Icon(Icons.close,color: Colors.white),(){
        setState(() {
          category.remove(e);
          _formKey.currentState!.pagingController.refresh();
        });
      })).toList(),...brand.map((e) => _customBadge(e,const Icon(Icons.close,color: Colors.white), (){
                setState(() {
                  brand.remove(e);
                  _formKey.currentState!.pagingController.refresh();
                });
              },)).toList(),...colors.map((e) => _customBadge(e,const Icon(Icons.close,color: Colors.white),(){
                setState(() {
                  colors.remove(e);
                  _formKey.currentState!.pagingController.refresh();
                });
              },)).toList(),]),

            Expanded(flex:5,child: Products(key:_formKey,brand: brand,category: category,color: colors,showOff: false)),
          ],
        )
    ),
    );
  }
  Widget _customBadge(String label,Widget icon,void Function()? onDeleted){
    return Transform(
      transform:  Matrix4.identity()..scale(0.8),
      child:   Chip(
        key: Key(label),
        label:  Text(
          label,
          overflow: TextOverflow.ellipsis,
          style:  const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        deleteIcon: icon,
        onDeleted: onDeleted,
      ),
    );
  }
  Future<void> showFilterModal() async {
   await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
      ),
      builder: (context) {
        return StatefulBuilder(
            builder: (context, setState) {
              return Container(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
                height: MediaQuery.of(context).size.height * 0.9,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Filter', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                          MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            minWidth: 40,
                            height: 40,
                            color: Colors.grey.shade300,
                            elevation: 0,
                            padding: const EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)
                            ),
                            child: const Icon(Icons.close, color: Colors.black,),
                          )
                        ],
                      ),
                      const SizedBox(height: 20,),
                      const Text("Category", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      const SizedBox(height: 10,),
                      SizedBox(
                        height: 40,
                        child: FutureBuilder<List<CategoryModel>>(
                          future: future,
                          builder: (context, snapshot) => ListView.builder(shrinkWrap: true,scrollDirection: Axis.horizontal,itemCount: snapshot.data?.length ?? 0,
                            itemBuilder: (context, index) =>
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                  child: TextButton(onPressed: (){
                                    if(!category.contains(snapshot.data![index].slug)){
                                      category.add(snapshot.data![index].slug!);
                                    }else {
                                      category.remove(snapshot.data![index].slug);
                                    }
                                    setState(() {});
                                  },   style: ButtonStyle(
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(222.0),
                                          side: BorderSide(color:  category.contains(snapshot.data![index].slug)   ? Colors.black : Colors.grey)
                                      ),
                                    ),
                                    backgroundColor:MaterialStateProperty.all<Color>(/*category.contains(snapshot.data![index].slug) ? Colors.black:*/ Colors.white),
                                    padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.only(left: 15,right: 15)),
                                  ),

                                    child: Row(mainAxisAlignment:MainAxisAlignment.center,children: [
                                      Checkbox(value: category.contains(snapshot.data![index].slug) ?? false, onChanged: null),
                                      Text(snapshot.data![index].name!,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black)),
                                    ],),
                                  ),
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      const Text('Color', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                      const SizedBox(height: 10,),
                      SizedBox(
                        height: 40,
                        child: FutureBuilder<ColorModel>(
                          future: ProductService().getColors(),
                          builder: (context, snapshot) => ListView.builder(shrinkWrap: true,scrollDirection: Axis.horizontal,itemCount: snapshot.data?.colors?.length ?? 0,
                            itemBuilder: (context, index) =>
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                  child: TextButton(onPressed: (){
                                    if(!colors.contains(snapshot.data?.colors?[index].slug)){
                                      colors.add(snapshot.data!.colors![index].slug!);
                                    }else {
                                      colors.remove(snapshot.data!.colors![index].slug);
                                    }
                                    setState(() {});
                                  },   style: ButtonStyle(
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(222.0),
                                          side: BorderSide(color:  colors.contains(snapshot.data!.colors![index].slug!)   ? Colors.black : Colors.grey)
                                      ),
                                    ),
                                    backgroundColor:MaterialStateProperty.all<Color>(/*category.contains(snapshot.data![index].slug) ? Colors.black:*/ Colors.white),
                                    padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.only(left: 15,right: 15)),
                                  ),

                                    child: Row(mainAxisAlignment:MainAxisAlignment.center,children: [
                                      Checkbox(value: colors.contains(snapshot.data!.colors![index].slug!) ?? false, onChanged: null),
                                      Text(snapshot.data!.colors![index].name!,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black)),
                                    ],),
                                  ),
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      const Text('Brand', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                      const SizedBox(height: 10,),
                      SizedBox(
                        height: 40,
                        child: FutureBuilder<BrandModel>(
                          future: BrandService().getAllBrands(),
                          builder: (context, snapshot) => ListView.builder(shrinkWrap: true,scrollDirection: Axis.horizontal,itemCount: snapshot.data?.brands?.length ?? 0,
                            itemBuilder: (context, index) =>
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                  child: TextButton(onPressed: (){
                                    if(!brand.contains(snapshot.data?.brands?[index].slug)){
                                      brand.add(snapshot.data!.brands![index].slug!);
                                    }else {
                                      brand.remove(snapshot.data!.brands![index].slug);
                                    }
                                    setState(() {});
                                  },   style: ButtonStyle(
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(222.0),
                                          side: BorderSide(color:  brand.contains(snapshot.data!.brands![index].slug!)   ? Colors.black : Colors.grey)
                                      ),
                                    ),
                                    backgroundColor:MaterialStateProperty.all<Color>(/*category.contains(snapshot.data![index].slug) ? Colors.black:*/ Colors.white),
                                    padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.only(left: 15,right: 15)),
                                  ),

                                    child: Row(mainAxisAlignment:MainAxisAlignment.center,children: [
                                      Checkbox(value: brand.contains(snapshot.data!.brands![index].slug!) ?? false, onChanged: null),
                                      Text(snapshot.data!.brands![index].name!,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black)),
                                    ],),
                                  ),
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Price Range', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('\$ ${selectedRange.start.toStringAsFixed(2)}', style: TextStyle(color: Colors.grey.shade500, fontSize: 12),),
                              Text(" - ", style: TextStyle(color: Colors.grey.shade500)),
                              Text('\$ ${selectedRange.end.toStringAsFixed(2)}', style: TextStyle(color: Colors.grey.shade500, fontSize: 12),),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      RangeSlider(
                          values: selectedRange,
                          min: 0.00,
                          max: 2000.00,
                          divisions: 100,
                          inactiveColor: Colors.grey.shade300,
                          activeColor: Colors.red,
                          labels: RangeLabels('\$ ${selectedRange.start.toStringAsFixed(2)}', '\$ ${selectedRange.end.toStringAsFixed(2)}',),
                          onChanged: (RangeValues values) {
                            setState(() => selectedRange = values);
                          }
                      ),
                      const SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: button("Filter", (){
                          setState(() {
                            filterBrand = filterCategory = filterColors = [];
                            filterBrand = [...brand];
                            filterCategory = [...category];
                            filterColors = [...colors];
                            _formKey.currentState!.pagingController.refresh();
                          });
                          Navigator.pop(context);
                        }),
                      )
                    ],
                  ),
                ),
              );
            }
        );
      },
    );
  }
  button(String text, Function onPressed) {
    return MaterialButton(
      onPressed: () => onPressed(),
      height: 50,
      elevation: 0,
      splashColor: Colors.yellow[700],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      color: Colors.black,
      child: Center(
        child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 18),),
      ),
    );
  }
}