import 'package:flutter/material.dart';

class ThemeSettings {
  
  static ThemeData lightTheme(){
    final theme =ThemeData.light().copyWith(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Colors.red, 
          onPrimary: Colors.amber, 
          secondary: Colors.amber, 
          onSecondary: Colors.amber, 
          error: Colors.redAccent, 
          onError: Colors.redAccent, 
          surface: Colors.black, 
          onSurface: Colors.amber,
        )
    );

    return theme;

  }

  static ThemeData darkTheme(){
    final theme =ThemeData.dark().copyWith(

    );

    return theme;

  }


}