
import 'package:ripapp_dashboard/data_table/data_table_widget/table_row_element.dart';
import 'package:ripapp_dashboard/utils/ResultSet.dart';

class AgencyEntity implements ResultEntity, TableRowElement {
  int? id;
  String? agencyName;
  String? email;
  String? city;
  String? phoneNumber;


  AgencyEntity({
    this.id,
    this.agencyName,
    this.email,
    this.city,
    this.phoneNumber
  });

  //toString
  @override
  String toString() {
    return 'AgencyEntity{agencyid: $id, name: $agencyName, email: $email, address: $city, telephoneNumber:$phoneNumber }';
  }

  factory AgencyEntity.fromJson(Map<String, dynamic> json) => AgencyEntity(
    id: json["agencyid"] ?? "",
    agencyName: json["name"] ?? "",
    email: json["email"] ?? "",
    city: json["address"] ?? "",
    phoneNumber: json["telephoneNumber"] ?? "",

  );

  AgencyEntity copyWith({
    int? id,
    String? agencyName,
    String? email,
    String? city,
    String? phoneNumber,

  }) {
    return AgencyEntity(
      id: id ?? this.id,
      agencyName: agencyName ?? this.agencyName,
      email: email ?? this.email,
      city: city ?? this.city,
      phoneNumber: phoneNumber ?? this.phoneNumber,

    );
  }

  Map<String, dynamic> toJson() => {
    "agencyid": id,
    "name": agencyName,
    "email": email,
    "address": city,
    "telephoneNumber": phoneNumber,

  };
  factory AgencyEntity.emptyAgency() => AgencyEntity();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AgencyEntity &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  List<String> getHeaders() {
    return [
      "ID",
      "Nome",
      "Email",
      "Città",
      "Telefono",
      ""
    ];
  }

  @override
  List<RowElement> rowElements() {
    return [
      RowElement(isText: true, isImage: false, isIcon: false, element: id.toString()),
      RowElement(isText: true, isImage: false, isIcon: false,element: agencyName ?? ""),
      RowElement(isText: true, isImage: false, isIcon: false,element: email ?? ""),
      RowElement(isText: true, isImage: false, isIcon: false,element: city ?? ""),
      RowElement(isText: true, isImage: false, isIcon: false,element: phoneNumber ?? ""),
    ];
  }
}
