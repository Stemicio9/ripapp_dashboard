import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RoundedButton extends StatelessWidget{
  String buttonLabel;
  Color buttonLabelColor;
  Color buttonColor;
  Function onTap;
  double fontSize;
  double verticalPadding;

  RoundedButton({super.key,required this.buttonLabel,required this.buttonLabelColor,required this.buttonColor,required this.onTap, required this.fontSize, required this.verticalPadding});

  @override
  Widget build(BuildContext context) {
    return MaterialButton (
        elevation: 0,
        color: buttonColor,
        highlightColor: buttonColor,
        splashColor: buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 15),
          child: Text(
            buttonLabel,
            style: TextStyle(
              color: buttonLabelColor,
              fontWeight: FontWeight.bold,
              fontSize: fontSize ?? 20.0,
            ),
          ),
        ),
        onPressed: () {
          HapticFeedback.mediumImpact();
          if(onTap != null)
            onTap();
        }
    );
  }
}