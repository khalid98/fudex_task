import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fudex_task/core/helpers/spacing.dart';
import 'package:fudex_task/core/theme/app_colors.dart';
import 'package:fudex_task/core/theme/app_text_style.dart';
import 'package:fudex_task/core/utils/assets.dart';

class DropDownModel {
  String label;

  String value;

  DropDownModel({required this.label, required this.value});
}

class DropDownMultiSelection extends StatefulWidget {
  String? title;
  ValueSetter? onchange;
  Function(String) vaildator;
  List<DropDownModel>? dropdownmenuitem;
  Function(List<DropDownModel>) onChange;
  List<DropDownModel> selectedItems = [];
  bool? isEnable;
  TextStyle? textStyle;
  Color? fillColor;
  String? hint;
  bool? isRequired;
  bool? showicon;
  Function(String?)? onsave;
  Widget? sufix;

  DropDownMultiSelection(
      {this.title,
      required this.selectedItems,
      required this.onChange,
      required this.vaildator,
      this.dropdownmenuitem,
      this.textStyle,
      this.fillColor,
      this.hint,
      this.isRequired,
      this.isEnable,
      this.showicon,
      this.onsave,
      this.sufix});

  @override
  State<DropDownMultiSelection> createState() => _DropDownMultiSelectionState();
}

class _DropDownMultiSelectionState extends State<DropDownMultiSelection> {
  @override
  void didChangeDependencies() {
    widget.onChange(widget.selectedItems);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: widget.title != null,
          child: Wrap(
            children: [
              Text("${widget.title}",
                  style: widget.textStyle ??
                      AppTextStyle.font16BlackRegularTajawal),
              Visibility(
                  visible: widget.isRequired == true,
                  child: Text(
                    "*",
                    style: TextStyle(fontSize: 16.sp, color: Colors.red),
                  )),
            ],
          ),
        ),
        Visibility(
          visible: widget.title != null,
          child: SizedBox(
            height: 10.0.h,
          ),
        ),
        IgnorePointer(
          ignoring: widget.isEnable ?? false,
          child: DropdownButtonFormField2(
            // isDense: true,,
            isExpanded: true,
            validator: (value) => widget.vaildator(value.toString()),
            iconStyleData: IconStyleData(
              icon: widget.sufix ?? SvgPicture.asset(Assets.iconsArrowDown),
            ),
            hint: Text(widget.title??"",style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),),
            items: widget.dropdownmenuitem?.map((item) {
              return DropdownMenuItem(
                value: item.value,
                enabled: widget.isEnable ?? false,
                child: StatefulBuilder(
                  builder: (context, menuSetState) {
                    final isSelected = widget.selectedItems.any((element) =>
                        element.value == item.value &&
                        element.label == item.label);
                    return InkWell(
                      onTap: () {
                        isSelected
                            ? widget.selectedItems.removeWhere(
                                (element) => element.value == item.value,
                              )
                            : widget.selectedItems.add(item);
                        setState(() {});
                        menuSetState(() {});
                      },
                      child: Container(
                        height: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            if (isSelected)
                              const Icon(Icons.check_box,
                                  color: AppColors.primaryBlue)
                            else
                              const Icon(Icons.check_box_outline_blank,
                                  color: AppColors.borderColor),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(item.label,
                                  style: AppTextStyle.font13TextRegularTajawal),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
            //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
            value: widget.selectedItems.isEmpty
                ? null
                : widget.selectedItems.last.value,
            onChanged: (value) {},
            selectedItemBuilder: (context) {
              return widget.dropdownmenuitem!.map(
                (item) {
                  return Container(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      widget.selectedItems.map((e) => e.label).join(', '),
                      style: AppTextStyle.font13TextRegularTajawal,
                      maxLines: 1,
                    ),
                  );
                },
              ).toList();
            },
            decoration: InputDecoration(
              //hoverColor: context.color.secondOverLayMainBgColor,
              hintText: widget.hint,
              iconColor: Colors.red,
              isDense: true,
              fillColor: widget.fillColor ?? AppColors.textFieldFilledColor,
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
            buttonStyleData:  const ButtonStyleData(
              padding: EdgeInsets.symmetric(horizontal: 0),
            ),

            menuItemStyleData: const MenuItemStyleData(
                padding: EdgeInsets.zero,
                overlayColor:
                MaterialStatePropertyAll(AppColors.textFieldFilledColor)),
            dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                    color: widget.fillColor ?? AppColors.textFieldFilledColor)),

          ),
        ),
        if (widget.selectedItems.isNotEmpty) ...[
          verticalSpace(10),
          Wrap(
            runSpacing: 10.h,
            children: List.generate(
              widget.selectedItems.length,
              (index) {
                return Padding(
                  padding: const EdgeInsetsDirectional.only(
                    end: 10,
                  ),
                  child: Container(
                    height: 38.h,
                    decoration: BoxDecoration(
                      color:  AppColors.primaryBlue.withOpacity(0.08),
                      borderRadius:  BorderRadius.all(Radius.circular(12.r)),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.selectedItems[index].label,
                          style: AppTextStyle.font16BlackRegularTajawal,
                        ),
                        horizontalSpace(8),
                        InkWell(
                            onTap: () {
                              widget.selectedItems.removeAt(index);
                              setState(() {});
                            },
                            child: SvgPicture.asset(
                              Assets.iconsTrash,
                              height: 11.h,
                              width: 11.w,
                            )),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ]
      ],
    );
  }
}
