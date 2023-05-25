

import 'dart:convert';

import 'package:ripapp_dashboard/models/CityEntity.dart';
import 'package:ripapp_dashboard/models/UserStatusEnum.dart';

String userEntityToJson(UserEntity data) => json.encode(data.toJson());


class UserEntity {
  UserEntity({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.city,
    this.phoneNumber,
    this.idtoken,
    this.status,
    this.password
  });


  String? id;
  String? firstName;
  String? lastName;
  String? email;
  List<CityEntity>? city;
  String? phoneNumber;
  String? idtoken;
  UserStatus? status;
  String? password;
  //toString
  @override
  String toString() {
    return 'UserEntity{id: $id, firstName: $firstName, lastName: $lastName, email: $email, city: $city, phonenumber:$phoneNumber, idtoken:$idtoken, status:$status';
  }

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        id: json["id"] ?? "",
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
        email: json["email"] ?? "",
        city: json["city"] ?? "",
        phoneNumber: json["phoneNumber"] ?? "",
        idtoken: json["idtoken"] ?? "",
        status: json["status"]
  );

  UserEntity copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    List<CityEntity>? city,
    String? phoneNumber,
    String? idtoken,
    UserStatus? status
  }) {
    return UserEntity(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      city: city ?? this.city,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      idtoken: idtoken ?? this.idtoken,
      status: status ?? this.status
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "city": city?.map((e) => e.toJson()).toList() ?? [],
        "phoneNumber": phoneNumber,
        "idtoken": idtoken,
        "status": status?.name ?? ""
  };

  // this.tags != null ? this.tags.map((i) => i.toJson()).toList() : null;
}
