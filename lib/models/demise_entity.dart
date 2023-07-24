
import 'package:ripapp_dashboard/data_table/data_table_widget/table_row_element.dart';
import 'package:ripapp_dashboard/models/CityEntity.dart';
import 'package:ripapp_dashboard/models/DemiseRelative.dart';
import 'package:ripapp_dashboard/utils/ResultSet.dart';

class DemiseEntity implements ResultEntity, TableRowElement {

  //deceased data
  int? id;
  String? firstName;
  String? lastName;
  CityEntity? city;
  String? phoneNumber;
  int? age;
  List<CityEntity>? cities;
  DateTime? deceasedDate;
  String? photoUrl;


  //wake data
  String? wakeAddress;
  DateTime? wakeDateTime;
  String? wakeNotes;


  //funeral data
  String? funeralAddress;
  DateTime? funeralDateTime;
  String? funeralNotes;



  //relative data
  List<DemiseRelative>? relatives;

  String? firebaseid;


  DemiseEntity({
    this.id,
    this.firstName,
    this.lastName,
    this.city,
    this.phoneNumber,
    this.age,
    this.cities,
    this.deceasedDate,
    this.wakeAddress,
    this.wakeDateTime,
    this.wakeNotes,
    this.funeralAddress,
    this.funeralDateTime,
    this.funeralNotes,
    this.relatives,
    this.firebaseid,
    this.photoUrl
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
          'cities: $cities ,'
          'phonenumber: $phoneNumber, '
          'ts: $deceasedDate, '
          'funeralAddress: $funeralAddress, '
          'funeralts: $funeralDateTime '
          'funeralnotes: $funeralNotes '
          'wakenotes: $wakeNotes, '
          'wakets: $wakeDateTime, '
          'firebaseid: $firebaseid, '
          'wakeAddress: $wakeAddress}'
           'photourl: $photoUrl'
          'relatives: $relatives}\n';
  }

  factory DemiseEntity.fromJson(Map<String, dynamic> json) => DemiseEntity(
    id: json["demiseid"] ?? 0,
    firstName: json["name"] ?? "",
    lastName: json["surname"] ?? "",
    city: json["city"] == null ? null : CityEntity.fromJson(json["city"]),
    phoneNumber: json["phonenumber"] ?? "",
    age: json["age"] ?? 0,
    photoUrl: json["photourl"] ?? "",
    deceasedDate: json["ts"] == null ? null : DateTime.parse(json["ts"]),


    wakeAddress: json["wakeaddress"] ?? "",
    wakeDateTime: json["wakets"] == null ? null : DateTime.parse(json["wakets"]),
    wakeNotes: json["wakenotes"] ?? "",


    funeralAddress: json["funeraladdress"] ?? "",
    funeralDateTime: json["funeralts"] == null ? null : DateTime.parse(json["funeralts"]),
    funeralNotes: json["funeralnotes"] ?? "",
    firebaseid: json["firebaseid"] ?? "",
    relatives: json["relatives"] != null ? (json["relatives"] as List).map((e) => DemiseRelative.fromJson(e)).toList() : [],
    cities: json["cities"] != null ? (json["cities"] as List).map((data) => CityEntity.fromJson(data)).toList() : [],

  );

  DemiseEntity copyWith({
    int? id,
    int? age,
    String? firstName,
    String? lastName,
    CityEntity? city,
    String? phoneNumber,
    String? photoUrl,
    DateTime? deceasedDate,


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
      photoUrl: photoUrl ?? this.photoUrl,


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
    "city":city?.toJson() ?? null,
    "phonenumber":phoneNumber,
    "firebaseid":firebaseid,
    "photourl":photoUrl,
    "age":age,
    "ts":deceasedDate == null ? null : deceasedDate!.toIso8601String(),
    "cities": cities?.map((e) => e.toJson()).toList() ?? [],
    "wakeaddress":wakeAddress,
    "wakets": wakeDateTime == null ? null : wakeDateTime!.toIso8601String(),
    "wakenotes":wakeNotes,
    "funeraladdress":funeralAddress,
    "funeralts":funeralDateTime == null ? null : funeralDateTime!.toIso8601String(),
    "funeralnotes":funeralNotes,
    "relatives":relatives?.map((relative) => relative.toJson()).toList()  ?? [],
  };

  factory DemiseEntity.emptyDemise() => DemiseEntity();


  @override
  List<String> getHeaders() {
    return [
      "ID",
      "Nome",
      "Cognome",
      "Città",
      "Telefono",
      "Indirizzo Chiesa",
      "Indirizzo Veglia",
      ""
    ];
  }

  @override
  List<RowElement> rowElements() {
    return [
      RowElement(isText: true, isImage: false, isIcon: false, element: id.toString()),
      RowElement(isText: true, isImage: false, isIcon: false,element: firstName ?? ""),
      RowElement(isText: true, isImage: false, isIcon: false,element: lastName ?? ""),
      RowElement(isText: true, isImage: false, isIcon: false,element: city?.name ?? ""),
      RowElement(isText: true, isImage: false, isIcon: false,element: phoneNumber ?? ""),
      RowElement(isText: true, isImage: false, isIcon: false,element: funeralAddress ?? ""),
      RowElement(isText: true, isImage: false, isIcon: false,element: wakeAddress ?? ""),
    ];
  }


}
