import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/models/UserEntity.dart';
import 'package:ripapp_dashboard/models/user_entity.dart';
import 'package:ripapp_dashboard/pages/signup_section/signup_form.dart';
import 'package:ripapp_dashboard/repositories/user_repository.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RegisterForm(onRegister: signup)
    );
  }

  signup(UserEntity userEntity, String password) {
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: userEntity.email, password: password).then((value) async {
      if(value.user == null){
        return; //TODO: Handle error
      }

      //  userEntity.idtoken = await value.user!.getIdToken();
      userEntity.idtoken = value.user!.uid;
      print("ID TOKEN = ");
      print(userEntity.idtoken);
      var response = await UserRepository().signup(userEntity);
    });
  }
}