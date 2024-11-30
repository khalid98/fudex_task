import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fudex_task/core/helpers/spacing.dart';
import 'package:fudex_task/core/routes/app_routes.dart';
import 'package:fudex_task/core/theme/app_colors.dart';
import 'package:fudex_task/core/theme/app_text_style.dart';
import 'package:fudex_task/core/utils/assets.dart';
import 'package:fudex_task/core/widgets/appbar_component.dart';
import 'package:fudex_task/core/widgets/custom_app_button.dart';
import 'package:fudex_task/core/widgets/custom_drop_down.dart';
import 'package:fudex_task/core/widgets/custom_text_field.dart';
import 'package:fudex_task/core/widgets/switch_widget.dart';
import 'package:fudex_task/feature/add_products/data/models/categories.dart';
import 'package:fudex_task/feature/products_history/presentation/cubit/product_history_cubit.dart';
import 'package:fudex_task/feature/products_history/presentation/widgets/product_item.dart';

class ProductsHistoryScreen extends StatefulWidget {
  const ProductsHistoryScreen({super.key});

  @override
  State<ProductsHistoryScreen> createState() => _ProductsHistoryScreenState();
}

class _ProductsHistoryScreenState extends State<ProductsHistoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductHistoryCubit>().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarComponent(
        title: 'سجل المنتجات',
      ),
      body: BlocConsumer<ProductHistoryCubit, ProductHistoryLoaded>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = context.read<ProductHistoryCubit>();
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                CustomTextField(
                  hint: 'بحث',
                  onchange: (value) {
                    cubit.searchProducts(value ?? "");
                  },
                  prefix: UnconstrainedBox(
                    child: SvgPicture.asset(
                      Assets.iconsSearchIcon,
                      height: 20.h,
                      width: 20.w,
                    ),
                  ),
                  suffix: UnconstrainedBox(
                    child: SvgPicture.asset(
                      Assets.iconsClose,
                      height: 20.h,
                      width: 20.w,
                    ),
                  ),
                ),
                verticalSpace(14.h),
                CustomDropDown(
                  hint: 'القسم',
                  dropDownMenuItem: categories.map((e) {
                    return DropdownMenuItem(value: e.name, child: Text(e.name));
                  }).toList(),
                  onchange: (value) {
                    context.read<ProductHistoryCubit>().setCategory(value);
                  },
                ),
                verticalSpace(14.h),
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return state.searchedProducts!.isEmpty
                            ? Center(
                                child: Text(
                                  'لم يتم العثور على منتجات',
                                  style: AppTextStyle.font16BlackRegularTajawal,
                                ),
                              )
                            :ProductItem(
                                index: index,
                              );
                      },
                      separatorBuilder: (context, index) {
                        return verticalSpace(14);
                      },
                      itemCount: state.searchedProducts!.length),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  child: CustomAppButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.addProductsScreen,
                            arguments: {
                              "isAdd": true,
                            });
                      },
                      title: 'أضافة منتج'),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

