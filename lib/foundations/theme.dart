import 'package:flutter/material.dart';

class ThemeForm {
  static ThemeData getTheme(BuildContext context) {
    return ThemeData(
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color.fromARGB(255, 141, 141, 141),
        onPrimary: Colors.orangeAccent,
        secondary: Colors.orange,
        onSecondary: Colors.orangeAccent,
        error: Colors.red,
        onError: Colors.redAccent,
        background: Colors.yellow,
        onBackground: Colors.yellowAccent,
        surface: Colors.green,
        onSurface: Colors.black,
      ),
      primarySwatch: Colors.orange,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(
              Size(MediaQuery.of(context).size.width, 48)),
          elevation: MaterialStateProperty.all(5),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding:
            const EdgeInsets.only(top: 1, bottom: 1, left: 10, right: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.orange, width: 1.5),
          borderRadius: BorderRadius.circular(5),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black26, width: 1.5),
          borderRadius: BorderRadius.circular(5),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          backgroundColor: Colors.orange[400],
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          elevation: 4,
        ),
      ),
      textTheme: const TextTheme(
        // bodyText1: TextStyle(color: Colors.black, fontSize: 20),
      ),
      useMaterial3: false,
    );
  }
}
