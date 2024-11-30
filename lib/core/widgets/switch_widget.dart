import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter/material.dart';
import 'package:fudex_task/core/theme/app_colors.dart';

class AdaptiveSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color? activeColor;
  final Color? trackColor;

  const AdaptiveSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.trackColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.8,
      child: Switch.adaptive(
        value: value,
        onChanged: onChanged,
        activeColor: activeColor,
        trackOutlineColor:
            WidgetStateProperty.resolveWith((states) => Colors.transparent),
        thumbColor: WidgetStateProperty.resolveWith(
            (states) => value ? activeColor : Colors.white),
        activeTrackColor: trackColor,
        trackColor: WidgetStateProperty.resolveWith(
            (states) => value ? AppColors.primaryBlue : Colors.grey),
      ),
    );
  }
}
