

import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/route_constants.dart';
import 'package:ripapp_dashboard/widgets/utilities/close_on_tap.dart';


class ScaffoldWidget extends StatelessWidget {

  final Widget body;
  final Widget? title;
  final bool showAppBar;



  const ScaffoldWidget ({Key? key, required this.body, this.title, this.showAppBar = false,
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

