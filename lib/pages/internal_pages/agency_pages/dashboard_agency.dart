
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/authentication/firebase_authentication_listener.dart';
import 'package:ripapp_dashboard/blocs/CurrentPageCubit.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/models/user_entity.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/new_pages/demise_manage_page.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/new_pages/products_selected_page.dart';
import 'package:ripapp_dashboard/utils/image_utils.dart';
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
  String image = "assets/images/profiledefault.jpeg";
  CurrentPageCubit get _currentPageCubit => context.read<CurrentPageCubit>();
  late UserEntity userEntity;


  @override
  void initState() {
    _currentPageCubit.state.page = ScaffoldWidgetState.agency_products_page;
    userEntity = CustomFirebaseAuthenticationListener().userEntity!;
    getUserImage();
    super.initState();
  }


  List<CollapsibleItem> get _items {
    return [
      CollapsibleItem(
        text: getCurrentLanguageValue(MY_PRODUCTS)!,
        icon: Icons.table_rows,
        onPressed: () => setState(() {
          _currentPageCubit.changeCurrentPage(ScaffoldWidgetState.agency_products_page);
          title = getCurrentLanguageValue(MY_PRODUCTS)!;
          currentPage = 1;
        }),
        isSelected: currentPage == 1,
      ),
      CollapsibleItem(
        text: getCurrentLanguageValue(DEATHS_INSERT)!,
        icon: Icons.church_rounded,
        onPressed: () => setState(() {
          _currentPageCubit.changeCurrentPage(ScaffoldWidgetState.agency_demises_page);
          title = getCurrentLanguageValue(DEATHS_INSERT)!;
          currentPage = 2;
        }),
        isSelected: currentPage == 2,
      ),
      CollapsibleItem(
        text: getCurrentLanguageValue(MY_PROFILE)!,
        icon: Icons.person_rounded,
        onPressed: () => setState(() {
          _currentPageCubit.changeCurrentPage(ScaffoldWidgetState.agency_edit_profile_page);
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
          _currentPageCubit.changeCurrentPage(ScaffoldWidgetState.login_page);
          // FIXME LA RIGA DI CODICE SOTTO QUESTA NON VA BENE
          //FirebaseAuth.instance.signOut().then((value) => _currentPageCubit.changeCurrentPage(ScaffoldWidgetState.login_page));
          print("PREMUTO IL PULSANTE LOGOUT");
          CustomFirebaseAuthenticationListener().logout();
          //Navigator.pushReplacementNamed(context, RouteConstants.login);
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
        avatarImg: NetworkImage(image),
        title: '${userEntity.firstName!.toUpperCase()} ${userEntity.lastName!.toUpperCase()}',
        body: _body(size, context),
        toggleTitle: '',
      ),
    );
  }


  getUserImage(){
    final User user = FirebaseAuth.instance.currentUser!;
    final uid = user.uid;
    ImageUtils().downloadUrlImageUser(uid).then((value) {
      setState(() {
        image = value;
      });
    });
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
    return BlocBuilder<CurrentPageCubit, CurrentPageState>(
        builder: (context, state) {
          switch (state.page) {
            case ScaffoldWidgetState.agency_products_page:
              return const ProductsSelectedPage();
            case ScaffoldWidgetState.agency_demises_page:
              return const DemiseManagePage();
            case ScaffoldWidgetState.agency_edit_profile_page:
              return AgencyProfile();
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


