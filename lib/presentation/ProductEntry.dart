import '../models/product_entity.dart';

class ProductEntry {
  int? id;
  String? name;
  String? photoName;
  String? price;

  ProductEntry({
    this.id,
    this.name,
    this.photoName,
    this.price,
  });

  factory ProductEntry.fromProductEntity(ProductEntity productEntity){
    return ProductEntry(id: productEntity.id, name: productEntity.name, photoName: productEntity.photoName,
        price: productEntity.price?.toStringAsFixed(2) ?? "");
  }

  ProductEntity toProductEntity(){
    return ProductEntity(id: this.id, name: this.name, photoName: this.photoName,
        price: double.parse(this.price! ?? "-NaN"));
  }
}