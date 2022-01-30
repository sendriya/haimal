import 'package:flutter/material.dart';
import 'package:haimal/constants/app_defaults.dart';

import 'constants.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Muli",
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

InputDecorationTheme inputDecorationTheme() {
  // OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  //   borderRadius: BorderRadius.circular(28),
  //   borderSide: BorderSide(color: kTextColor),
  //   gapPadding: 10,
  // );
  return InputDecorationTheme(
    filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: AppDefaults.borderRadius,
          borderSide: BorderSide.none,
        ),
        // enabledBorder: defaultOutlineInputBorder,
        // focusedBorder: defaultOutlineInputBorder,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        errorStyle: TextStyle(fontSize: 9, height: 0),
        errorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
  );
}

TextTheme textTheme() {
  return TextTheme(
    bodyText1: TextStyle(color: kTextColor),
    bodyText2: TextStyle(color: kTextColor),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: Colors.white,
    elevation: 0,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.black),
    textTheme: TextTheme(
      headline6: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
    ),
  );
}
