
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/constants/route_constants.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/products_manage.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/users_manage.dart';
import 'package:ripapp_dashboard/widgets/scaffold.dart';

import '../../../blocs/searchAgenciesCubit.dart';
import 'agencies_manage.dart';


class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DashboardState();
  }
}

class DashboardState extends State<Dashboard> {
  String title = "";
  int currentPage = 1;
  bool isSomeListPage = false;

  void changeIsSomeListPage(bool newValue){
    this.isSomeListPage = newValue;
    print("cambio il valore di list showed a " + this.isSomeListPage.toString());
  }

 // final UserCubit? userCubit;
//  DashboardState({this.userCubit});


  List<CollapsibleItem> get _items {
    return [
      CollapsibleItem(
        text: getCurrentLanguageValue(USERS_MANAGE)!,
        icon: Icons.person_rounded,
        onPressed: () => setState(() {
          title = getCurrentLanguageValue(USERS_MANAGE)!;
          currentPage = 1;
        }),
        isSelected: currentPage == 1,
      ),
      CollapsibleItem(
        text: getCurrentLanguageValue(AGENCIES_MANAGE)!,
        icon: Icons.business_rounded,
        onPressed: () => setState(() {
          title = getCurrentLanguageValue(AGENCIES_MANAGE)!;
          currentPage = 2;
        }),
        isSelected: currentPage == 2,
      ),
      CollapsibleItem(
        text: getCurrentLanguageValue(PRODUCTS_MANAGE)!,
        icon: Icons.table_rows,
        onPressed: () => setState(() {
          title = getCurrentLanguageValue(PRODUCTS_MANAGE)!;
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
        avatarImg: const AssetImage("assets/images/profiledefault.jpeg"),
        title: getCurrentLanguageValue(ADMIN)!,
        body: _body(size, context),
        toggleTitle: '',
      ),
      isSomeListShowed: isSomeListPage,
    );
  }


  Widget _body(Size size, BuildContext context) {
    return MultiBlocProvider (
        providers: [
          BlocProvider<SearchAgencyCubit>(create: (_) => SearchAgencyCubit()),
        ],
        child: Builder(
          builder: (context) {
            return Container(
              height: double.infinity,
              width: double.infinity,
              color: lightGrey,
              child: bodyChild(),
            );
          },
        ),
    );
  }




  Widget bodyChild() {
    switch (currentPage) {
      case 1:
        return UsersManage(changeIsSomeListShowed: changeIsSomeListPage,);
      case 2:
        return AgenciesManage();
      case 3:
        return ProductsManage();
      default:
        return Container();
    }
  }

 /* void logoutFromAll() {
    FirebaseAuth.instance.signOut();
    userCubit?.logout();

  } */
}


