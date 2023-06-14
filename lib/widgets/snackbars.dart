import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/colors.dart';


void ErrorSnackbar(BuildContext context, {required String text}){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: rossoopaco,
        content:  Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.warning_amber_rounded, color: white),
            ),
            Text(text),
          ],
        ),
        duration: const Duration(milliseconds: 4000),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
      )
  );
}



void SuccessSnackbar(BuildContext context, {required String text}){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: green,
      content: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(Icons.check_circle_outline_rounded, color: white),
          ),
          Text(text),
        ],
      ),
      duration: const Duration(milliseconds: 4000),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
      ),
    ),
  );
}