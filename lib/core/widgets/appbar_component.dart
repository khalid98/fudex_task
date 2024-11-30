import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudex_task/core/theme/app_colors.dart';
import 'package:fudex_task/core/theme/app_text_style.dart';
import 'package:fudex_task/core/utils/app_constants.dart';

class AppbarComponent extends StatelessWidget implements PreferredSizeWidget {
  String title;
  bool showLeading;

  AppbarComponent({super.key, required this.title, this.showLeading = true});

  @override
  Size get preferredSize => Size.fromHeight(65.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
      ),
      centerTitle: true,
      leadingWidth: 90.w,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: showLeading,
      backgroundColor: AppColors.primaryWhite,
      titleTextStyle: AppTextStyle.font18BlackRegularCairo,
    );
  }
}
