import 'package:flutter/material.dart';

class JisKongTheme {
  // Define the core palette
  static const Color primaryOrange = Color(0xFFFF8C00); // Main Buttons & Brand
  static const Color successGreen = Color(
    0xFF22C55E,
  ); // Active Status & Success
  static const Color batteryBlue = Color(0xFF3B82F6); // Battery Level only
  static const Color backgroundWhite = Color(0xFFF9F9F9);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryOrange,
        primary: primaryOrange,
        secondary: successGreen,
        tertiary: batteryBlue,
        surface: backgroundWhite,
      ),

      // Card Style (Used in your Pass Selection screen)
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.white,
      ),

      // Button Style (The Orange "Select Pass" / "Pay Now" buttons)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryOrange,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),

      // AppBar Style
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundWhite,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
    );
  }
}
