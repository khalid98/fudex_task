import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fudex_task/core/helpers/spacing.dart';
import 'package:fudex_task/core/theme/app_colors.dart';
import 'package:fudex_task/core/theme/app_text_style.dart';
import 'package:fudex_task/core/utils/assets.dart';

class CustomDropDown extends StatelessWidget {
  String? title;
  String? selectedValue;
  ValueChanged<String?>? onchange;
  FormFieldValidator<String>? vaildator;
  List<DropdownMenuItem<String>> dropDownMenuItem;
  TextStyle? textStyle;
  Color? fillColor;
  String? hint;
  bool? isRequired;
  bool? showIcon;
  Function(String?)? onsave;
  Widget? suffix;

  CustomDropDown(
      {super.key,
      this.suffix,
      this.onsave,
      this.showIcon = false,
      this.isRequired = false,
      this.fillColor,
      this.hint,
      this.textStyle,
      this.title,
      this.selectedValue,
      this.onchange,
      required this.dropDownMenuItem,
      this.vaildator});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Wrap(
            children: [
              Text("$title",
                  style: textStyle ??
                      AppTextStyle.font16BlackRegularTajawal),
              Visibility(
                  visible: isRequired == true,
                  child: Text(
                    "*",
                    style: TextStyle(fontSize: 16.sp, color: Colors.red),
                  ))
            ],
          ),
          horizontalSpace(10),
        ],
        DropdownButtonFormField2<String>(
          hint: Text(hint ?? title ?? '',style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
          ),),
          value: selectedValue,
          isExpanded: true,
          decoration: InputDecoration(
            hintText: hint ?? title,
            isDense: true,
            fillColor: fillColor ?? Colors.transparent,
            filled: true,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 10, vertical: 11.h),
            focusColor: Colors.white,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(
                  color: AppColors.borderColor,
                )),

            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(
                  color: AppColors.borderColor,
                )),

            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(
                  color: AppColors.borderColor,
                )),
            // Add more decoration..
          ),
          items: dropDownMenuItem,
          validator: vaildator,
          onChanged: onchange,
          onSaved: onsave,
          iconStyleData: IconStyleData(
            icon: suffix ?? SvgPicture.asset(Assets.iconsArrowDown),
            iconSize: 10,
          ),
          buttonStyleData:  const ButtonStyleData(
            padding: EdgeInsets.symmetric(horizontal: 0),
          ),
          dropdownStyleData: DropdownStyleData(
            padding: EdgeInsets.symmetric(horizontal: 10.w,),
            decoration: BoxDecoration(
              color: fillColor ?? AppColors.textFieldFilledColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          menuItemStyleData:  MenuItemStyleData(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            overlayColor: MaterialStateProperty.all(Colors.grey),

          ),
        ),
      ],
    );
  }
}
