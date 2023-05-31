
class AgencyEntity {
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
    return 'AgencyEntity{agencyid: $id, agencyName: $agencyName, email: $email, address: $city, telephoneNumber:$phoneNumber }';
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
}
