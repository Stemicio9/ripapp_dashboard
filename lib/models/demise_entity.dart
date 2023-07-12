import 'dart:convert';

import 'package:ripapp_dashboard/models/CityEntity.dart';
import 'package:ripapp_dashboard/models/city_from_API.dart';
import 'package:ripapp_dashboard/models/relative_entity.dart';

class DemiseEntity {

  //deceased data
  int? id;
  String? firstName;
  String? lastName;
  CityEntity? city;
  String? phoneNumber;
  int? age;
  List<CityFromAPI>? cities;
  List<CityEntity>? cityEntities;
  DateTime? deceasedDate;


  //wake data
  String? wakeAddress;
  DateTime? wakeDateTime;
  String? wakeNotes;


  //funeral data
  String? funeralAddress;
  DateTime? funeralDateTime;
  String? funeralNotes;


  //relative data
  RelativeEntity? relative;
  String? firebaseid;


  DemiseEntity({
    this.id,
    this.firstName,
    this.lastName,
    this.city,
    this.phoneNumber,
    this.age,
    this.cities,
    this.cityEntities,
    this.deceasedDate,


    //this.deceasedDate,
    this.wakeAddress,
    this.wakeDateTime,
    this.wakeNotes,


    this.funeralAddress,
    this.funeralDateTime,
    this.funeralNotes,


    this.relative,
    this.firebaseid
  });

  //toString
  @override
  String toString() {
    return
      'DemiseEntity{'
          'demiseid: $id, '
          'name: $firstName, '
          'surname: $lastName, '
          'city: $city, '
          'age: $age, '
          'phonenumber: $phoneNumber, '
          'ts: $deceasedDate, '
          'cities: $cities, '


          'funeralAddress: $funeralAddress, '
          'funeralts: $funeralDateTime '
          'funeralnotes: $funeralNotes '



          'wakenotes: $wakeNotes, '
          'wakets: $wakeDateTime, '
          'firebaseid: $firebaseid, '
          'wakeAddress: $wakeAddress}\n';

  }

  factory DemiseEntity.fromJson(Map<String, dynamic> json) {
    print("SONO NEL FROM JSON DEMISE");
    print(json);
    List<dynamic>? cities = json["cities"];
    if(cities != null) {
      if (cities.isEmpty) {
        cities = null;
      }
    }
    List<CityEntity> definitiveCities = [];
    if(cities != null){
      definitiveCities = cities.map((e) => CityEntity.fromJson(e)).toList();
    }
    print("CE LA FACCIAMO?");
    print(cities);
    print(definitiveCities);
    print("PRINTO");



    return DemiseEntity(
      id: json["demiseid"] ?? 0,
      firstName: json["name"] ?? "",
      lastName: json["surname"] ?? "",
      city: json["city"] == null ? null : CityEntity.fromJson(json["city"]),
      phoneNumber: json["phonenumber"] ?? "",
      age: json["age"] ?? 0,
      deceasedDate: json["ts"] == null ? null : DateTime.parse(json["ts"]),


      wakeAddress: json["wakeaddress"] ?? "",
      wakeDateTime: json["wakets"] == null ? null : DateTime.parse(
          json["wakets"]),
      wakeNotes: json["wakenotes"] ?? "",


      funeralAddress: json["funeraladdress"] ?? "",
      funeralDateTime: json["funeralts"] == null ? null : DateTime.parse(
          json["funeralts"]),
      funeralNotes: json["funeralnotes"] ?? "",
      firebaseid: json["firebaseid"] ?? "",
      //cities: definitiveCities,
      cityEntities: definitiveCities,
      //relative: json["relatives"] ?? "",
    );
  }


  DemiseEntity copyWith({
    int? id,
    int? age,
    String? firstName,
    String? lastName,
    CityEntity? city,
    String? phoneNumber,
    DateTime? deceasedDate,
    List<CityFromAPI>? cities,


    String? funeralAddress,
    DateTime? funeralDateTime,
    String? funeralNotes,

    String? wakeAddress,
    DateTime? wakeDateTime,
    String? wakeNotes,
  }) {
    return DemiseEntity(
      id: id ?? this.id,
      age: age ?? this.age,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      city: city ?? this.city,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      deceasedDate: deceasedDate ?? this.deceasedDate,
      cities: cities?? this.cities,


      wakeAddress: wakeAddress ?? this.wakeAddress,
      wakeDateTime: wakeDateTime ?? this.wakeDateTime,
      wakeNotes: wakeNotes ?? this.wakeNotes,


      funeralAddress: funeralAddress ?? this.funeralAddress,
      funeralNotes: funeralNotes ?? this.funeralNotes,
      funeralDateTime: funeralDateTime ?? this.funeralDateTime,

    );
  }


  Map<String, dynamic> toJson() => {

    "demiseid":id,
    "name":firstName,
    "surname":lastName,
    "city":city?.toJson(),
    "phonenumber":phoneNumber,
    "firebaseid":firebaseid,
    "age":age,
    "ts":deceasedDate == null ? null : deceasedDate!.toIso8601String(),
    "cities": cityEntities?.map((city) => city.toJson()).toList(),
    //"cityEntities": cityEntities?.map((city) => city.toJson()).toList() ?? [],


    "wakeaddress":wakeAddress,
    "wakets": wakeDateTime == null ? null : wakeDateTime!.toIso8601String(),
    "wakenotes":wakeNotes,


    "funeraladdress":funeralAddress,
    "funeralts":funeralDateTime == null ? null : funeralDateTime!.toIso8601String(),
    "funeralnotes":funeralNotes,

    "relatives":relative?.toJson(),
  };
  factory DemiseEntity.defaultDemise() => DemiseEntity(
    id: 0,
    firstName: "",
    lastName: "",
    cities: [],

  );

  factory DemiseEntity.emptyDemise() => DemiseEntity();
}
