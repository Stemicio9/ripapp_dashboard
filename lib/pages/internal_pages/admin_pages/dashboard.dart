
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/blocs/CurrentPageCubit.dart';
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

  CurrentPageCubit get _currentPageCubit => context.read<CurrentPageCubit>();


 // final UserCubit? userCubit;
//  DashboardState({this.userCubit});


  List<CollapsibleItem> get _items {
    return [
      CollapsibleItem(
        text: getCurrentLanguageValue(USERS_MANAGE)!,
        icon: Icons.person_rounded,
        onPressed: () => setState(() {
          _currentPageCubit.changeCurrentPage(ScaffoldWidgetState.users_page);
          title = getCurrentLanguageValue(USERS_MANAGE)!;
          currentPage = 1;
        }),
        isSelected: currentPage == 1,
      ),
      CollapsibleItem(
        text: getCurrentLanguageValue(AGENCIES_MANAGE)!,
        icon: Icons.business_rounded,
        onPressed: () => setState(() {
          _currentPageCubit.changeCurrentPage(ScaffoldWidgetState.agencies_page);
          title = getCurrentLanguageValue(AGENCIES_MANAGE)!;
          currentPage = 2;
        }),
        isSelected: currentPage == 2,
      ),
      CollapsibleItem(
        text: getCurrentLanguageValue(PRODUCTS_MANAGE)!,
        icon: Icons.table_rows,
        onPressed: () => setState(() {
          _currentPageCubit.changeCurrentPage(ScaffoldWidgetState.products_page);
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
          FirebaseAuth.instance.signOut();

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
    );
  }


  Widget _body(Size size, BuildContext context) {
    return
        Builder(
          builder: (context) {
            return Container(
              height: double.infinity,
              width: double.infinity,
              color: lightGrey,
              child: bodyChild(),
            );
          },
    );
  }


  Widget bodyChild() {
    return BlocBuilder<CurrentPageCubit, CurrentPageState>(
        builder: (context, state)
    {
      switch (state.page) {
        case ScaffoldWidgetState.users_page:
          return UsersManage();
        case ScaffoldWidgetState.agencies_page:
          return AgenciesManage();
        case ScaffoldWidgetState.products_page:
          return ProductsManage();
        default:
          return Container();
      }
    });
  }

 /* void logoutFromAll() {
    FirebaseAuth.instance.signOut();
    userCubit?.logout();

  } */
}


