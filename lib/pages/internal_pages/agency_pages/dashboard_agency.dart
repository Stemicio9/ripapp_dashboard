
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/constants/route_constants.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/demise_manage.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/my_products.dart';
import 'package:ripapp_dashboard/widgets/scaffold.dart';

import 'agency_profile.dart';


class DashboardAgency extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DashboardAgencyState();
  }
}

class DashboardAgencyState extends State<DashboardAgency> {
  String title = "";
  int currentPage = 1;
  String agencyName = 'Nome agenzia';
  String image = "assets/images/profiledefault.jpeg";
  // final UserCubit? userCubit;
  //  DashboardState({this.userCubit});


  List<CollapsibleItem> get _items {
    return [
      CollapsibleItem(
        text: getCurrentLanguageValue(MY_PRODUCTS)!,
        icon: Icons.table_rows,
        onPressed: () => setState(() {
          title = getCurrentLanguageValue(MY_PRODUCTS)!;
          currentPage = 1;
        }),
        isSelected: currentPage == 1,
      ),
      CollapsibleItem(
        text: getCurrentLanguageValue(DEATHS_INSERT)!,
        icon: Icons.church_rounded,
        onPressed: () => setState(() {
          title = getCurrentLanguageValue(DEATHS_INSERT)!;
          currentPage = 2;
        }),
        isSelected: currentPage == 2,
      ),
      CollapsibleItem(
        text: getCurrentLanguageValue(MY_PROFILE)!,
        icon: Icons.person_rounded,
        onPressed: () => setState(() {
          title = getCurrentLanguageValue(DEATHS_INSERT)!;
          currentPage = 3;
        }),
        isSelected: currentPage == 3,
      ),
      CollapsibleItem(
        text: 'Logout',
        icon: Icons.logout_rounded,
        onPressed: () {
          //  logoutFromAll();
          Navigator.pushReplacementNamed(context, RouteConstants.login);
        },
        isSelected: currentPage == 4,
      ),

    ];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ScaffoldWidget(
      body: CollapsibleSidebar(
        iconSize: 35,
        selectedIconColor: white,
        selectedIconBox: whiteOpacity,
        textStyle: const TextStyle(fontSize: 16, fontFamily: 'Montserrat'),
        sidebarBoxShadow: [],
        titleStyle: const TextStyle(fontSize: 14, fontFamily: 'Montserrat',fontWeight: FontWeight.bold),
        backgroundColor: background,
        //isCollapsed: MediaQuery.of(context).size.width <= 800,
        isCollapsed: true,
        items: _items,
        avatarImg: AssetImage(image),
        title: agencyName,
        body: _body(size, context),
        toggleTitle: '',
      ),
    );
  }

  Widget _body(Size size, BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: lightGrey,
      child: bodyChild(),
    );
  }

  Widget bodyChild() {
    switch (currentPage) {
      case 1:
        return MyProducts();
      case 2:
        return DemiseMenage();
      case 3:
        return AgencyProfile();
      default:
        return Container();
    }
  }

/* void logoutFromAll() {
    FirebaseAuth.instance.signOut();
    userCubit?.logout();

  } */
}


