import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudex_task/core/helpers/spacing.dart';
import 'package:fudex_task/core/theme/app_colors.dart';

class LabeledRadio extends StatelessWidget {
  const LabeledRadio(
      {required this.padding,
      required this.groupValue,
      required this.value,
      required this.onChanged,
      required this.widget});

  final Widget widget;
  final EdgeInsets padding;
  final int groupValue;
  final int value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) onChanged(value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 24.w,
              child: Radio<int>(
                groupValue: groupValue,
                value: value,
                onChanged: (int? newValue) {
                  onChanged(newValue);
                },
                activeColor: AppColors.primaryBlue,
              ),
            ),
            horizontalSpace(8),
            widget
          ],
        ),
      ),
    );
  }
}
