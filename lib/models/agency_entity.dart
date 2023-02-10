class AgencyEntity {
  String? id;
  String? agencyName;
  String? email;
  String? city;
  String? phoneNumber;


  AgencyEntity({
    this.id,
    this.agencyName,
    this.email,
    this.city,
    this.phoneNumber
  });

  //toString
  @override
  String toString() {
    return 'UserEntity{id: $id, agencyName: $agencyName, email: $email, city: $city, phoneNumber:$phoneNumber ';
  }

  factory AgencyEntity.fromJson(Map<String, dynamic> json) => AgencyEntity(
    id: json["id"] ?? "",
    agencyName: json["agencyName"] ?? "",
    email: json["email"] ?? "",
    city: json["city"] ?? "",
    phoneNumber: json["phoneNumber"] ?? "",

  );

  AgencyEntity copyWith({
    String? id,
    String? agencyName,
    String? email,
    String? city,
    String? phoneNumber,

  }) {
    return AgencyEntity(
      id: id ?? this.id,
      agencyName: agencyName ?? this.agencyName,
      email: email ?? this.email,
      city: city ?? this.city,
      phoneNumber: phoneNumber ?? this.phoneNumber,

    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "agencyName": agencyName,
    "email": email,
    "city": city,
    "phoneNumber": phoneNumber,

  };
}
