import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/utils/style_utils.dart';
import 'package:ripapp_dashboard/widgets/texts.dart';

class DetailLabel extends StatelessWidget{

  final int flex;
  final String labelText;
  final String text;


  const DetailLabel({super.key, required this.flex, required this.labelText, required this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: flex,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: getPadding(bottom: 5),
              child: Text(
                labelText,
                style: SafeGoogleFont(
                  'Montserrat',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: background,
                ),
              ),
            ),
            Texth3V2(testo: text, color: black),
          ],
        )
    );
  }

}