enum AppPage {
  login,
  adminScaffold,
  agencyScaffold,
  addDemise,
  editDemise,
  demiseDetail,
  forgotPassword,
  checkout
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
      case AppPage.addDemise:
        return "/dashboardagency/adddemise";
      case AppPage.editDemise:
        return "/dashboardagency/editdemise";
      case AppPage.demiseDetail:
        return "/dashboardagency/demisedetail";
      case AppPage.forgotPassword:
        return "/forgotpassword";
      case AppPage.checkout:
        return "/checkout";
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
      case AppPage.addDemise:
        return "AddDemise";
        case AppPage.editDemise:
      return "EditDemise";
      case AppPage.demiseDetail:
      return "DemiseDetail";
      case AppPage.forgotPassword:
        return "ForgotPassword";
      case AppPage.checkout:
        return "Checkout";
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
      case AppPage.addDemise:
        return "Add Demise";
      case AppPage.editDemise:
        return "Edit Demise";
      case AppPage.demiseDetail:
        return "Demise Detail";
      case AppPage.forgotPassword:
        return "Forgot Password";
      case AppPage.checkout:
        return "Checkout";
    }
  }
}
