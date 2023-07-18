enum Kinship {
  notfound,
  figlio,
  figlia,
  nipote_m,
  zio,
  zia,
  padre,
  madre,
  moglie,
  fratello,
  sorella,
  nonna,
  nonno,
  marito,
  matrigna,
  patrigno,
  figliastro,
  figliastra,
  fratellastro,
  sorellastra,
  cugino,
  cugina,
  pronipote_m,
  pronipote_f,
  nipote_f;
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

extension ParseToString on Kinship {
  String toShortString() {
    return this.toString().split('.').last;
  }
}
/*
String kinshipToString(Kinship? type) {
  if (type == null) {
    return "";
  }
  return '$type'.split('.').last;
}*/

Kinship kinshipFromString(String type) {
  if (type == null) {
    return Kinship.notfound;
  }
  return Kinship.values.firstWhere(
          (element) => element.toString().split(".").last == type,
      orElse: null);
}