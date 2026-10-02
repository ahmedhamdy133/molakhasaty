import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.mainBackground,

    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryBlue,
      secondary: AppColors.cyanGlow,
      surface: AppColors.secondaryBackground,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.mainBackground,
      elevation: 0,
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: AppColors.white,
      ),
      bodyMedium: TextStyle(
        color: AppColors.secondaryText,
      ),
    ),
  );
}