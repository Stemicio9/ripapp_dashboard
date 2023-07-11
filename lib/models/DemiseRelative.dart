import 'package:ripapp_dashboard/constants/kinships.dart';
import 'package:ripapp_dashboard/models/demise_entity.dart';
import 'package:ripapp_dashboard/models/user_entity.dart';

class DemiseRelative {
  int? relativeId;
  DemiseEntity? demise; //todo, forse si puo togliere questo campo
  UserEntity? user;
  Kinship? kinshipType;
  String? name;
  String? surname;
  String? email;
  String? telephoneNumber; //? verificare utilizzo di demiserelative.phone in altre classi

  DemiseRelative({
    this.relativeId,
    this.demise,
    this.user,
    this.kinshipType,
    this.name,
    this.surname,
    this.email,
    this.telephoneNumber,
  });

  @override
  String toString() {
    return 'DemiseRelative{relativeId: $relativeId, demise: $demise, user: $user,'
        'kinshipType: $kinshipType, name: $name, surname: $surname,'
        'email: $email, telephoneNumber: $telephoneNumber}';
  }

  factory DemiseRelative.fromJson(Map<String, dynamic> json) => DemiseRelative(
    relativeId: json["productId"] ?? 0,
    demise: json["demise"],
    user: json["user"],
    kinshipType: Kinship.fromJson(json['kinship']),
    name: json["name"],
    surname: json["surname"],
    email: json["email"],
    telephoneNumber: json["phone"]
  );

  DemiseRelative copyWith({
      int? newRelativeId, DemiseEntity? newDemise, UserEntity? newUser,
      Kinship? newKinshipType, String? newName, String? newSurname,
      String? newEmail, String? newTelephoneNumber,}) {
    return DemiseRelative(
        relativeId: newRelativeId ?? this.relativeId,
        demise: newDemise ?? this.demise,
        user: newUser ?? this.user,
        kinshipType: newKinshipType ?? this.kinshipType,
        name: newName ?? this.name,
        surname: newSurname ?? this.surname,
        email: newEmail ?? this.email,
        telephoneNumber: newTelephoneNumber ?? this.telephoneNumber
    );
  }

  Map<String, dynamic> toJson() => {
    "relativeid": relativeId,
    "demise": demise,
    "account": user,
    "kinship": kinshipType,
    "name": name,
    "surname": surname,
    "email": email,
    "phone": telephoneNumber,
  };

  factory DemiseRelative.emptyDemise() => DemiseRelative();
}