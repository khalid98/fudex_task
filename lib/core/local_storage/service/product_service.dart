import 'package:fudex_task/core/di/di.dart';
import 'package:fudex_task/core/local_storage/models/product_model.dart';
import 'package:fudex_task/core/utils/app_constants.dart';
import 'package:fudex_task/core/widgets/components.dart';
import 'package:hive/hive.dart';

class ProductService {
  final Box<ProductModel> _productBox = sl<Box<ProductModel>>();

  Future<void> addProduct(ProductModel product) async {
    await _productBox.add(product);
  }

  Future<void> updateProductById(
      String productId, ProductModel updatedProduct) async {

    final keyToUpdate = _productBox.keys.firstWhere(
      (key) {
        final product = _productBox.get(key);
        return product?.productId == productId;
      },
      orElse: () => null,
    );

    if (keyToUpdate != null) {
      await _productBox.put(keyToUpdate, updatedProduct);
    } else {
      showToast(msg: "No product found with ID $productId.");
    }
  }

  Future<void> deleteProductById(String productId) async {
    final keyToDelete = _productBox.keys.firstWhere(
      (key) {
        final product = _productBox.get(key);
        return product?.productId == productId;
      },
      orElse: () => null,
    );
    if (keyToDelete != null) {
      await _productBox.delete(keyToDelete);
    } else {
      showToast(msg: "No product found with ID $productId.");
    }
  }

  List<ProductModel> getAllProducts() {
    return _productBox.values.toList();
  }

  ProductModel? getProductById(String productId) {
    return _productBox.values.firstWhere(
      (product) => product.productId == productId,
    );
  }
}
