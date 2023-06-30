import 'package:ripapp_dashboard/models/product_entity.dart';
import 'package:ripapp_dashboard/utils/ResultSet.dart';

class ProductOffered implements ResultEntity {
  ProductEntity productEntity;
  bool offered;

  ProductOffered({required this.productEntity, required this.offered});

  factory ProductOffered.fromJson(Map<String, dynamic> json) => ProductOffered(
    productEntity: ProductEntity.fromJson(json["product"]),
    offered: json["offered"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "product": productEntity.toJson(),
    "offered": offered,
  };


  @override
  String toString() {
    return 'ProductOffered{productEntity: $productEntity, offered: $offered}';
  }
}