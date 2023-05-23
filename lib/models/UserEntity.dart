// To parse this JSON data, do
//
//     final userEntity = userEntityFromJson(jsonString);

import 'dart:convert';
/*
import 'package:ripapp_dashboard/models/CityEntity.dart';
import 'package:ripapp_dashboard/models/UserStatusEnum.dart';
import 'package:ripapp_dashboard/models/agency_entity.dart';

UserEntity userEntityFromJson(String str) => UserEntity.fromJson(json.decode(str));

String userEntityToJson(UserEntity data) => json.encode(data.toJson());
class UserEntity {
  UserEntity({
    required this.accountid,
    required this.name,
    required this.surname,
    required this.email,
    required this.prefix,
    required this.phone,
    required this.notif,
    required this.cities,
    required this.idtoken,
    required this.photourl,
    required this.status,
    required this.agency,
  });

  int accountid;
  String idtoken;
  String name;
  String surname;
  String email;
  String prefix;
  String phone;
  bool notif;
  List<CityEntity> cities;
  String photourl;
  UserStatus status;
  AgencyEntity? agency;

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
      accountid: json["accountid"],
      idtoken: json["idtoken"] ?? "",
      name: json["name"],
      surname: json["surname"],
      email: json["email"],
      prefix: json["prefix"],
      phone: json["phone"],
      notif: json["notif"],
      cities: json["cities"] != null ? List<CityEntity>.from(json["cities"].map((x) => CityEntity.fromJson(x))) : [],
      photourl: json["photourl"],
      status: json["status"] != null ? userStatusFromString(json["status"]) : UserStatus.notfound,
      agency: json["agency"]
  );

  Map<String, dynamic> toJson() => {
    "accountid": accountid,
    "idtoken": idtoken,
    "name": name,
    "surname": surname,
    "email": email,
    "prefix": prefix,
    "phone": phone,
    "notif": notif,
    "cities": cities != null ? List<dynamic>.from(cities.map((x) => x.toJson())) : null,
    "photourl": photourl,
    "status": userStatusToString(status),
    "agency": agency
  };

  factory UserEntity.defaultAgency() => UserEntity(
      accountid: 0,
      idtoken: "",
      name: "",
      surname: "",
      email: "",
      prefix: "",
      phone: "",
      notif: false,
      cities: [],
      photourl: "",
      // todo change here to not active
      status: UserStatus.agency,
      agency: null
  );
}

 */