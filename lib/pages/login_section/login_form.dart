import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ripapp_dashboard/authentication/firebase_authentication_listener.dart';
import 'package:ripapp_dashboard/blocs/CurrentPageCubit.dart';
import 'package:ripapp_dashboard/constants/app_pages.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/images_constants.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/constants/route_constants.dart';
import 'package:ripapp_dashboard/constants/validators.dart';
import 'package:ripapp_dashboard/repositories/user_repository.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/widgets/action_button.dart';
import 'package:ripapp_dashboard/widgets/input.dart';
import 'package:ripapp_dashboard/widgets/scaffold.dart';
import 'package:ripapp_dashboard/widgets/snackbars.dart';
import 'package:ripapp_dashboard/widgets/texts.dart';
import 'package:ripapp_dashboard/widgets/utilities/image_utility.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}


class LoginFormState extends State<LoginForm> {

  final _formKey = GlobalKey<FormState>();
  final double logoWidth = 250;
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  CurrentPageCubit get _currentPageCubit => context.read<CurrentPageCubit>();
  late bool _passwordVisible = false;

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
            hinttext: getCurrentLanguageValue(PASSWORD) ?? "",
            iconOnTap: (){
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },

            isPassword: !_passwordVisible,
            controller: _passwordTextController,
            suffixIcon: _passwordVisible ? ImagesConstants.imgPassSee : ImagesConstants.imgPassUnsee,
            isSuffixIcon: true,
            suffixIconHeight: 25,
            suffixIconWidth: 25,
            validator: validatePassword,
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
    return Column(
      children: [
        Expanded(
            flex: 2,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: (){
                   context.push(AppPage.forgotPassword.path);
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
    );

  }


  formsubmit() async {
    if (_formKey.currentState!.validate()) {
    FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailTextController.text, password: _passwordTextController.text).then((value) async {
      print("TI SALUTO ");
      String token = await value.user!.getIdToken();
      UserRepository().setFirebaseToken(token);
      try {
        var response = await UserRepository().loginPreLayer(token);
      }catch(e){
        ErrorSnackbar(context, text: 'Credenziali errate!');
      }
    }, onError: (e) {
      ErrorSnackbar(context, text: 'Credenziali errate!');
    }

    );
    //Navigator.pushNamed(context, RouteConstants.dashboard);
    //if (CustomFirebaseAuthenticationListener().userEntity!.status == UserStatus.admin){
      _currentPageCubit.loadPage(ScaffoldWidgetState.users_page, _currentPageCubit.state.pageNumber);
    //}
    /*else if (CustomFirebaseAuthenticationListener().userEntity!.status == UserStatus.admin)
      _currentPageCubit.loadPage(ScaffoldWidgetState.agency_products_page, _currentPageCubit.state.pageNumber);*/
   }
  }
  loginAgency() async {
    //  if (_formKey.currentState!.validate()) {
    //Navigator.pushNamed(context, RouteConstants.dashboardAgency);


    //  }
  }
}