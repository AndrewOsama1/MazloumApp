import 'package:flutter/material.dart';
import 'package:mazloum_app/models/product_model.dart';
import 'package:mazloum_app/services/search_service.dart';

import '../constants.dart';

class SearchDemoSearchDelegate extends SearchDelegate {


  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if(query.isNotEmpty) {
      return FutureBuilder<List<ProductModel>>(
        future: SearchService().getSearch(query),
          builder: (context, snapshot) { if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
            final products = snapshot.data!;
          return ListView.builder(itemCount:products.length ,itemBuilder: (context, index) => ListTile(title: Text(products[index].name!,style: const TextStyle(fontSize: 12,overflow: TextOverflow.ellipsis),),
            subtitle: Text(products[index].price!.toString(),style: const TextStyle(fontSize: 10,overflow: TextOverflow.ellipsis,color: Colors.red,fontWeight: FontWeight.w600),),
            leading: SizedBox(height: 80, width: 80, child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                child:products[index].images != null ?  Image.network("${Constants.imgURL}${products[index].images}", fit: BoxFit.cover): const SizedBox.shrink()) ),));}else {
            return const Center(child: CircularProgressIndicator());
          }});
    }
    return const SizedBox.shrink();
  }

  @override
  Widget buildResults(BuildContext context) {
    if(query.isNotEmpty) showSuggestions(context);
  return  const SizedBox.shrink();
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      if (query.isEmpty)
        IconButton(
          tooltip: 'Voice Search',
          icon: const Icon(Icons.mic),
          onPressed: () {
            query = 'TODO: implement voice input';
          },
        )
      else
        IconButton(
          tooltip: 'Clear',
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        ),
    ];
  }
}