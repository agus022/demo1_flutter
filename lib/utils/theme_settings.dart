import 'package:flutter/material.dart';

class ThemeSettings {
  
  static ThemeData lightTheme(){
    final theme =ThemeData.light().copyWith(
    );

    return theme;

  }

  static ThemeData darkTheme(){
    final theme =ThemeData.dark().copyWith(

    );
    return theme;

  }

  static ThemeData gameTheme(){
    final theme =ThemeData.dark().copyWith(

    );
    return theme;
  }


}