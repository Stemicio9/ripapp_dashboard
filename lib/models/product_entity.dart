class ProductEntity {
  int? id;
  String? name;
  String? photoName;
  double? price;

  ProductEntity({
    this.id,
    this.name,
    this.photoName,
    this.price,
  });

  //toString
  @override
  String toString() {
    return 'UserEntity{id: $id, productName: $name, description: $photoName, price: $price,';
  }

  factory ProductEntity.fromJson(Map<String, dynamic> json) => ProductEntity(
    id: json["id"] ?? 0,
    name: json["productName"] ?? "",
    photoName: json["urlImage"] ?? "",
    price: json["price"] ?? "",
  );

  ProductEntity copyWith({
    int? id,
    String? name,
    String? photoName,
    double? price,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      photoName: photoName ?? this.photoName,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "productName": name,
    "urlImage": photoName,
    "price": price,
  };
}
