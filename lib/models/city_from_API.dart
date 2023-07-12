import 'package:ripapp_dashboard/models/CityEntity.dart';

class CityFromAPI {
  String? codice;
  String? name;
  String? nomeStraniero;
  String? codiceCatastale;
  String? cap;
  String? prefisso;
  dynamic provincia; //provincia={nome=Vibo Valentia, regione=Calabria}
  String? email;
  String? pec;
  String? telefono;
  String? fax;
  dynamic coordinate; // coordinate={lat=38.65, lng=15.9833}

  CityFromAPI(
      {
        this.codice,
      this.name,
      this.nomeStraniero,
      this.codiceCatastale,
      this.cap,
      this.prefisso,
      this.provincia,
      this.email,
      this.pec,
      this.telefono,
      this.fax,
      this.coordinate});

  factory CityFromAPI.fromJson(Map<String, dynamic> json)
  {

    return CityFromAPI(
        codice: json["codice"] ?? "",
        name: json["nome"] ?? json["name"] ?? "" ?? ["cityname"],
        nomeStraniero: json["nomeStraniero"] ?? "",
        codiceCatastale: json["codiceCatastale"] ?? "",
        cap: json["cap"] ?? "",
        prefisso: json["prefisso"] ?? "",
        provincia: json["provincia"] ?? "",
        email: json["email"] ?? "",
        pec: json["pec"] ?? "",
        telefono: json["telefono"] ?? "",
        fax: json["fax"] ?? "",
        coordinate: json["coordinate"] ?? "");
  }

  Map<String, dynamic> toJson() => {
        "codice": codice,
        "name": name,
        "nomeStraniero": nomeStraniero,
        "codiceCatastale": codiceCatastale,
        "cap": cap,
        "prefisso": prefisso,
        "provincia": provincia,
        "email": email,
        "pec": pec,
        "telefono": telefono,
        "fax": fax,
        "coordinate": coordinate
      };

  factory CityFromAPI.defaultCity() => CityFromAPI(
      codice: "",
      name: "",
      nomeStraniero: "",
      codiceCatastale: "",
      cap: "",
      prefisso: "",
      provincia: {},
      email: "",
      pec: "",
      telefono: "",
      fax: "",
      coordinate: {});



  @override
  String toString() {
    return '{name: $name}';
  }
  factory CityFromAPI.emptyCity() => CityFromAPI();

}
