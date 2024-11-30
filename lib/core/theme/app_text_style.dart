import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudex_task/core/theme/app_colors.dart';
import 'package:fudex_task/core/utils/app_constants.dart';

class AppTextStyle {
  static TextStyle font18BlackRegularCairo = TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w400,
      fontFamily: AppConstants.cairoFont,
      color: AppColors.primaryBlack);

  static TextStyle font13BlackRegularTajawal = TextStyle(
      fontSize: 13.sp,
      fontWeight: FontWeight.w400,
      fontFamily: AppConstants.tajawalFont,
      color: AppColors.primaryBlack);

  static TextStyle font16BlackRegularTajawal = TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      fontFamily: AppConstants.tajawalFont,
      color: AppColors.primaryBlack);

  static TextStyle font13TextRegularTajawal = TextStyle(
      fontSize: 13.sp,
      fontWeight: FontWeight.w400,
      fontFamily: AppConstants.tajawalFont,
      color: AppColors.textColor);
  static TextStyle font14BlueBoldTajawal = TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      fontFamily: AppConstants.tajawalFont,
      color: AppColors.textBlueColor);
  static TextStyle font10BlueBoldTajawal = TextStyle(
      fontSize: 10.sp,
      fontWeight: FontWeight.w400,
      fontFamily: AppConstants.tajawalFont,
      color: AppColors.textBlueColor);
  static TextStyle font10GreyMediumTajawal = TextStyle(
      fontSize: 10.sp,
      fontWeight: FontWeight.w500,
      fontFamily: AppConstants.tajawalFont,
      height: 0,
      color: AppColors.textGreyColor);
  static TextStyle font16ButtonTajawal = TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      fontFamily: AppConstants.tajawalFont,
      color: AppColors.primaryWhite);
}
