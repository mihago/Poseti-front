import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    //1
    return ThemeData(
      //2
      textTheme: TextTheme(
          headline1: TextStyle(fontFamily: 'Roboto',
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600),
        headline2: TextStyle(fontFamily:'Roboto',
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
      ),

      primaryColor: Color(0xFFF06B20),
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Roboto', //3
    );
  }
}
