


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/utils/app_colors.dart';

import '../utils/app_fonts.dart';

ThemeData getTheme(context){
  return ThemeData(


    useMaterial3: true,

    primaryColor: AppColors.hcl,

    splashColor: Colors.transparent,

    inputDecorationTheme: InputDecorationTheme(
      
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0), 
      
      ), 
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),  
      ), 
      
      hintStyle: GoogleFonts.lato(
        color: AppColors.white,
        fontSize: FontSize.s16,
        fontWeight: FontWeight.w400
      ),

      
      
      fillColor: AppColors.lightBlack,
      filled: true, 
    )
  );
}