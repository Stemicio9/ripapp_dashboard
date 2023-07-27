import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget/table_row_element.dart';
import 'package:ripapp_dashboard/models/CityEntity.dart';
import 'package:ripapp_dashboard/models/UserStatusEnum.dart';
import 'package:ripapp_dashboard/models/agency_entity.dart';
import 'package:ripapp_dashboard/models/city_from_API.dart';
import 'package:ripapp_dashboard/utils/ResultSet.dart';

String userEntityToJson(UserEntity data) => json.encode(data.toJson());

class UserEntity implements ResultEntity, TableRowElement  {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  List<CityFromAPI>? city;
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

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    var cityList = json["city"];
    var resultCityList = List<CityFromAPI>.empty(growable: true);
    if(cityList != null && cityList.length > 0){
      for(int i = 0; i< cityList.length; i++){
        Map<String, dynamic> cityMap = cityList[i];
        CityFromAPI city = CityFromAPI(name: cityMap["name"]);
        resultCityList.add(city);
      }
    }
    return UserEntity(
        id: json["accountid"] ?? 0,
        firstName: json["name"] ?? "",
        lastName: json["surname"] ?? "",
        email: json["email"] ?? "",
       // city: (json["city"] as List).isNotEmpty ? (json["city"]).map((e) => CityFromAPI.fromJson(e)).toList() : List.empty(),
        city: resultCityList,
        phoneNumber: json["phone"] ?? "",
        idtoken: json["idtoken"] ?? "",
        agency: json["agency"] != null
            ? AgencyEntity.fromJson(json["agency"])
            : null,
        role: json["role"] ?? "",
        status: UserStatus.fromJson(json['status'])
    );
  }

  UserEntity copyWith(
      {int? id,
      String? firstName,
      String? lastName,
      String? email,
      List<CityFromAPI>? city,
      String? phoneNumber,
      String? idtoken,
      String? role,
      UserStatus? status,
      AgencyEntity? agency}) {
    return UserEntity(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        city: city ?? this.city,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        idtoken: idtoken ?? this.idtoken,
         status: status ?? this.status,
        agency: agency ?? this.agency,
     //   role: role ?? this.role
    );
  }

  Map<String, dynamic> toJson()  {
    var cityList = city?.map((e) => e.toJson()).toList();
        return {
          "accountid": id,
          "name": firstName,
          "surname": lastName,
          "email": email,
          "city": cityList,
          "phone": phoneNumber,
          "idtoken": idtoken,
          "status":  status?.toJson(),
          "agency": agency?.toJson()
        };
      }


  factory UserEntity.defaultUser() => UserEntity(
      firstName: "",
      lastName: "",
      email: "",
      city: [],
      phoneNumber: "",
      idtoken: "",
      status: UserStatus.notfound,
      role: "",
  );

  factory UserEntity.emptyUser() => UserEntity();

  @override
  List<String> getHeaders() {
    return [
      "ID",
      "Nome",
      "Cognome",
      "Email",
      "Telefono",
      "Ruolo",
      "Nome Agenzia",
      ""
    ];
  }

  @override
  List<RowElement> rowElements() {
    return [
      RowElement(isText: true, isImage: false, isIcon: false, element: id.toString()),
      RowElement(isText: true, isImage: false, isIcon: false, element: firstName ?? ""),
      RowElement(isText: true, isImage: false, isIcon: false, element: lastName ?? ""),
      RowElement(isText: true, isImage: false, isIcon: false, element: email ?? ""),
      RowElement(isText: true, isImage: false, isIcon: false, element: phoneNumber ?? ""),
      RowElement(isText: true, isImage: false, isIcon: false, element: status.toString() == 'UserStatus.active' ? 'Utente' :
      status.toString() == 'UserStatus.agency' ? 'Agenzia' :
      'Amministratore',
      ),
      status.toString() == 'UserStatus.agency' ?  RowElement(
          isText: true,
          isImage: false,
          isIcon: false,
          element: agency!.agencyName!,
      ) : RowElement(
        isText: false,
        isImage: false,
        isIcon: true,
        iconData: Icons.cancel_rounded,
        color: rossoopaco,
        element: '',
      ),
    ];
  }



// this.tags != null ? this.tags.map((i) => i.toJson()).toList() : null;
}
