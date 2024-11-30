import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fudex_task/core/extensions/list_extension.dart';
import 'package:fudex_task/core/extensions/string_extension.dart';
import 'package:fudex_task/core/helpers/media_picker.dart';
import 'package:fudex_task/core/helpers/spacing.dart';
import 'package:fudex_task/core/local_storage/models/product_model.dart';
import 'package:fudex_task/core/theme/app_colors.dart';
import 'package:fudex_task/core/theme/app_text_style.dart';
import 'package:fudex_task/core/utils/assets.dart';
import 'package:fudex_task/core/widgets/appbar_component.dart';
import 'package:fudex_task/core/widgets/custom_app_button.dart';
import 'package:fudex_task/core/widgets/custom_drop_down.dart';
import 'package:fudex_task/core/widgets/custom_text_field.dart';
import 'package:fudex_task/core/widgets/drop_down_multi_select_color.dart';
import 'package:fudex_task/core/widgets/drop_down_multi_selection_widget.dart';
import 'package:fudex_task/core/widgets/labled_widget.dart';
import 'package:fudex_task/feature/add_products/presentation/cubit/add_products_cubit.dart';
import 'package:fudex_task/feature/add_products/presentation/widgets/dotted_widget.dart';

class AddProductsScreen extends StatefulWidget {
  bool isAdd;
  int? index;
  ProductModel? productModel;

  AddProductsScreen(
      {super.key, required this.isAdd, this.index, this.productModel});

  @override
  State<AddProductsScreen> createState() => _AddProductsScreenState();
}

