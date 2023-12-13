import 'package:flutter/material.dart';
import 'package:mazloum_app/screens/custom_search_delegate.dart';
import 'package:mazloum_app/screens/filter_screen.dart';
import 'package:mazloum_app/screens/login_screen.dart';

class MazloumAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool hasBack;
  final bool? isDetailed;
  const MazloumAppBar({Key? key, required this.title, this.hasBack = true,  this.isDetailed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(actions: isDetailed == null ? [IconButton(onPressed: (){
      showSearch(context: context, delegate: SearchDemoSearchDelegate());
    }, icon: const Icon(Icons.search,color: Colors.white)),
      IconButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => const FilterScreen()));
      }, icon: const Icon(Icons.filter_list,color: Colors.white)),
    ] : [],title: Row(
      children: [
        SizedBox(height:50,width: 50,child: Image.asset("images/logo.png")),
        const SizedBox(width: 10),
        Flexible(child: Text(title,style: const TextStyle(fontSize: 12))),
      ],
    ),backgroundColor: Colors.black,leading:  hasBack ? IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.white,), onPressed: () { Navigator.pop(context); },) : SizedBox.shrink(),);
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);

}