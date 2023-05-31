class UserEntity {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? city;
  String? phoneNumber;
  String? role;

  UserEntity({
    this.id,
    this.lastName,
    this.firstName,
    this.email,
    this.city,
    this.phoneNumber,
    this.role
  });

  //toString
  @override
  String toString() {
    return 'UserEntity{id: $id, firstName: $firstName, lastName: $lastName, email: $email, city: $city, phonenumber:$phoneNumber, role:$role';
  }

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        id: json["id"] ?? "",
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
        email: json["email"] ?? "",
        city: json["city"] ?? "",
        phoneNumber: json["phoneNumber"] ?? "",
        role: json["role"] ?? "",

  );

  UserEntity copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? city,
    String? phoneNumber,
    String? role,
  }) {
    return UserEntity(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      city: city ?? this.city,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,

    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "city": city,
        "phoneNumber": phoneNumber,
        "role": role,

  };
}
