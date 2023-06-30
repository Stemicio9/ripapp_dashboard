import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/blocs/CurrentPageCubit.dart';
import 'package:ripapp_dashboard/blocs/SearchProductCubit.dart';
import 'package:ripapp_dashboard/blocs/searchAgenciesCubit.dart';
import 'package:ripapp_dashboard/blocs/users_list_cubit.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/route_constants.dart';
import 'package:ripapp_dashboard/widgets/BottomNavigationBar.dart';
import 'package:ripapp_dashboard/widgets/utilities/close_on_tap.dart';


class ScaffoldWidget extends StatefulWidget {
    final Widget body;
    final Widget? title;
    final bool showAppBar;
    ScaffoldWidget ({Key? key, required this.body, this.title, this.showAppBar = false,
    }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ScaffoldWidgetState();
}


class ScaffoldWidgetState extends State<ScaffoldWidget> {



  CurrentPageCubit get _currentPageCubit  => context.read<CurrentPageCubit>();
  static const String users_page = "users_list";
  static const String agencies_page = "agencies_list";
  static const String products_page = "products_list";
  static const String login_page = "login_page";

  static const String agency_products_page = "agency_products_list";
  static const String agency_demises_page = "agency_demises_list";
  static const String agency_edit_profile_page = "agency_edit_profile";

  bool isPageablePage(String pageName){
    return _currentPageCubit.state.page == ScaffoldWidgetState.users_page ||
        _currentPageCubit.state.page == ScaffoldWidgetState.agencies_page ||
        _currentPageCubit.state.page == ScaffoldWidgetState.products_page ||
        _currentPageCubit.state.page == ScaffoldWidgetState.agency_products_page ||
        _currentPageCubit.state.page == ScaffoldWidgetState.agency_demises_page;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: appBar(widget.showAppBar,context),
      resizeToAvoidBottomInset: false,
      body: CloseOnTapUtility(child: Stack(
        children: [
          widget.body
        ],
      )),
      bottomNavigationBar: (isPageablePage(_currentPageCubit.state.page)) ? bottomPagesBar() : null,
    );
  }

  PreferredSizeWidget? appBar(bool showAppBar, context) {
    return showAppBar ? AppBar(
        backgroundColor: background,
        title: GestureDetector(
            onTap: () {
              Navigator.popUntil(context, ModalRoute.withName( RouteConstants.dashboard));
            },
            child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: widget.title
            )
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: IconButton(
                onPressed: () {
              //    logoutFromAll();
                  Navigator.pushReplacementNamed(context, RouteConstants.login);
                },
                icon: const Icon(Icons.logout)
            ),
          )
        ]
    ) : null;
  }

  void changePageHandleUser(String page, int pageIndex){
    _currentPageCubit.loadPage(page, pageIndex);
  }



  Widget bottomPagesBar(){
    print("bru, la pagina è " + _currentPageCubit.state.page.toString());
    return BlocBuilder<CurrentPageCubit, CurrentPageState>(
        builder: (context, state){
      return (isPageablePage(state.page)) ? BottomNavigationBarExample(changePageHandle: changePageHandleUser) : ErrorWidget("exception4");
    });
  }


/*  void logoutFromAll() {
    FirebaseAuth.instance.signOut();
    userCubit?.logout();
  } */

}


/*
import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/route_constants.dart';
import 'package:ripapp_dashboard/widgets/utilities/close_on_tap.dart';


class ScaffoldWidget extends StatelessWidget {

  final Widget body;
  final Widget? title;
  final bool showAppBar;
  final bool isSomeListShowed;
  //UsersListCubit get _userListCubit => context.read<UsersListCubit>();


  const ScaffoldWidget ({Key? key, required this.body, this.title, this.showAppBar = false, this.isSomeListShowed = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: appBar(showAppBar,context),
      resizeToAvoidBottomInset: false,
      body: CloseOnTapUtility(child: Stack(
        children: [
          body
        ],
      )),
      bottomNavigationBar: this.isSomeListShowed ? bottomPagesBar() : null,
    );
  }


  void changePageHandleUser(){
    print("buonasera amici");
    //_userListCubit.fetchUsersList();
  }
  Widget bottomPagesBar(){
    return isSomeListShowed ? BottomNavigationBarExample(changePageHandle: changePageHandleUser,) : ErrorWidget("exception");
  }

  PreferredSizeWidget? appBar(bool showAppBar, context) {
    return showAppBar ? AppBar(
        backgroundColor: background,
        title: GestureDetector(
            onTap: () {
              Navigator.popUntil(context, ModalRoute.withName( RouteConstants.dashboard));
            },
            child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: title
            )
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: IconButton(
                onPressed: () {
                  //    logoutFromAll();
                  Navigator.pushReplacementNamed(context, RouteConstants.login);
                },
                icon: const Icon(Icons.logout)
            ),
          )
        ]
    ) : null;
  }

/*  void logoutFromAll() {
    FirebaseAuth.instance.signOut();
    userCubit?.logout();
  } */
}


*/