class _AddProductsScreenState extends State<AddProductsScreen> {
  @override
  void initState() {
    super.initState();
    if (!widget.isAdd) {
      context.read<AddProductsCubit>().init(widget.productModel!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: CustomAppButton(
            title: 'حفظ',
            onPressed: () {
              if (widget.isAdd) {
                context.read<AddProductsCubit>().addProduct(context);
              } else {
                context
                    .read<AddProductsCubit>()
                    .editProduct(context, widget.productModel?.productId ?? "");
              }
            },
          ),
        ),
        appBar: AppbarComponent(
          title: widget.isAdd ? 'آضافه منتج' : 'تعديل',
        ),
        body: BlocConsumer<AddProductsCubit, AddProductsChanged>(
          listener: (context, state) {},
          builder: (context, state) {
            final cubit = context.read<AddProductsCubit>();
            return Form(
              key: cubit.formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "صور المنتج",
                      style: AppTextStyle.font16BlackRegularTajawal,
                    ),
                    verticalSpace(15),
                    SizedBox(
                      width: double.infinity,
                      child: DottedWidget(
                          child: Padding(
                        padding: EdgeInsets.all(18.r),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: GestureDetector(
                                onTap: () async {
                                  final image = await MediaPicker.pickImage();
                                  if (image != null) {
                                    cubit.selectedMainImage(image);
                                  }
                                },
                                child: Stack(
                                  children: [
                                    DottedWidget(
                                      child: Container(
                                        height: 120.h,
                                        width: 150.w,
                                        color: AppColors.primaryWhite,
                                        child: state.primaryImage.isEmptyOrNull
                                            ? Center(
                                                child: SvgPicture.asset(
                                                Assets.iconsAddIcon,
                                                height: 40.h,
                                                width: 40.w,
                                              ))
                                            : Image.memory(base64Decode(
                                                state.primaryImage ?? "")),
                                      ),
                                    ),
                                    if (!state.primaryImage.isEmptyOrNull) ...[
                                      Positioned(
                                        right: 15.w,
                                        top: 10.h,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.lightBlue,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.r)),
                                          ),
                                          padding: EdgeInsets.all(3.r),
                                          child: Text(
                                            "الصورة الرئيسية",
                                            style: AppTextStyle
                                                .font10BlueBoldTajawal,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 15.w,
                                        top: 10.h,
                                        child: InkWell(
                                          onTap: () {
                                            cubit.selectedMainImage("");
                                          },
                                          child: SvgPicture.asset(
                                            Assets.iconsTrashbg,
                                            height: 20.h,
                                            width: 20.w,
                                          ),
                                        ),
                                      )
                                    ]
                                  ],
                                ),
                              ),
                            ),
                            verticalSpace(15),
                            Wrap(
                              spacing: 10.w,
                              runSpacing: 10.h,
                              children: [
                                if (!state.images!.isEmptyOrNull) ...[
                                  ...List.generate(
                                    state.images!.length,
                                    (index) {
                                      return Stack(
                                        children: [
                                          DottedWidget(
                                            child: Container(
                                              height: 58.h,
                                              width: 51.w,
                                              color: AppColors.primaryWhite,
                                              child: Center(
                                                child: Image.memory(
                                                    base64Decode(
                                                        state.images![index])),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 10.w,
                                            top: 5.h,
                                            child: InkWell(
                                              onTap: () {
                                                cubit.removeImages(index);
                                              },
                                              child: SvgPicture.asset(
                                                Assets.iconsTrashbg,
                                                height: 20.h,
                                                width: 20.w,
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                ],
                                DottedWidget(
                                  child: Container(
                                    height: 58.h,
                                    width: 51.w,
                                    color: AppColors.primaryWhite,
                                    child: GestureDetector(
                                        onTap: () async {
                                          final image =
                                              await MediaPicker.pickImage();
                                          if (image != null) {
                                            cubit.selectedImages(image);
                                          }
                                        },
                                        child: Center(
                                          child: SvgPicture.asset(
                                            Assets.iconsAddIcon,
                                            height: 30.h,
                                            width: 30.w,
                                          ),
                                        )),
                                  ),
                                )
                              ],
                            ),
                            verticalSpace(15),
                            Text(
                              "(لا يجب أن يتجاوز مساحة 2.5 MB)",
                              style: AppTextStyle.font13TextRegularTajawal,
                            )
                          ],
                        ),
                      )),
                    ),
                    verticalSpace(15),
                    CustomTextField(
                      initialValue: state.productName,
                      filedColor: AppColors.textFieldFilledColor,
                      onSave: (value) {
                        cubit.productName(value ?? "");
                      },
                      validator: (value) {
                        if (value.isEmptyOrNull) {
                          return "يجب ادخال اسم المنتج";
                        }
                        return null;
                      },
                      radius: 12,
                      title: "اسم المنتج",
                      hint: "اسم المنتج",
                    ),
                    verticalSpace(15),
                    CustomDropDown(
                      isRequired: true,
                      dropDownMenuItem: List.generate(
                        state.mainCategory!.length,
                        (index) {
                          return DropdownMenuItem(
                              value: state.mainCategory![index],
                              child: Text(state.mainCategory![index]));
                        },
                      ),
                      onchange: (value) {
                        cubit.filterSubCategory(value ?? "");
                      },
                      vaildator: (value) {
                        if (state.selectedMainCategory.isEmptyOrNull) {
                          return "يجب اختيار القسم الرئيسى";
                        }
                        return null;
                      },
                      selectedValue: cubit.state.selectedMainCategory,
                      fillColor: AppColors.textFieldFilledColor,
                      title: "القسم الرئيسى",
                      hint: "القسم الرئيسى",
                    ),
                    if (state.selectedMainCategory != null) ...[
                      verticalSpace(15),
                      CustomDropDown(
                        isRequired: true,
                        dropDownMenuItem: List.generate(
                          state.subCategory!.length,
                          (index) {
                            return DropdownMenuItem(
                                value: state.subCategory![index],
                                child: Text(state.subCategory![index]));
                          },
                        ),
                        onchange: (value) {
                          print(value);
                          cubit.selectSubCategory(value ?? "");
                        },
                        selectedValue: state.selectedSubCategory,
                        vaildator: (value) {
                          if (state.selectedSubCategory.isEmptyOrNull) {
                            return "يجب اختيار القسم الفرعى";
                          }
                          return null;
                        },
                        fillColor: AppColors.textFieldFilledColor,
                        title: "القسم الفرعى",
                        hint: "القسم الفرعى",
                      ),
                    ],
                    verticalSpace(15),
                    CustomTextField(
                      initialValue: state.price,
                      filedColor: AppColors.textFieldFilledColor,
                      keyboardType: TextInputType.number,
                      textInputFormatter: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                      ],
                      radius: 12,
                      onSave: (value) {
                        cubit.productPrice(value ?? "");
                      },
                      validator: (value) {
                        if (value.isEmptyOrNull) {
                          return "يجب ادخال سعر المنتج";
                        }
                        return null;
                      },
                      title: "سعر المنتج",
                      hint: '1500 رس',
                    ),
                    verticalSpace(15),
                    CustomDropDown(
                      dropDownMenuItem: [],
                      fillColor: AppColors.textFieldFilledColor,
                      title: "اضافات",
                      hint: 'اضافات',
                    ),
                    verticalSpace(15),
                    DropDownMultiSelectColor(
                      title: ' تحديد اللون',
                      hint: ' تحديد اللون',
                      selectedItems: state.selectedColors ?? [],
                      dropdownmenuitem: state.colors,
                      onChange: (l) {
                        cubit.selectedColors(l);
                      },
                      vaildator: (String) {
                        if (state.selectedColors!.isEmptyOrNull) {
                          return "يجب اختيار اللون";
                        }
                        return null;
                      },
                    ),
                    verticalSpace(15),
                    DropDownMultiSelection(
                      title: ' تحديد المقاس',
                      hint: 'تحديد المقاس',
                      selectedItems: state.selectedProductSizes ?? [],
                      dropdownmenuitem: state.sizes,
                      onChange: (l) {
                        cubit.selectedSizes(l);
                      },
                      vaildator: (l) {
                        if (state.selectedProductSizes!.isEmptyOrNull) {
                          return "يجب اختيار المقاس";
                        }
                        return null;
                      },
                    ),
                    verticalSpace(15),
                    Text("حالة المنتج",
                        style: AppTextStyle.font16BlackRegularTajawal),
                    verticalSpace(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LabeledRadio(
                          groupValue: state.productStatus ?? 0,
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          onChanged: (value) {
                            cubit.selectProductStatus(value ?? 0);
                          },
                          value: 1,
                          widget: Text(
                            "عادى",
                            style: AppTextStyle.font16BlackRegularTajawal,
                          ),
                        ),
                        LabeledRadio(
                          groupValue: state.productStatus ?? 0,
                          padding: EdgeInsets.zero,
                          onChanged: (value) {
                            cubit.selectProductStatus(value ?? 0);
                          },
                          value: 2,
                          widget: Text(
                            "لا",
                            style: AppTextStyle.font16BlackRegularTajawal,
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(15),
                    DropDownMultiSelection(
                      title: 'الكلمات الدالة على المنتج',
                      hint: 'الكلمات الدالة على المنتج',
                      selectedItems: state.selectedKeywords ?? [],
                      dropdownmenuitem: state.keywords,
                      onChange: (l) {
                        cubit.selectedKeywords(l);
                      },
                      vaildator: (l) {
                        if (state.selectedKeywords!.isEmptyOrNull) {
                          return "يجب اختيار الكلمات الدالة على المنتج";
                        }
                        return null;
                      },
                    ),
                    verticalSpace(15),
                    CustomTextField(
                      initialValue: state.productDesController,
                      maxLine: 5,
                      filedColor: AppColors.textFieldFilledColor,
                      onSave: (value) {
                        cubit.productDescription(value ?? "");
                      },
                      validator: (value) {
                        if (value.isEmptyOrNull) {
                          return "يجب ادخال وصف المنتج";
                        }
                        return null;
                      },
                      radius: 12,
                      title: "وصف المنتج",
                      hint: "وصف المنتج",
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
