import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudex_task/core/helpers/spacing.dart';
import 'package:fudex_task/core/theme/app_colors.dart';
import 'package:fudex_task/core/theme/app_text_style.dart';

class CustomTextField extends StatelessWidget {
  String? title;
  TextStyle? textStyle;
  String? hint;
  TextAlign textAlign;
  String? Function(String?)? validator;
  Function(String?)? onSave;
  Function(String?)? onSubmit;
  Function(String?)? onchange;
  bool? obscure;
  Widget? suffix;
  Widget? prefix;
  double radius;
  bool? isRequired;
  Color? filedColor;
  TextInputType? keyboardType;
  TextEditingController? controller;
  int? maxLine;
  String? initialValue;
  OutlineInputBorder? outlineInputBorder;
  bool? enabled;
  Key? key;
  List<TextInputFormatter>? textInputFormatter;
  TextStyle? bodyStyle;
  TextStyle? hintStyle;
  FocusNode? inputNode;
  Widget? titleChild;
  Color? borderColor;
  bool autofocus;

  CustomTextField(
      {this.bodyStyle,
      this.outlineInputBorder,
      this.key,
      this.onSubmit,
      this.onchange,
      this.isRequired,
      this.radius = 8,
      this.filedColor = Colors.white,
      this.prefix,
      this.textStyle,
      this.textAlign = TextAlign.start,
      this.maxLine,
      this.title,
      this.titleChild,
      this.textInputFormatter,
      this.validator,
      this.onSave,
      this.obscure = false,
      this.enabled = true,
      this.autofocus = false,
      this.suffix,
      this.controller,
      this.hint,
      this.keyboardType,
      this.initialValue,
      this.hintStyle,
      this.borderColor,
      this.inputNode});

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
          verticalSpace(10),
        ],
        TextFormField(
          focusNode: inputNode,
          autofocus: autofocus,
          key: key,
          enabled: enabled,
          textAlign: textAlign,
          controller: controller,
          initialValue: initialValue,
          maxLines: maxLine ?? 1,
          minLines: maxLine ?? 1,
          obscureText: obscure!,
          style: bodyStyle,
          onChanged: onchange,
          inputFormatters: textInputFormatter,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onSaved: onSave,
          onFieldSubmitted: onSubmit,
          keyboardType: keyboardType ?? TextInputType.text,
          validator: validator,
          decoration: InputDecoration(
              prefixIcon: prefix,
              suffixIcon: suffix,
              prefixIconConstraints: BoxConstraints(
                  minWidth: prefix != null ? 40.sp : 0,
                  minHeight: prefix != null ? 40 : 0),
              suffixIconConstraints: BoxConstraints(
                  minWidth: suffix != null ? 40.sp : 0,
                  minHeight: suffix != null ? 40 : 0),
              fillColor: filedColor,
              filled: true,
              errorMaxLines: 2,
              hintStyle: hintStyle,
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius.r),
                borderSide:
                    BorderSide(color: borderColor ?? Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius.r),
                borderSide:
                    BorderSide(color: borderColor ?? AppColors.borderColor),
              ),
              focusedBorder: outlineInputBorder ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radius.r),
                    borderSide:
                        BorderSide(color: borderColor ?? AppColors.borderColor),
                  ),
              enabledBorder: outlineInputBorder ??
                  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(radius.r),
                      borderSide: BorderSide(
                        color: borderColor ?? AppColors.borderColor,
                      )),
              border: outlineInputBorder ??
                  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(radius.r),
                      borderSide:  BorderSide(
                          color: borderColor ?? AppColors.borderColor)),
              hintText: hint,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 13, vertical: 13.h),
              isDense: true),
        ),
      ],
    );
  }
}
