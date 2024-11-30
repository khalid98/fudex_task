import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudex_task/core/di/di.dart';
import 'package:fudex_task/core/extensions/string_extension.dart';
import 'package:fudex_task/core/local_storage/models/product_model.dart';
import 'package:fudex_task/core/local_storage/service/product_service.dart';
import 'package:fudex_task/core/widgets/components.dart';
import 'package:fudex_task/core/widgets/drop_down_multi_select_color.dart';
import 'package:fudex_task/core/widgets/drop_down_multi_selection_widget.dart';
import 'package:fudex_task/feature/add_products/data/models/categories.dart';
import 'package:fudex_task/feature/products_history/presentation/cubit/product_history_cubit.dart';
import 'package:uuid/uuid.dart';

part 'add_products_state.dart';

class AddProductsCubit extends Cubit<AddProductsChanged> {
  AddProductsCubit()
      : super(AddProductsChanged(
          mainCategory: categories.map((e) => e.name).toList(),
          productStatus: 1,
          sizes: [
            DropDownModel(label: 'S', value: 'S'),
            DropDownModel(label: 'M', value: 'M'),
            DropDownModel(label: 'L', value: 'L'),
            DropDownModel(label: 'XL', value: 'XL'),
            DropDownModel(label: 'XXL', value: 'XXL'),
          ],
          keywords: [
            DropDownModel(label: 'حقيبة', value: 'حقيبة'),
            DropDownModel(label: 'شنطة', value: 'شنطة'),
            DropDownModel(label: 'هاند ميد', value: 'هاند ميد'),
            DropDownModel(label: 'خوص', value: 'خوص'),
          ],
          colors: [
            DropDownColorModel(
                label: Colors.red.value, value: Colors.red.value),
            DropDownColorModel(
                label: Colors.blue.value, value: Colors.blue.value),
            DropDownColorModel(
                label: Colors.green.value, value: Colors.green.value),
            DropDownColorModel(
                label: Colors.yellow.value, value: Colors.yellow.value),
          ],
          images: [],
        ));
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  filterSubCategory(String mainCategory) {
    final subCategories =
        categories.firstWhere((element) => element.name == mainCategory);
    state.selectedSubCategory = null;
    emit(state.copyWith(
      selectedSubCategory: null,
      selectedMainCategory: mainCategory,
      subCategory: subCategories.subcategories.map((e) => e).toList(),
    ));
  }

  init(ProductModel product) {
    filterSubCategory(product.selectedMainCategory ?? '');
    emit(state.copyWith(
      isProductActive: product.isProductActive,
      productName: product.productName,
      price: product.price,
      productDesController: product.productDesController,
      selectedMainCategory: product.selectedMainCategory,
      selectedSubCategory: product.selectedSubCategory,
      selectedColors: product.selectedColors
          ?.map((e) => DropDownColorModel(label: e, value: e))
          .toList(),
      selectedKeywords: product.selectedKeywords
          ?.map((e) => DropDownModel(label: e, value: e))
          .toList(),
      selectedProductSizes: product.selectedProductSizes
          ?.map((e) => DropDownModel(label: e, value: e))
          .toList(),
      primaryImage: product.primaryImage,
      images: product.images,
      productStatus: product.productStatus,
    ));
  }

  productName(String name) {
    emit(state.copyWith(productName: name));
  }

  productPrice(String price) {
    emit(state.copyWith(price: price));
  }

  productDescription(String description) {
    emit(state.copyWith(productDesController: description));
  }

  selectedSizes(List<DropDownModel> sizes) {
    emit(state.copyWith(selectedProductSizes: sizes));
  }

  selectedKeywords(List<DropDownModel> keywords) {
    emit(state.copyWith(selectedKeywords: keywords));
  }

  selectedColors(List<DropDownColorModel> colors) {
    emit(state.copyWith(selectedColors: colors));
  }

  selectProductStatus(int status) {
    emit(state.copyWith(productStatus: status));
  }

  selectSubCategory(String? subCategory) {
    emit(state.copyWith(selectedSubCategory: subCategory));
  }

  selectedMainImage(String? image) {
    emit(state.copyWith(primaryImage: image));
  }

  selectedImages(String? image) {
    if (state.images!.length >= 3) return; // Limit to 3 images
    final updatedImages = List<String>.from(state.images ?? [])
      ..add(image ?? "");
    emit(state.copyWith(images: updatedImages));
  }

  removeImages(int index) {
    final updatedImages = List<String>.from(state.images ?? [])
      ..removeAt(index);
    emit(state.copyWith(images: updatedImages));
  }

  addProduct(BuildContext context) {
    final isImagesAdded = validateImage();
    final isValid = formKey.currentState!.validate();
    final selectedKeywords =
        state.selectedKeywords!.map((e) => e.value).toList();
    final selectedColors = state.selectedColors!.map((e) => e.value).toList();
    final selectedProductSizes =
        state.selectedProductSizes!.map((e) => e.value).toList();
    final keywords = state.keywords!.map((e) => e.value).toList();
    if (isValid && isImagesAdded) {
      formKey.currentState!.save();
      try {
        sl<ProductService>()
            .addProduct(ProductModel(
          productId: const Uuid().v4(),
          isProductActive: state.isProductActive,
          productName: state.productName,
          price: state.price,
          productDesController: state.productDesController,
          selectedMainCategory: state.selectedMainCategory,
          selectedSubCategory: state.selectedSubCategory,
          selectedColors: selectedColors,
          selectedKeywords: selectedKeywords,
          keywords: keywords,
          selectedProductSizes: selectedProductSizes,
          primaryImage: state.primaryImage,
          images: state.images,
          productStatus: state.productStatus,
        ))
            .then((value) {
          showToast(msg: 'Product added successfully');
          context.read<ProductHistoryCubit>().getProducts();
          Navigator.pop(context);
        });
      } catch (e) {
        showToast(msg: 'Error adding product ${e.toString()}');
      }
    }
  }

  editProduct(BuildContext context, String productId) {
    final isImagesAdded = validateImage();
    final isValid = formKey.currentState!.validate();
    final selectedKeywords =
        state.selectedKeywords!.map((e) => e.value).toList();
    final selectedColors = state.selectedColors!.map((e) => e.value).toList();
    final selectedProductSizes =
        state.selectedProductSizes!.map((e) => e.value).toList();
    final keywords = state.keywords!.map((e) => e.value).toList();
    if (isValid && isImagesAdded) {
      formKey.currentState!.save();
      try {
        sl<ProductService>()
            .updateProductById(
                productId,
                ProductModel(
                  productId: productId,
                  isProductActive: state.isProductActive,
                  productName: state.productName,
                  price: state.price,
                  productDesController: state.productDesController,
                  selectedMainCategory: state.selectedMainCategory,
                  selectedSubCategory: state.selectedSubCategory,
                  selectedColors: selectedColors,
                  selectedKeywords: selectedKeywords,
                  keywords: keywords,
                  selectedProductSizes: selectedProductSizes,
                  primaryImage: state.primaryImage,
                  images: state.images,
                  productStatus: state.productStatus,
                ))
            .then((value) {
          showToast(msg: 'Product updated successfully');
          context.read<ProductHistoryCubit>().getProducts();
          Navigator.pop(context);
        });
      } catch (e) {
        showToast(msg: 'Error adding product ${e.toString()}');
      }
    }
  }

  bool validateImage() {
    if (state.primaryImage.isEmptyOrNull) {
      showToast(msg: 'Please select primary image');
      return false;
    } else if (state.images!.isEmpty) {
      showToast(msg: 'Please select images');
      return false;
    }
    return true;
  }
}
