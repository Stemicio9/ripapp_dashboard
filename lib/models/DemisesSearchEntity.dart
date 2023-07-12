// To parse this JSON data, do
//
//     final demisesSearchEntity = demisesSearchEntityFromJson(jsonString);

import 'dart:convert';

import 'package:ripapp_dashboard/models/city_from_API.dart';

DemisesSearchEntity demisesSearchEntityFromJson(String str) => DemisesSearchEntity.fromJson(json.decode(str));

String demisesSearchEntityToJson(DemisesSearchEntity data) => json.encode(data.toJson());

class DemisesSearchEntity {
  DemisesSearchEntity({
    required this.cities,
    required this.sorting,
    required this.offset,
  });

  List<CityFromAPI> cities;
  SearchSorting sorting;
  int offset;

  factory DemisesSearchEntity.fromJson(Map<String, dynamic> json) => DemisesSearchEntity(
    cities: List<CityFromAPI>.from(json["cities"].map((x) => x)),
    sorting: json["sorting"] != null ? searchSortingFromString(json["sorting"]) : SearchSorting.surname,
    offset: json["offset"],
  );

  Map<String, dynamic> toJson() => {
    "cities": List<CityFromAPI>.from(cities.map((x) => x)),
    "sorting": searchSortingToString(sorting),
    "offset": offset,
  };
  @override
  String toString() {
   return '{cities: $cities}';
  }
}

enum SearchSorting {
  date, name, surname
}

String searchSortingToString(SearchSorting type) {
  if(type == null) {
    return "";
  }
  return '$type'.split('.').last;
}

SearchSorting searchSortingFromString(String type) {
  if(type == null) {
    return SearchSorting.surname;
  }
  return SearchSorting.values.firstWhere((element) => element.toString().split(".").last == type, orElse: null);
}
