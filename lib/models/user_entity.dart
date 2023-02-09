class UserEntity {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? city;

  UserEntity({
    this.id,
    this.lastName,
    this.firstName,
    this.email,
    this.city,
  });

  //toString
  @override
  String toString() {
    return 'UserEntity{id: $id, firstName: $firstName, lastName: $lastName, email: $email, city: $city';
  }

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        id: json["id"] ?? "",
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
        email: json["email"] ?? "",
        city: json["city"] ?? "",
      );

  UserEntity copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? city,
  }) {
    return UserEntity(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      city: city ?? this.city,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "city": city,
      };
}
