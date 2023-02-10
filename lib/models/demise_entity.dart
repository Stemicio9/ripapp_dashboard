class DemiseEntity {
  String? id;
  String? firstName;
  String? lastName;
  String? city;
  String? churchName;
  String? churchAddress;
  String? description;
  String? phoneNumber;





  DemiseEntity({
    this.id,
    this.firstName,
    this.lastName,
    this.city,
    this.phoneNumber,
    this.churchAddress,
    this.churchName,
    this.description
  });

  //toString
  @override
  String toString() {
    return
      'UserEntity{id: $id, firstName: $firstName, lastName: $lastName, city: $city, phoneNumber: $phoneNumber, churchAddress: $churchAddress, churchName: $churchName, description: $description';
  }

  factory DemiseEntity.fromJson(Map<String, dynamic> json) => DemiseEntity(
    id: json["id"] ?? "",
    firstName: json["firstName"] ?? "",
    lastName: json["lastName"] ?? "",
    city: json["city"] ?? "",
    phoneNumber: json["phoneNumber"] ?? "",
    churchAddress: json["churchAddress"] ?? "",
    churchName: json["churchName"] ?? "",
    description: json["description"] ?? "",
  );

  DemiseEntity copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? city,
    String? phoneNumber,
    String? churchAddress,
    String? churchName,
    String? description,
  }) {
    return DemiseEntity(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      city: city ?? this.city,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      churchAddress: churchAddress ?? this.churchAddress,
      churchName: churchName ?? this.churchName,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "city": city,
    "phoneNumber": phoneNumber,
    "churchAddress": churchAddress,
    "churchName": churchName,
    "description": description,
  };
}
