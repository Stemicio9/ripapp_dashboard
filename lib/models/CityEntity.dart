
class CityEntity {
  CityEntity({
     this.cityid,
    required this.name,
  });

  int? cityid = 0;
  String name;

  factory CityEntity.fromJson(Map<String, dynamic> json) => CityEntity(
    cityid: json["cityid"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "cityid": cityid,
    "name": name,
  };

  factory CityEntity.defaultCity() => CityEntity(
    cityid: 0,
    name: "Seleziona Città",
  );


  @override
  String toString() {
    return name;
  }
}