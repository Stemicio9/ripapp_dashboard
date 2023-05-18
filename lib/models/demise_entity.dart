class DemiseEntity {
  String? id;
  String? firstName;
  String? lastName;
  String? city;
  String? wakeAddress;
  String? funeralAddress;
  String? phoneNumber;





  DemiseEntity({
    this.id,
    this.firstName,
    this.lastName,
    this.city,
    this.phoneNumber,
    this.wakeAddress,
    this.funeralAddress,
  });

  //toString
  @override
  String toString() {
    return
      'UserEntity{id: $id, firstName: $firstName, lastName: $lastName, city: $city, phoneNumber: $phoneNumber, funeralAddress: $funeralAddress, wakeAddress: $wakeAddress';
  }

  factory DemiseEntity.fromJson(Map<String, dynamic> json) => DemiseEntity(
    id: json["id"] ?? "",
    firstName: json["firstName"] ?? "",
    lastName: json["lastName"] ?? "",
    city: json["city"] ?? "",
    phoneNumber: json["phoneNumber"] ?? "",
    wakeAddress: json["wakeAddress"] ?? "",
    funeralAddress: json["funeralAddress"] ?? "",
  );

  DemiseEntity copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? city,
    String? phoneNumber,
    String? funeralAddress,
    String? wakeAddress,
  }) {
    return DemiseEntity(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      city: city ?? this.city,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      wakeAddress: wakeAddress ?? this.wakeAddress,
      funeralAddress: funeralAddress ?? this.funeralAddress,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "city": city,
    "phoneNumber": phoneNumber,
    "wakeAddress": wakeAddress,
    "funeralAddress": funeralAddress,
  };
}
