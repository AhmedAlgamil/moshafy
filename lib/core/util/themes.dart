import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class AppThemes {
  static final darkMode = ThemeData(
    primaryColor: AppColors.kPrimaryColor,
    scaffoldBackgroundColor: AppColors.kPrimaryColor,
    primaryColorDark: AppColors.white,
    primaryColorLight: AppColors.kPrimaryColor,
    textTheme: TextTheme(
      titleSmall: TextStyle(
        color: AppColors.white,
        fontSize: 10.sp,
      ),
      titleMedium: TextStyle(
        color: AppColors.white,
        fontSize: 15.sp,
      ),
      titleLarge: TextStyle(
        color: AppColors.white,
        fontSize: 20.sp,
      ),
    ),
  );

  static final lightMode = ThemeData(
    primaryColor: AppColors.kPrimaryColor,
    scaffoldBackgroundColor: AppColors.white,
    primaryColorDark: AppColors.kPrimaryColor,
    primaryColorLight: AppColors.white,
    buttonTheme: const ButtonThemeData(buttonColor: AppColors.kPrimaryColor),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.white,
      elevation: 0,
    ),
    textTheme: TextTheme(
      bodySmall: TextStyle(
        color: AppColors.kPrimaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 15.sp,
      ),
      bodyLarge: TextStyle(
        color: AppColors.kPrimaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 25.sp,
      ),
      bodyMedium: TextStyle(
        color: AppColors.kPrimaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 20.sp,
      ),
      titleSmall: TextStyle(
        color: AppColors.kPrimaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 10.sp,
      ),
      titleMedium: TextStyle(
        color: AppColors.kPrimaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 15.sp,
      ),
      titleLarge: TextStyle(
        color: AppColors.kPrimaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 20.sp,
      ),
    ),
  );
}
