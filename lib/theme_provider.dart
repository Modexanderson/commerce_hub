import 'package:commerce_hub/constants.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

// Creating the theme mode
class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.grey.shade900,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: kPrimaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
        focusColor: kPrimaryColor,
        labelStyle: TextStyle(color: kPrimaryColor),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
        )),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: kPrimaryColor),
    appBarTheme: AppBarTheme(
      color: kPrimaryColor,
    ),
    iconTheme: IconThemeData(color: Colors.white),
    colorScheme: ColorScheme.dark(),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: kPrimaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
        focusColor: kPrimaryColor,
        labelStyle: TextStyle(color: kPrimaryColor),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
        )),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: kPrimaryColor),
    appBarTheme: AppBarTheme(
      color: kPrimaryColor,
    ),
    iconTheme: IconThemeData(
      color: Colors.grey,
    ),
    colorScheme: ColorScheme.light(),
  );
}
