import 'package:fudex_task/core/widgets/drop_down_multi_select_color.dart';
import 'package:fudex_task/core/widgets/drop_down_multi_selection_widget.dart';
import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0) // Each model needs a unique typeId
class ProductModel extends HiveObject {
  @HiveField(0)
  String? productName;

  @HiveField(1)
  String? price;

  @HiveField(2)
  String? productDesController;

  @HiveField(3)
  String? selectedMainCategory;

  @HiveField(4)
  String? selectedSubCategory;

  @HiveField(5)
  List<int>? selectedColors;

  @HiveField(6)
  List<String>? selectedKeywords;

  @HiveField(7)
  List<String>? keywords;

  @HiveField(8)
  List<String>? selectedProductSizes;

  @HiveField(9)
  String? primaryImage;

  @HiveField(10)
  List<String>? images;

  @HiveField(11)
  int? productStatus;

  @HiveField(12)
  bool? isProductActive;
  @HiveField(13)
  String? productId;

  ProductModel(
      {this.productName,
      this.price,
      this.productDesController,
      this.selectedMainCategory,
      this.selectedSubCategory,
      this.selectedColors,
      this.selectedKeywords,
      this.keywords,
      this.selectedProductSizes,
      this.primaryImage,
      this.images,
      this.productStatus,
      this.isProductActive,
      this.productId});
}
