
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/new_pages/users_manage_page.dart';

enum UserStatus { agency, active, disabled, notfound, admin;

  String toJson() => name;
  static UserStatus fromJson(String json) => values.byName(json);
}

String userStatusToString(UserStatus? type) {
  if (type == null) {
    return "";
  }
  return '$type'.split('.').last;
}

UserStatus userStatusFromString(String type) {
  if (type == null) {
    return UserStatus.notfound;
  }
  return UserStatus.values.firstWhere(
      (element) => element.toString().split(".").last == type,
      orElse: null);
}

UserRoles fromUserStatus(UserStatus status){
  switch(status){
    case UserStatus.agency: return UserRoles.Agenzia;
    case UserStatus.admin: return UserRoles.Amministratore;
    default: return UserRoles.Utente;
  }
}

UserStatus fromUserRole(UserRoles role){
  switch(role){
    case UserRoles.Utente: return UserStatus.active;
    case UserRoles.Amministratore: return UserStatus.admin;
    case UserRoles.Agenzia: return UserStatus.agency;
    default: return UserStatus.active;
  }
}