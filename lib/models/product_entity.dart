class ProductEntity {
  String? id;
  String? name;
  String? description;
  String? price;

  ProductEntity({
    this.id,
    this.name,
    this.description,
    this.price,
  });

  //toString
  @override
  String toString() {
    return 'UserEntity{id: $id, name: $name, description: $description, price: $price,';
  }

  factory ProductEntity.fromJson(Map<String, dynamic> json) => ProductEntity(
    id: json["id"] ?? "",
    name: json["name"] ?? "",
    description: json["description"] ?? "",
    price: json["price"] ?? "",
  );

  ProductEntity copyWith({
    String? id,
    String? name,
    String? description,
    String? price,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "price": price,
  };
}
