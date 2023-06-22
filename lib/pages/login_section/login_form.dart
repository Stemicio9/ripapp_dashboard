import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/authentication/firebase_authentication_listener.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/constants/route_constants.dart';
import 'package:ripapp_dashboard/constants/validators.dart';
import 'package:ripapp_dashboard/repositories/user_repository.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/widgets/action_button.dart';
import 'package:ripapp_dashboard/widgets/input.dart';
import 'package:ripapp_dashboard/widgets/texts.dart';
import 'package:ripapp_dashboard/widgets/utilities/image_utility.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../constants/images_constants.dart';


class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}


class LoginFormState extends State<LoginForm>{
  late bool _passwordVisible;
  final _formKey = GlobalKey<FormState>();
  final double logoWidth = 250;
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(flex: 2, child: logoSection()),
              Expanded(flex: 1, child: loginTextSection()),
              Expanded(flex: 3, child: loginSection()),
              Expanded(flex: 1, child: forgotPasswordSection())
            ],
          )),
    );
  }


  Widget logoSection() {
    return Container(
      width: logoWidth,
      child: const ImagePlaceholder(
        name: LOGO_IMAGE_NAME,
      ),
    );
  }


  Widget loginTextSection() {
    return Texth1V2(
        testo: getCurrentLanguageValue(LOGIN)!,
        color: white,
        weight: FontWeight.w700,
        fontsize: 24);
  }

  Widget loginSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InputsV2Widget(
            hinttext: getCurrentLanguageValue(EMAIL)!,
            validator: validateEmail,
            controller: _emailTextController,

          ),
          InputsV2Widget(
            iconOnTap: (){
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
            isPassword: !_passwordVisible,
            hinttext: getCurrentLanguageValue(PASSWORD)!,
            controller: _passwordTextController,
            validator: validatePassword,
            suffixIcon: _passwordVisible ? ImagesConstants.imgPassSee : ImagesConstants.imgPassUnsee,
            isSuffixIcon: true,
            suffixIconHeight: 25,
            suffixIconWidth: 25,
            paddingTop: 10,
          ),
          Padding(
            padding: getPadding(top: 40),
            child: ActionButtonV2(
                maxWidth: 240,
                action: formsubmit,
                color: white,
                textColor: background,
               // text: getCurrentLanguageValue(LOGIN)!,
               text: "Login"
            ),
          ),

        ],
      ),
    );
  }

  Widget forgotPasswordSection() {
    return Container(
      child: Column(
        children: [
          Expanded(
              flex: 2,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, RouteConstants.forgotPassword);
                  },
                  child:  Texth4V2(
                    testo: getCurrentLanguageValue(FORGOT_PASSWORD)!,
                    color: white,
                    weight: FontWeight.w600,
                    underline: true,
                  ),
                ),
              )
          ),
          Expanded(
            flex: 4,
            child: Container(),
          )
        ],
      ),
    );

  }


  formsubmit() async {
   // if (_formKey.currentState!.validate()) {
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailTextController.text,
        password: _passwordTextController.text).then((value) async {
      String token = await value.user!.getIdToken();
      UserRepository().setFirebaseToken(token);
      var response = await UserRepository().loginPreLayer(token);
    });
    //Navigator.pushNamed(context, RouteConstants.dashboard);


   // }
  }
  loginAgency() async {
    //  if (_formKey.currentState!.validate()) {
    //Navigator.pushNamed(context, RouteConstants.dashboardAgency);


    //  }
  }
}