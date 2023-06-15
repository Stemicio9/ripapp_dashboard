import 'dart:convert';
import 'package:ripapp_dashboard/models/UserStatusEnum.dart';
import 'package:ripapp_dashboard/models/CityEntity.dart';
import 'package:ripapp_dashboard/models/agency_entity.dart';

String userEntityToJson(UserEntity data) => json.encode(data.toJson());

class UserEntity {
  int? id;
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
    return 'UserEntity{accountid: $id, name: $firstName, surname: $lastName, email: $email,'
        ' city: $city, phone:$phoneNumber, idtoken:$idtoken, status:$status, role:$role, agency:$agency}';
  }

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
      id: json["accountid"] ?? 0,
      firstName: json["name"] ?? "",
      lastName: json["surname"] ?? "",
      email: json["email"] ?? "",
      city: (json["city"] as List).map((e) => CityEntity.fromJson(e)).toList() ?? List.empty(),
      phoneNumber: json["phone"] ?? "",
      idtoken: json["idtoken"] ?? "",
       // status: json["status"] != null && (json["status"] as String).isNotEmpty ? UserStatus.values.firstWhere((e) => e.toString() == json["status"]) : UserStatus.active,
      agency: json["agency"] != null ? AgencyEntity.fromJson(json["agency"]) : null,
      role: json["role"] ?? "",
      status: UserStatus.fromJson(json['status'])
  );

  UserEntity copyWith(
      {int? id,
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
      //  status: status ?? this.status,
        role: role ?? this.role);
  }

  Map<String, dynamic> toJson() => {
        "accountid": id,
        "name": firstName,
        "surname": lastName,
        "email": email,
        "city": city?.map((e) => e.toJson()).toList() ?? [],
        "phone": phoneNumber,
        "idtoken": idtoken,
        "status":  status?.toJson(),
        //"role": role ?? "",
        "agency": agency?.toJson()
      };


  factory UserEntity.defaultUser() => UserEntity(
      id: 0,
      firstName: "",
      lastName: "",
      email: "",
      city: [],
      phoneNumber: "",
      idtoken: "",
      status: UserStatus.notfound,
      role: "",
  );


// this.tags != null ? this.tags.map((i) => i.toJson()).toList() : null;
}
