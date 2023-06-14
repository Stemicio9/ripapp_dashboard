import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/constants/route_constants.dart';
import 'package:ripapp_dashboard/constants/validators.dart';
import 'package:ripapp_dashboard/widgets/action_button.dart';
import 'package:ripapp_dashboard/widgets/input.dart';
import 'package:ripapp_dashboard/widgets/snackbars.dart';
import 'package:ripapp_dashboard/widgets/texts.dart';
import 'package:ripapp_dashboard/widgets/utilities/image_utility.dart';

import '../../authentication/auth_status.dart';



class ForgotPasswordForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ForgotPasswordFormState();
  }
}

class ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTextController = TextEditingController();
  final double logoWidth = 250;
  static final auth = FirebaseAuth.instance;
  static late AuthStatus _status;


  Future<AuthStatus> resetPassword({required String email}) async {
    await auth
        .sendPasswordResetEmail(email: email)
        .then((value) => _status = AuthStatus.successful)
        .catchError(
            (e) => _status = AuthExceptionHandler.handleAuthException(e));

    return _status;
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
              Expanded(flex: 1, child: forgotPassTextSection()),
              Expanded(flex: 2, child: forgotPassInputSection()),
              Expanded(flex: 2, child: backButtonSection())
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

  Widget forgotPassTextSection() {
    return Texth1V2(
        testo: getCurrentLanguageValue(PASSWORD_RECOVERY)!,
        color: white,
        weight: FontWeight.w700,
        fontsize: 24);
  }

  Widget forgotPassInputSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InputsV2Widget(
            hinttext: EMAIL,
            controller: _emailTextController,
            validator: validateEmail,
          ),
          ActionButtonV2(
              maxWidth: 240,
              color: white,
              textColor: background,
              action: formSubmit, text: getCurrentLanguageValue(CONFIRM)!),
        ],
      ),
    );
  }

  Widget backButtonSection() {
    return Container(
      child: Column(
        children: [
          Expanded(
              flex: 2,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  },
                  child: Texth4V2(
                    testo: getCurrentLanguageValue(BACK)!,
                    color: white,
                    weight: FontWeight.w700,
                    underline: true,
                  ),
                ),
              )),
          Expanded(
            flex: 4,
            child: Container(),
          )
        ],
      ),
    );
  }

  formSubmit() async {
    if (_formKey.currentState!.validate()) {
      final _status = await resetPassword(
          email: _emailTextController.text.trim());
      if (_status == AuthStatus.successful) {
        SuccessSnackbar(
            context,
            text: 'Abbiamo inviato una email all\'indirizzo ${_emailTextController.text}'
        );
        Navigator.pushNamed(context, RouteConstants.login);

      } else {
        ErrorSnackbar(
            context,
            text: 'Non è stato possibile inviare la mail di recupero password!');
      }
    }
  }
}
