class AgencyEntity {
  String? id;
  String? agencyName;
  String? email;
  String? city;

  AgencyEntity({
    this.id,
    this.agencyName,
    this.email,
    this.city,
  });

  //toString
  @override
  String toString() {
    return 'UserEntity{id: $id, agencyName: $agencyName, email: $email, city: $city';
  }

  factory AgencyEntity.fromJson(Map<String, dynamic> json) => AgencyEntity(
    id: json["id"] ?? "",
    agencyName: json["agencyName"] ?? "",
    email: json["email"] ?? "",
    city: json["city"] ?? "",
  );

  AgencyEntity copyWith({
    String? id,
    String? agencyName,
    String? email,
    String? city,
  }) {
    return AgencyEntity(
      id: id ?? this.id,
      agencyName: agencyName ?? this.agencyName,
      email: email ?? this.email,
      city: city ?? this.city,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "agencyName": agencyName,
    "email": email,
    "city": city,
  };
}
