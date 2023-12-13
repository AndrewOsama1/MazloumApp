import 'package:flutter/material.dart';

class Themes {
  static const MaterialColor primaryBlack = MaterialColor(
    _blackPrimaryValue,
    <int, Color>{
      50: Color(0xFF000000),
      100: Color(0xFF000000),
      200: Color(0xFF000000),
      300: Color(0xFF000000),
      400: Color(0xFF000000),
      500: Color(_blackPrimaryValue),
      600: Color(0xFF000000),
      700: Color(0xFF000000),
      800: Color(0xFF000000),
      900: Color(0xFF000000),
    },
  );
  static const int _blackPrimaryValue = 0xFF000000;
  static const MaterialColor primaryWhite = MaterialColor(
    _blackWhiteValue,
    <int, Color>{
      50: Color(0xFFFFFFFF),
      100: Color(0xFFFFFFFF),
      200: Color(0xFFFFFFFF),
      300: Color(0xFFFFFFFF),
      400: Color(0xFFFFFFFF),
      500: Color(0xFFFFFFFF),
      600: Color(0xFFFFFFFF),
      700: Color(0xFFFFFFFF),
      800: Color(0xFFFFFFFF),
      900: Color(0xFFFFFFFF),
    },
  );
  static const int _blackWhiteValue = 0xFFFFFFFF;
  static ThemeData lightTheme = ThemeData(
      primarySwatch: primaryBlack,
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
          titleTextStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600
          ),
          iconTheme: const IconThemeData(
              color: Colors.white
          ),
          backgroundColor: Colors.grey.shade50,
          elevation: 0
      ),
      inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10)
          ),
          hintStyle: const TextStyle(
            fontSize: 14,
          )
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Colors.red
      ),
      textTheme: TextTheme(
          headline1: const TextStyle(
              letterSpacing: -1.5,
              fontSize: 48,
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),
          headline2: const TextStyle(
              letterSpacing: -1.0,
              fontSize: 40,
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),
          headline3: TextStyle(
              letterSpacing: -1.0,
              fontSize: 32,
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),
          headline4: TextStyle(
              letterSpacing: -1.0,
              color: Colors.black,
              fontSize: 28,
              fontWeight: FontWeight.w600
          ),
          headline5: TextStyle(
              letterSpacing: -1.0,
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w500
          ),
          headline6: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500
          ),
          subtitle1: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500
          ),
          subtitle2: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500
          ),
          bodyText1: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 16,
              fontWeight: FontWeight.w400
          ),
          bodyText2: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
              fontWeight: FontWeight.w400
          ),
          button: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600
          ),
          caption: TextStyle(
              color: Colors.grey.shade800,
              fontSize: 12,
              fontWeight: FontWeight.w400
          ),
          overline: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 10,
              fontWeight: FontWeight.w400,
              letterSpacing: -0.5
          )
      )
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: primaryWhite,
    primarySwatch: primaryWhite,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black87,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.grey,
      elevation: 0,
      iconTheme: IconThemeData(
          color: Colors.white
      ),
    ),
    bottomAppBarColor: Colors.grey,
    inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10)
        ),
        hintStyle: const TextStyle(
          fontSize: 14,
        )
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Colors.white
    ),
    textTheme: TextTheme(
        headline1: TextStyle(
            letterSpacing: -1.5,
            fontSize: 48,
            color: Colors.grey.shade50,
            fontWeight: FontWeight.bold
        ),
        headline2: TextStyle(
            letterSpacing: -1.0,
            fontSize: 40,
            color: Colors.grey.shade50,
            fontWeight: FontWeight.bold
        ),
        headline3: TextStyle(
            letterSpacing: -1.0,
            fontSize: 32,
            color: Colors.grey.shade50,
            fontWeight: FontWeight.bold
        ),
        headline4: TextStyle(
            letterSpacing: -1.0,
            color: Colors.grey.shade50,
            fontSize: 28,
            fontWeight: FontWeight.w600
        ),
        headline5: TextStyle(
            letterSpacing: -1.0,
            color: Colors.grey.shade50,
            fontSize: 24,
            fontWeight: FontWeight.w500
        ),
        headline6: TextStyle(
            color: Colors.grey.shade50,
            fontSize: 18,
            fontWeight: FontWeight.w500
        ),
        subtitle1: TextStyle(
            color: Colors.grey.shade50,
            fontSize: 16,
            fontWeight: FontWeight.w500
        ),
        subtitle2: TextStyle(
            color: Colors.grey.shade50,
            fontSize: 14,
            fontWeight: FontWeight.w500
        ),
        bodyText1: TextStyle(
            color: Colors.grey.shade50,
            fontSize: 16,
            fontWeight: FontWeight.w400
        ),
        bodyText2: TextStyle(
            color: Colors.grey.shade50,
            fontSize: 14,
            fontWeight: FontWeight.w400
        ),
        button: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600
        ),
        caption: TextStyle(
            color: Colors.grey.shade50,
            fontSize: 12,
            fontWeight: FontWeight.w500
        ),
        overline: TextStyle(
            color: Colors.grey.shade50,
            fontSize: 10,
            fontWeight: FontWeight.w400
        )
    ),
  );
}