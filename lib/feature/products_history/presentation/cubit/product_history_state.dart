part of 'product_history_cubit.dart';

final class ProductHistoryLoaded {
  final List<ProductModel> ?products;
  final List<ProductModel> ?searchedProducts;

  ProductHistoryLoaded({this.products,this.searchedProducts});

  ProductHistoryLoaded copyWith({
    List<ProductModel>? products,
    List<ProductModel>? searchedProducts,
  }) {
    return ProductHistoryLoaded(
      products: products ?? this.products,
      searchedProducts: searchedProducts ?? this.searchedProducts,
    );
  }

  @override
  List<Object?> get props => [products];
}
