import 'package:ripapp_dashboard/utils/ResultSet.dart';

class ProductEntity implements ResultEntity {
  int? id;
  String? name;
  String? photoName;
  double? price;
  String? firebaseId;

  ProductEntity({
    this.id,
    this.name,
    this.photoName,
    this.price,
    this.firebaseId
  });

  //toString
  @override
  String toString() {
    return 'ProductEntity{id: $id, productName: $name, photoName: $photoName, price: $price, firebaseId: $firebaseId}';
  }

  factory ProductEntity.fromJson(Map<String, dynamic> json) => ProductEntity(
    id: json["productId"] ?? 0,
    name: json["productName"] ?? "",
    photoName: json["urlImage"] ?? "",
    price: json["price"] ?? "",
    firebaseId: json["firebaseId"] ?? "",
  );

  ProductEntity copyWith({
    int? id,
    String? name,
    String? photoName,
    double? price,
    String? firebaseId,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      photoName: photoName ?? this.photoName,
      price: price ?? this.price,
      firebaseId: firebaseId ?? this.firebaseId,
    );
  }

  Map<String, dynamic> toJson() => {
    "productId": id,
    "productName": name,
    "urlImage": photoName,
    "price": price,
    "firebaseId": firebaseId,
  };

  factory ProductEntity.emptyProduct() => ProductEntity();

}