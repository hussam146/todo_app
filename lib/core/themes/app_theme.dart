import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/utils/app_colors.dart';

import '../utils/app_fonts.dart';

ThemeData getDarkTheme(context) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppColors.black,
    statusBarIconBrightness: Brightness.light,
  ));
  return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.dark(
          background: AppColors.black, primary: AppColors.white),
      primaryColor: AppColors.hcl,
      splashColor: Colors.transparent,
      datePickerTheme: DatePickerThemeData(
        shadowColor: AppColors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.black,
        elevation: 0.0,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppColors.white),
        titleTextStyle: TextStyle(color: AppColors.white),
        surfaceTintColor: AppColors.black,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.black,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        outlineBorder: BorderSide(color: AppColors.white),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        hintStyle: GoogleFonts.lato(
            color: AppColors.white,
            fontSize: FontSize.s16,
            fontWeight: FontWeight.w400),
        fillColor: AppColors.lightBlack,
        filled: true,
      ));
}

ThemeData getLightTheme(context) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppColors.white,
    statusBarIconBrightness: Brightness.dark,
  ));
  return ThemeData(
      colorScheme: ColorScheme.light(
          background: AppColors.white, primary: AppColors.black),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.white,
        elevation: 0.0,
        centerTitle: false,
        foregroundColor: AppColors.white,
        iconTheme: IconThemeData(color: AppColors.black),
        titleTextStyle: TextStyle(color: AppColors.black),
        surfaceTintColor: AppColors.white,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      useMaterial3: true,
      primaryColor: AppColors.black,
      splashColor: Colors.transparent,
      datePickerTheme: DatePickerThemeData(
        shadowColor: AppColors.offBlue,
      ),
      inputDecorationTheme: InputDecorationTheme(
        suffixIconColor: AppColors.black,
        labelStyle: TextStyle(color: AppColors.black),
        outlineBorder: BorderSide(color: AppColors.black),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        hintStyle: GoogleFonts.lato(
            color: AppColors.black,
            fontSize: FontSize.s16,
            fontWeight: FontWeight.w400),
        fillColor: AppColors.white,
        filled: true,
      ));
}
