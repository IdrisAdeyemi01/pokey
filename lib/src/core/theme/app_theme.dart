import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/constants.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = _themeData(_lightColorScheme);

  /// The app was designed in a light theme mode so, there's no dark theme data
  /// for now
  // static final _darkTheme = ThemeData();

  static _themeData(ColorScheme colorScheme) => ThemeData(
      textTheme: _textTheme(colorScheme),
      colorScheme: colorScheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(160, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36),
          ),
        ),
      ),
      tabBarTheme: const TabBarTheme());

  static final ColorScheme _lightColorScheme =
      const ColorScheme.light().copyWith(
    primary: AppColors.primary,
    onPrimary: AppColors.white,
    onSurface: AppColors.darkPurple,
  );

  static TextTheme _textTheme(ColorScheme colorScheme) => TextTheme(
        headlineLarge: GoogleFonts.notoSans(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: colorScheme.onPrimary,
        ),
        headlineMedium: GoogleFonts.notoSans(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: colorScheme.onSurface,
        ),
        headlineSmall: GoogleFonts.notoSans(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: colorScheme.onSurface,
        ),
        bodyLarge: GoogleFonts.notoSans(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.dark,
        ),
        bodyMedium: GoogleFonts.notoSans(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.dark,
        ),
        titleMedium: GoogleFonts.notoSans(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.darkGrey,
        ),
        labelLarge: GoogleFonts.notoSans(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: colorScheme.onPrimary,
        ),
      );
}
