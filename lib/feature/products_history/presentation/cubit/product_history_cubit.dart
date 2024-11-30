import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudex_task/core/local_storage/models/product_model.dart';
import 'package:fudex_task/core/local_storage/service/product_service.dart';
import 'package:fudex_task/core/di/di.dart';

part 'product_history_state.dart';

class ProductHistoryCubit extends Cubit<ProductHistoryLoaded> {
  ProductHistoryCubit()
      : super(ProductHistoryLoaded(products: [], searchedProducts: []));
  String? selectedCategory;

  getProducts() {
    final products = sl<ProductService>().getAllProducts();
    emit(ProductHistoryLoaded(products: products, searchedProducts: products));
  }

  removeProduct(String productId) {
    sl<ProductService>().deleteProductById(productId);
    getProducts();
  }

  updateActiveStatus(String productId, bool isActive) {
    final product = sl<ProductService>().getProductById(productId);
    product!.isProductActive = isActive;
    sl<ProductService>().updateProductById(productId, product);
    getProducts();
  }


  void searchProducts(String query) {
    List<ProductModel>? filteredProducts = state.products;

    // Filter by category if a category is selected
    if (selectedCategory != null && selectedCategory!.isNotEmpty) {
      filteredProducts = filteredProducts
          ?.where((product) =>
      product.selectedMainCategory?.toLowerCase() ==
          selectedCategory!.toLowerCase())
          .toList();
    }

    // Apply the search query
    if (query.isNotEmpty) {
      filteredProducts = filteredProducts
          ?.where((product) =>
      product.productName?.toLowerCase().contains(query.toLowerCase()) ??
          false)
          .toList();
    }

    emit(state.copyWith(searchedProducts: filteredProducts));
  }

  void filterByCategory(String? category) {
    if (category == null || category.isEmpty) {
      emit(state.copyWith(searchedProducts: state.products));
      return;
    }
    final filteredProducts = state.products
        ?.where((product) =>
    product.selectedMainCategory?.toLowerCase() == category.toLowerCase())
        .toList();

    emit(state.copyWith(searchedProducts: filteredProducts));
  }
  void setCategory(String? category) {
    selectedCategory = category;
    searchProducts("");
  }
}
