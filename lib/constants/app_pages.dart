enum AppPage {
  login,
  adminScaffold,
  agencyScaffold,
}

extension AppPageExtension on AppPage {
  String get path {
    switch (this) {
      case AppPage.login:
        return "/";
      case AppPage.adminScaffold:
        return "/dashboard";
      case AppPage.agencyScaffold:
        return "/dashboardagency";
    }
  }

  String get toName {
    switch (this) {
      case AppPage.login:
        return "LoginPage";
      case AppPage.adminScaffold:
        return "AdminScaffold";
      case AppPage.agencyScaffold:
        return "AgencyScaffold";
    }
  }

  String get toTitle {
    switch (this) {
      case AppPage.login:
        return "Login";
      case AppPage.adminScaffold:
        return "Admin";
      case AppPage.agencyScaffold:
        return "Agency";
    }
  }
}
