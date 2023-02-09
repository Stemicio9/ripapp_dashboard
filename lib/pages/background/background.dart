import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/colors.dart';



class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: background,
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
    );
  }
}
