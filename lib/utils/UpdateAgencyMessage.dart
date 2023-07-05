import 'package:ripapp_dashboard/models/agency_entity.dart';

class UpdateAgencyMessage {
  String? message;
  AgencyEntity? agencyUpdated;

  UpdateAgencyMessage({required this.agencyUpdated, required this.message});

  factory UpdateAgencyMessage.fromJson(Map<String, dynamic> json) => UpdateAgencyMessage(
    agencyUpdated: json["agencyUpdated"] != null ? AgencyEntity.fromJson(json["agencyUpdated"]) : null,
    message: json["message"] ?? "",
  );

  factory UpdateAgencyMessage.defaultUpdateAgencyMessage() => UpdateAgencyMessage(
    agencyUpdated: null,
    message: ""
  );


  Map<String, dynamic> toJson() => {
    "agencyUpdated": agencyUpdated?.toJson() ?? null,
    "message": message,
  };

  @override
  String toString() {
    return 'SaveAgencyMessage{agencyUpdated: $agencyUpdated, message: $message}';
  }
}
