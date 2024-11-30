part of 'add_products_cubit.dart';

final class AddProductsChanged {
  final String? productName;
  List<String>? mainCategory;
  List<String>? subCategory;
  List<DropDownModel>? sizes;
  List<DropDownModel>? keywords;
  List<DropDownColorModel>? colors;
  final String? price;
  final String? productDesController;
  final String? selectedMainCategory;
  String? selectedSubCategory;
  final String? selectedAdditional;
  List<DropDownColorModel>? selectedColors;
  final List<DropDownModel>? selectedProductSizes;
  List<DropDownModel>? selectedKeywords;
  bool? isProductActive;

  final String? primaryImage;
  List<String>? images;
  final int? productStatus;

  AddProductsChanged(
      {this.productName,
      this.mainCategory,
      this.subCategory,
      this.price,
      this.productDesController,
      this.selectedMainCategory,
      this.selectedSubCategory,
      this.selectedAdditional,
      this.selectedColors,
      this.sizes,
      this.isProductActive,
      this.keywords,
      this.selectedKeywords,
      this.colors,
      this.selectedProductSizes,
      this.images,
      this.primaryImage,
      this.productStatus});

  AddProductsChanged copyWith({
    String? productName,
    List<String>? mainCategory,
    String? price,
    List<String>? subCategory,
    String? productDesController,
    String? selectedMainCategory,
    String? selectedSubCategory,
    String? selectedAdditional,
    bool? isProductActive,
    List<DropDownColorModel>? selectedColors,
    List<DropDownModel>? selectedKeywords,
    List<DropDownModel>? keywords,
    List<DropDownModel>? selectedProductSizes,
    List<DropDownColorModel>? colors,
    List<DropDownModel>? sizes,
    String? primaryImage,
    List<String>? images,
    int? productStatus,
  }) {
    return AddProductsChanged(
      productName: productName ?? this.productName,
      price: price ?? this.price,
      mainCategory: mainCategory ?? this.mainCategory,
      subCategory: subCategory ?? this.subCategory,
      sizes: sizes ?? this.sizes,
      colors: colors ?? this.colors,
      keywords: keywords ?? this.keywords,
      isProductActive: isProductActive ?? this.isProductActive,
      selectedKeywords: selectedKeywords ?? this.selectedKeywords,
      productDesController: productDesController ?? this.productDesController,
      selectedMainCategory: selectedMainCategory ?? this.selectedMainCategory,
      selectedSubCategory: selectedSubCategory ?? this.selectedSubCategory,
      selectedAdditional: selectedAdditional ?? this.selectedAdditional,
      selectedColors: selectedColors ?? this.selectedColors,
      selectedProductSizes: selectedProductSizes ?? this.selectedProductSizes,
      primaryImage: primaryImage ?? this.primaryImage,
      images: images ?? this.images,
      productStatus: productStatus ?? this.productStatus,
    );
  }
}
