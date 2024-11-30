import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fudex_task/core/helpers/spacing.dart';
import 'package:fudex_task/core/routes/app_routes.dart';
import 'package:fudex_task/core/theme/app_colors.dart';
import 'package:fudex_task/core/theme/app_text_style.dart';
import 'package:fudex_task/core/utils/assets.dart';
import 'package:fudex_task/core/widgets/switch_widget.dart';
import 'package:fudex_task/feature/products_history/presentation/cubit/product_history_cubit.dart';

class ProductItem extends StatelessWidget {
  final int index;

  const ProductItem({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductHistoryCubit, ProductHistoryLoaded>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = context.read<ProductHistoryCubit>();
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, Routes.addProductsScreen, arguments: {
              "isAdd": false,
              "product": state.searchedProducts?[index],
              "index": index
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowColor.withOpacity(0.3),
                  offset: const Offset(-2, 2),
                  blurRadius: 10,
                  spreadRadius: -1,
                ),
              ],
            ),
            child: Card(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24.h),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "تفعيل المنتج",
                            style: AppTextStyle.font13BlackRegularTajawal,
                          ),
                          const Spacer(),
                          AdaptiveSwitch(
                            value:
                                state.products![index].isProductActive ?? false,
                            trackColor: AppColors.primaryBlue,
                            activeColor: AppColors.primaryWhite,
                            onChanged: (value) {
                              cubit.updateActiveStatus(
                                  state.products![index].productId ?? "",
                                  value);
                            },
                          ),
                          horizontalSpace(15),
                          InkWell(
                            onTap: () {
                              cubit.removeProduct(
                                  state.searchedProducts![index].productId ??
                                      "");
                            },
                            child: SvgPicture.asset(Assets.iconsTrash,
                                height: 24.h, width: 24.w),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: AppColors.borderColor,
                      thickness: 1,
                    ),
                    verticalSpace(17),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.memory(
                            base64Decode(
                              state.searchedProducts?[index].primaryImage ?? "",
                            ),
                            height: 90.h,
                            width: 90.w,
                          ),
                          horizontalSpace(8),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.searchedProducts?[index].productName ??
                                    "",
                                style: AppTextStyle.font13TextRegularTajawal,
                              ),
                              verticalSpace(8),
                              Text(
                                "${state.searchedProducts?[index].price ?? ""} رس ",
                                style: AppTextStyle.font14BlueBoldTajawal,
                              ),
                              verticalSpace(8),
                              Row(
                                children: List.generate(
                                    state.searchedProducts![index]
                                        .selectedProductSizes!.length, (i) {
                                  return Padding(
                                    padding: EdgeInsets.only(left: 2.w),
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.r)),
                                        border: Border.all(
                                            color: AppColors.borderColor),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.w),
                                        child: Text(
                                          state.searchedProducts![index]
                                                  .selectedProductSizes?[i] ??
                                              "",
                                          style: AppTextStyle
                                              .font10GreyMediumTajawal
                                              .copyWith(height: 2.h),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                              verticalSpace(8),
                              Row(
                                children: List.generate(
                                    state.searchedProducts![index]
                                        .selectedColors!.length, (i) {
                                  return Padding(
                                    padding: EdgeInsets.only(left: 2.w),
                                    child: Container(
                                      height: 15.h,
                                      width: 15.w,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.r)),
                                        color: Color(state
                                            .searchedProducts![index]
                                            .selectedColors![i]),
                                      ),
                                    ),
                                  );
                                }),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
