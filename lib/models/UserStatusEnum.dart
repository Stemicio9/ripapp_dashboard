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