
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mazloum_app/screens/cart_screen.dart';
import 'package:mazloum_app/screens/credit_card_screen.dart';
import 'package:mazloum_app/screens/filter_screen.dart';
import 'package:mazloum_app/screens/home_screen.dart';
import 'package:mazloum_app/screens/profile_screen.dart';
import 'package:mazloum_app/widgets/mazloum_app_bar.dart';
import 'package:provider/provider.dart';

import '../provider/login_provider.dart';
import 'login_screen.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({Key? key}) : super(key: key);

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  int _selectedIndex =0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    List<Widget> _widgetOptions = <Widget>[
   HomeScreen(),
    CartScreen(),
      ProfileScreen(),
  ];
    List<IconData> _iconData = [Icons.home,Icons.shopping_bag,Icons.person];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const MazloumAppBar(title: '',hasBack: false,),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: AnimatedBottomNavigationBar(
          icons: _iconData,
          activeIndex: _selectedIndex,
          gapLocation: GapLocation.none,
          activeColor: Colors.black,
          inactiveColor: Colors.grey,
          notchSmoothness: NotchSmoothness.verySmoothEdge,

          elevation: 0,
          onTap: (index) => setState(() => _selectedIndex = index),
          //other params
        ),

      ),
    );
  }
}