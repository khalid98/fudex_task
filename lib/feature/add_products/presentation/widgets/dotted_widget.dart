import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudex_task/core/theme/app_colors.dart';

class DottedWidget extends StatelessWidget {
  Widget child;
  double height;
  double width;

  DottedWidget(
      {super.key,
      required this.child,
      this.height = 200,
      this.width = double.infinity});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      color: AppColors.dottedBorder,
      radius: Radius.circular(9.r),
      padding:  const EdgeInsets.all(6),
      strokeWidth: 2.w,
      dashPattern:  [15, 4],
      child: ClipRRect(
        borderRadius:  BorderRadius.all(Radius.circular(12.r)),
        child: child
      ),
    );
  }
}
