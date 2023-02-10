class UserEntity {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? city;
  String? phoneNumber;

  UserEntity({
    this.id,
    this.lastName,
    this.firstName,
    this.email,
    this.city,
    this.phoneNumber
  });

  //toString
  @override
  String toString() {
    return 'UserEntity{id: $id, firstName: $firstName, lastName: $lastName, email: $email, city: $city, phonenumber:$phoneNumber';
  }

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        id: json["id"] ?? "",
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
        email: json["email"] ?? "",
        city: json["city"] ?? "",
        phoneNumber: json["phoneNumber"] ?? "",

  );

  UserEntity copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? city,
    String? phoneNumber,
  }) {
    return UserEntity(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      city: city ?? this.city,
      phoneNumber: phoneNumber ?? this.phoneNumber,

    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "city": city,
        "phoneNumber": phoneNumber,

  };
}
