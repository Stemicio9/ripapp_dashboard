
const String USER = "active";
const String AGENCY = "agency";
const String ADMIN = "admin";
const String NOAUTH = "notfound";


enum AppRole {
   user,
   agency,
   admin,
   noauth
}



extension AppPageExtension on AppRole {
  String get toName {
    switch (this) {
      case AppRole.user:
        return USER;
      case AppRole.agency:
        return AGENCY;
      case AppRole.admin:
        return ADMIN;
      default: return NOAUTH;
    }
  }
}