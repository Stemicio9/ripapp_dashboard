import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/widgets/texts.dart';

class EmptyTableContent extends StatelessWidget {

  final String text;

  const EmptyTableContent({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: getPadding(top: 40),
        child: Texth2V2(
            testo: text,
            weight: FontWeight.bold,
            color: background
        ),
      ),
    );
  }
}
