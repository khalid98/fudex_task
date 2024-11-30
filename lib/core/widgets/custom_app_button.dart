import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudex_task/core/theme/app_text_style.dart';

import '../theme/app_colors.dart';

class CustomAppButton extends StatelessWidget {
  final void Function() onPressed;
  final String title;

  const CustomAppButton(
      {super.key, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 50.h),
        backgroundColor: AppColors.primaryBlue,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 0,
      ),
      child: Text(
        title,
        style: AppTextStyle.font16ButtonTajawal
      ),
    );
  }
}
