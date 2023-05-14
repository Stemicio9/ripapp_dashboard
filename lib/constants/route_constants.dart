
import 'package:ripapp_dashboard/pages/forgot_password/forgot_password.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/add_demise.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/dashboard_agency.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/dashboard.dart';
import 'package:ripapp_dashboard/pages/login_section/login.dart';

class RouteConstants {
  static const String login = "/login";
  static const String dashboard = "/dashboard";
  static const String dashboardAgency = "/dashboardagency";
  static const String forgotPassword = "/forgotpassword";
  static const String addDemise = "/adddemise";



  static dynamic route(context) => {
    '/': (context) =>  Login(),
    login: (context) => Login(),
    dashboard: (context) => Dashboard(),
    dashboardAgency: (context) => DashboardAgency(),
    forgotPassword: (context) => ForgotPassword(),
    addDemise: (context) => AddDemise(),



  };
}