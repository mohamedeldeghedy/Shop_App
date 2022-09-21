import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lightMode = ThemeData(
  fontFamily: 'Jannah',

  primarySwatch: Colors.orange,
  textTheme: const TextTheme(

      bodyText1: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black
      ),
    subtitle1: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      height: 1.3,
    )

  ),


  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: Colors.blue[800]),
  appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.black),
      elevation: 1,
      titleTextStyle: TextStyle(
        fontFamily: 'Jannah',
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
      backgroundColor: Colors.white),
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.orangeAccent,
  ),
  // floatingActionButtonTheme: ,
);
ThemeData darkMode = ThemeData(
  fontFamily: 'Jannah',
  primarySwatch: Colors.orange,
  textTheme: const TextTheme(
      bodyText1: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
  subtitle1: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    height: 1.3
  )),

  scaffoldBackgroundColor: HexColor('333739'),

  appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('333739'),
          statusBarIconBrightness: Brightness.light),
      backgroundColor: HexColor('333739')),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: HexColor('333739'),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.orangeAccent,
      unselectedItemColor: Colors.grey),
  // floatingActionButtonTheme: ,
);
