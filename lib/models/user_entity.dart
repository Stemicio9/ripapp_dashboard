import 'dart:convert';

import 'package:ripapp_dashboard/models/CityEntity.dart';
import 'package:ripapp_dashboard/models/UserStatusEnum.dart';
import 'package:ripapp_dashboard/models/agency_entity.dart';

String userEntityToJson(UserEntity data) => json.encode(data.toJson());

class UserEntity {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  List<CityEntity>? city;
  String? phoneNumber;
  String? idtoken;
  UserStatus? status;
  String? password;
  String? role;
  AgencyEntity? agency;

  UserEntity(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.city,
      this.phoneNumber,
      this.idtoken,
      this.status,
      this.password,
      this.agency,
      this.role});

  //toString
  @override
  String toString() {
    return 'UserEntity{id: $id, firstName: $firstName, lastName: $lastName, email: $email, city: $city, phonenumber:$phoneNumber, idtoken:$idtoken, status:$status, role:$role';
  }

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
      id: json["id"] ?? "",
      firstName: json["firstName"] ?? "",
      lastName: json["lastName"] ?? "",
      email: json["email"] ?? "",
      city: json["city"] ?? "",
      phoneNumber: json["phoneNumber"] ?? "",
      idtoken: json["idtoken"] ?? "",
      status: json["status"],
      agency: json["agency"],
      role: json["role"]);

  UserEntity copyWith(
      {String? id,
      String? firstName,
      String? lastName,
      String? email,
      List<CityEntity>? city,
      String? phoneNumber,
      String? idtoken,
      String? role,
      UserStatus? status}) {
    return UserEntity(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        city: city ?? this.city,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        idtoken: idtoken ?? this.idtoken,
        status: status ?? this.status,
        role: role ?? this.role);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "city": city?.map((e) => e.toJson()).toList() ?? [],
        "phoneNumber": phoneNumber,
        "idtoken": idtoken,
        "status": status?.name ?? "",
        "role": role ?? "",
        "agency": agency?.toJson() ?? null
      };

// this.tags != null ? this.tags.map((i) => i.toJson()).toList() : null;
}
