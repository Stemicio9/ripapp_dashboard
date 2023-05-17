class ProductEntity {
  String? id;
  String? name;
  String? photoName;
  String? price;

  ProductEntity({
    this.id,
    this.name,
    this.photoName,
    this.price,
  });

  //toString
  @override
  String toString() {
    return 'UserEntity{id: $id, name: $name, description: $photoName, price: $price,';
  }

  factory ProductEntity.fromJson(Map<String, dynamic> json) => ProductEntity(
    id: json["id"] ?? "",
    name: json["name"] ?? "",
    photoName: json["photoName"] ?? "",
    price: json["price"] ?? "",
  );

  ProductEntity copyWith({
    String? id,
    String? name,
    String? photoName,
    String? price,
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
    "name": name,
    "photoName": photoName,
    "price": price,
  };
}
