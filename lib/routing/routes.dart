import 'package:go_router/go_router.dart';
import 'package:ripapp_dashboard/authentication/firebase_authentication_listener.dart';
import 'package:ripapp_dashboard/constants/app_pages.dart';
import 'package:ripapp_dashboard/constants/app_roles.dart';
import 'package:ripapp_dashboard/pages/forgot_password/forgot_password.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/dashboard.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/add_demise.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/dashboard_agency.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/demise_detail.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/edit_demise.dart';
import 'package:ripapp_dashboard/pages/login_section/login.dart';

class RouterManager {

  static final RouterManager _router = RouterManager._internal();


  factory RouterManager() {
    return _router;
  }

  RouterManager._internal();


  final GoRouter goRouter =
  GoRouter(
      initialLocation: CustomFirebaseAuthenticationListener().user == null ? AppPage.login.path : getPageByRole(CustomFirebaseAuthenticationListener().role),
      routes: [
        // Go_router default goes to "/" page
        GoRoute(
            path: "/",
            builder: (context, state) => const Login(),
          routes: [
            GoRoute(
              path: "forgotpassword", //for admins
              builder: (context, state) =>  const ForgotPassword(),
            ),
          ]
        ),

        GoRoute(
            path: "/dashboard", //for admins
            builder: (context, state) =>  Dashboard(),
        ),
        GoRoute(
            path: "/dashboardagency",
            builder: (context, state) => DashboardAgency(),
          routes: [
            GoRoute(
              path: "adddemise",
              builder: (context, state) => AddDemise(),
            ),
            GoRoute(
              path: "editdemise",
              builder: (context, state) => EditDemise(),
            ),
            GoRoute(
              path: "demisedetail",
              builder: (context, state) => DemiseDetail(),
            ),
          ]
        ),
      ],
      redirect: (context , state) async {
        var auth = CustomFirebaseAuthenticationListener();

        print("SONO NEL REDIRECT, STATO ATTUALE");
        print(auth.userEntity);
        bool authPath = state.location.contains("dashboard");

        print(state.location);
        if (auth.userEntity == null && !authPath) {
          return state.location;
        }
        if (auth.userEntity == null && authPath) {
          return AppPage.login.path;
        }
        if(state.location == "/") {
          return getPageByRole(auth.role);
        }
        return state.location;
      },
      refreshListenable: CustomFirebaseAuthenticationListener()
  );


  static String getPageByRole(String role){
    switch (role) {
      case AGENCY:
        return AppPage.agencyScaffold.path;
      case ADMIN:
        return AppPage.adminScaffold.path;
      default:
        return AppPage.login.path;
    }
  }

}