import 'package:flutter/material.dart';
import 'package:fudex_task/core/theme/app_colors.dart';

class AppTheme {
  static get primaryTheme => ThemeData(
        iconTheme: const IconThemeData(color: AppColors.primaryBlack),
        cardColor: AppColors.primaryWhite,
        cardTheme: CardTheme(
          elevation: 0,
          color: AppColors.primaryWhite,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        splashColor: Colors.transparent,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.w400,
            height: 0
          ),
        ),
        highlightColor: Colors.transparent,
        fontFamily: 'Tajawal',
        scaffoldBackgroundColor: AppColors.backgroundBasic,
      );
}
