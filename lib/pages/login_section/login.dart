import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/pages/background/background.dart';
import 'package:ripapp_dashboard/pages/login_section/login_form.dart';
import 'package:ripapp_dashboard/widgets/scaffold.dart';



class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {

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
                    LoginForm(),
                  ],
                )
            ),
          ),
        )
    );
  }
}
