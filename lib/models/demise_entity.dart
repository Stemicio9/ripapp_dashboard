
import 'dart:convert';

import 'package:ripapp_dashboard/models/CityEntity.dart';
import 'package:ripapp_dashboard/models/relative_entity.dart';

class DemiseEntity {
  int? id;
  String? firstName;
  String? lastName;
  CityEntity? city;
  String? phoneNumber;
  int? age;
  DateTime? deceasedDate;
  String? wakeAddress;
  DateTime? wakeDateTime;
  String? wakeNote;
  String? funeralAddress;
  DateTime? funeralDateTime;
  String? funeralNotes;
  List<CityEntity>? cities;
  RelativeEntity? relative;

  DemiseEntity({
    this.id,
    this.firstName,
    this.lastName,
    this.city,
    this.phoneNumber,
    this.age,
    this.deceasedDate,
    this.wakeAddress,
    this.wakeDateTime,
    this.funeralAddress,
    this.wakeNote,
    this.funeralDateTime,
    this.funeralNotes,
    this.cities,
    this.relative
  });

  //toString
  @override
  String toString() {
    return
      'UserEntity{demiseid: $id, '
          'firstName: $firstName, '
          'lastName: $lastName, '
          'city: $city, '
          'phoneNumber: $phoneNumber, '
          'funeralAddress: $funeralAddress, '
          'wakeAddress: $wakeAddress}\n';
  }

  /* campi complicati:
  city
deceasedDate
wakeDateTime
funeralDateTime
cities
relative*/
  factory DemiseEntity.fromJson(Map<String, dynamic> json) => DemiseEntity(
      id: json["demiseid"] ?? "",
      firstName: json["name"] ?? "",
      lastName: json["surname"] ?? "",
      city: json["city"] == null ? null : CityEntity.fromJson(json["city"]),
      phoneNumber: json["phonenumber"] ?? "",
      age: json["age"] ?? "",
      deceasedDate: json["deceasedDate"] == null ? null : DateTime.parse(json["deceasedDate"]),
      wakeAddress: json["wakeaddress"] ?? "",
      wakeDateTime: json["wakets"] == null ? null : DateTime.parse(json["wakets"]),
      funeralAddress: json["funeraladdress"] ?? "",
      wakeNote: json["wakenotes"] ?? "",
      funeralDateTime: json["funeralts"] == null ? null : DateTime.parse(json["funeralts"]),
      funeralNotes: json["funeralnotes"] ?? "",
      /*cities: json["cities"] todo aggiungere questi due campi!!
        .map((data) => CityEntity.fromJson(data))
        .toList(),
      relative: json["relatives"] ?? "",*/
  );

  DemiseEntity copyWith({
    int? id,
    String? firstName,
    String? lastName,
    CityEntity? city,
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
  "demiseid":id,
  "name":firstName,
  "surname":lastName,
  "city":city?.toJson() ?? null,
  "phonenumber":phoneNumber,
  "age":age,
  "ts":deceasedDate == null ? null : wakeDateTime!.toIso8601String(),
  "wakeaddress":wakeAddress,
  "wakets": wakeDateTime == null ? null : wakeDateTime!.toIso8601String(),
  "funeraladdress":funeralAddress,
  "wakenotes":wakeNote,
  "funeralts":funeralDateTime == null ? null : funeralDateTime!.toIso8601String(),
  "funeralnotes":funeralNotes,
  "cities": cities?.map((e) => e.toJson()).toList() ?? [],
  "relatives":relative?.toJson() ?? null,
  };

  factory DemiseEntity.emptyDemise() => DemiseEntity();
}
