import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/utils/style_utils.dart';

class DialogCard extends StatelessWidget {
  final String cardTitle;
  final child;
  final double paddingRight;
  final double paddingLeft;
  final Color cardColor;

  DialogCard({required this.cardTitle, required this.child, this.paddingRight = 20, this.paddingLeft=20, this.cardColor = white});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0,
        child: Column(
            children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: getPadding(top: 15, bottom: 15),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: background
            ),
            child: Text(
              cardTitle,
              textAlign: TextAlign.center,
              style: SafeGoogleFont(
                'Montserrat',
                fontSize:22,
                fontWeight: FontWeight.w600,
                color: white

              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: getPadding(top: 35, bottom: 35, left: paddingLeft, right: paddingRight),
            child: child,
          )
        ]));
  }
}
