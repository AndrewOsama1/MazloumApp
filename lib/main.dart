import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mazloum_app/provider/cart_provider.dart';
import 'package:mazloum_app/provider/login_provider.dart';
import 'package:mazloum_app/screens/tab_bar_screen.dart';
import 'package:mazloum_app/themes.dart';
import 'package:provider/provider.dart';

import 'injections.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Injections().setupDependencyInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<CartProvider>(create: (_) => GetIt.instance<CartProvider>()),
          ChangeNotifierProvider<LoginProvider>(create: (_) => GetIt.instance<LoginProvider>()),
        ],
        builder: (context, providerChild) {
          return MaterialApp(
            title: 'Flutter Demo',
            darkTheme: Themes.darkTheme,
            themeMode: ThemeMode.light,
            theme: Themes.lightTheme,
            home: const TabBarScreen(),
          );
        }
    );
  }
}

