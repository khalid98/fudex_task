// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 0;

  @override
  ProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModel(
      productName: fields[0] as String?,
      price: fields[1] as String?,
      productDesController: fields[2] as String?,
      selectedMainCategory: fields[3] as String?,
      selectedSubCategory: fields[4] as String?,
      selectedColors: (fields[5] as List?)?.cast<int>(),
      selectedKeywords: (fields[6] as List?)?.cast<String>(),
      keywords: (fields[7] as List?)?.cast<String>(),
      selectedProductSizes: (fields[8] as List?)?.cast<String>(),
      primaryImage: fields[9] as String?,
      images: (fields[10] as List?)?.cast<String>(),
      productStatus: fields[11] as int?,
      isProductActive: fields[12] as bool?,
      productId: fields[13] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.productName)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.productDesController)
      ..writeByte(3)
      ..write(obj.selectedMainCategory)
      ..writeByte(4)
      ..write(obj.selectedSubCategory)
      ..writeByte(5)
      ..write(obj.selectedColors)
      ..writeByte(6)
      ..write(obj.selectedKeywords)
      ..writeByte(7)
      ..write(obj.keywords)
      ..writeByte(8)
      ..write(obj.selectedProductSizes)
      ..writeByte(9)
      ..write(obj.primaryImage)
      ..writeByte(10)
      ..write(obj.images)
      ..writeByte(11)
      ..write(obj.productStatus)
      ..writeByte(12)
      ..write(obj.isProductActive)
      ..writeByte(13)
      ..write(obj.productId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
