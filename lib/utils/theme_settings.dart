import 'package:flutter/material.dart';

class ThemeSettings {
  
 static ThemeData lightTheme() {
    return ThemeData.light().copyWith(
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: Colors.black, fontFamily: 'Ligh Theme Font'),
        bodyMedium: TextStyle(color: Colors.black, fontFamily:'Ligh Theme Font' ),
        bodySmall: TextStyle(color: Colors.black, fontFamily:'Ligh Theme Font' )
      )

    );
  }

  static ThemeData darkTheme() {
    return ThemeData.dark().copyWith(
      primaryColor: Colors.black,
      scaffoldBackgroundColor: Colors.grey[900],
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: Colors.white, fontFamily: 'Dark Theme Font'),
        bodyMedium: TextStyle(color: Colors.white, fontFamily:'Dark Theme Font' ),
        bodySmall: TextStyle(color: Colors.white, fontFamily:'Dark Theme Font' ) 
      )
    );
  }

  static ThemeData gameTheme(){
    return ThemeData.dark().copyWith(
      // Color de fondo principal (Negro Xbox)
      scaffoldBackgroundColor: Color(0xFF1A1A1A),
      
      // Color del AppBar (Oscuro pero no negro total)
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFF107C10),
        elevation: 4,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: Colors.white),
        shadowColor: Colors.greenAccent.withOpacity(0.5),
        

      ),

      // Botones Elevados (Verde Xbox con efecto neon)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF107C10),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          shadowColor: Colors.greenAccent.withOpacity(0.5),
          elevation: 8,
        ),
      ),

      // Botones Flotantes (Verde con sombra)
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF107C10),
        foregroundColor: Colors.white,
        elevation: 6,
      ),

      // Estilo de los Input Fields (Cajas de Texto)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Color(0xFF2D2D2D),
        border: OutlineInputBorder(
          
          borderSide: BorderSide(color: Color(0xFF107C10)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Color(0xFF42D742), width: 2),
        ),
        hintStyle: TextStyle(color: Colors.grey.shade400),
        labelStyle: TextStyle(color: Colors.white),
      ),

      // SnackBars (Mensajes flotantes)
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Color(0xFF333333),
        contentTextStyle: TextStyle(color: Colors.white),
        actionTextColor: Color(0xFF107C10),
      ),

      // Tema de Iconos
      iconTheme: IconThemeData(
        color: Color(0xFF107C10),
        size: 24,
      ),

      // Estilo de Texto General
      textTheme: TextTheme(
        bodyLarge: TextStyle(
          
          color: Colors.white70,
          fontFamily: 'Game Theme Font'
        ),
        bodyMedium: TextStyle(
          
          color: Colors.white70,
          fontFamily: 'Game Theme Font'
        ),
        bodySmall: TextStyle(
          
          color: Colors.white70,
          fontFamily: 'Game Theme Font'
        )
      ),
    );
  }
}