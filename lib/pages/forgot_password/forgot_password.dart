import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/pages/background/background.dart';
import 'package:ripapp_dashboard/pages/forgot_password/forgot_password_form.dart';
import 'package:ripapp_dashboard/widgets/scaffold.dart';



class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {

  final double cardWidth = 400;
  final double cardHeight = 700;

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
        body: Center(
          child: SizedBox(
            width: cardWidth,
            height: cardHeight,
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                margin: const EdgeInsets.all(20),
                child: Stack(
                  children: [
                   const Background(),
                    ForgotPasswordForm(),
                  ],
                )
            ),
          ),
        )
    );
  }
}
