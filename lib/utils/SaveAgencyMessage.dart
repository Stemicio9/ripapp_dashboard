import 'package:ripapp_dashboard/models/agency_entity.dart';

class SaveAgencyMessage {
  String? message;
  AgencyEntity? agencySaved;

  SaveAgencyMessage({required this.agencySaved, required this.message});

  factory SaveAgencyMessage.fromJson(Map<String, dynamic> json) => SaveAgencyMessage(
    agencySaved: json["agencySaved"] != null ? AgencyEntity.fromJson(json["agencySaved"]) : null,
    message: json["message"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "agencySaved": agencySaved?.toJson() ?? null,
    "message": message,
  };

  @override
  String toString() {
    return 'SaveAgencyMessage{agencySaved: $agencySaved, message: $message}';
  }
}
