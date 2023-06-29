import 'package:ripapp_dashboard/models/product_entity.dart';

class ProductOffered{
  ProductEntity productEntity;
  bool offered;

  ProductOffered({required this.productEntity, required this.offered});

  factory ProductOffered.fromJson(Map<String, dynamic> json) => ProductOffered(
    productEntity: ProductEntity.fromJson(json["product"]),
    offered: json["offered"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "product": productEntity.toJson() ?? null,
    "offered": offered,
  };


  @override
  String toString() {
    return 'ProductOffered{productEntity: $productEntity, offered: $offered}';
  }
}