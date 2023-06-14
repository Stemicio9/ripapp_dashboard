enum Kinship {
  notfound,
  son,
  daughter,
  nephew,
  uncle,
  aunt,
  father,
  mother,
  wife,
  brother,
  sister,
  grandmother,
  grandfather,
  husband,
  mother_in_law,
  father_in_law,
  son_in_law,
  daughter_in_law,
  brother_in_law,
  sister_in_law,
  cousin_m,
  cousin_f,
  grandniece_m,
  grandniece_f,
  nephew_f;
  /*notfound,
  Madre,
  Padre,
  Fratello,
  Sorella,
  Figlio,
  Figlia,
  Nonno,
  Nonna;*/


  String toJson() => name;
  static Kinship fromJson(String json) => values.byName(json);
}

String kinshipToString(Kinship? type) {
  if (type == null) {
    return "";
  }
  return '$type'.split('.').last;
}

Kinship kinshipFromString(String type) {
  if (type == null) {
    return Kinship.notfound;
  }
  return Kinship.values.firstWhere(
          (element) => element.toString().split(".").last == type,
      orElse: null);
}