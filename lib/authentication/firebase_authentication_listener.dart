import 'dart:async';

import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:ripapp_dashboard/constants/app_roles.dart';
import 'package:ripapp_dashboard/models/user_entity.dart';
import 'package:ripapp_dashboard/repositories/user_repository.dart';

class CustomFirebaseAuthenticationListener with ChangeNotifier {


  static final CustomFirebaseAuthenticationListener _authentication = CustomFirebaseAuthenticationListener._internal();


  factory CustomFirebaseAuthenticationListener() {
    return _authentication;
  }

  CustomFirebaseAuthenticationListener._internal();

  bool _loginState = false;
  User? _user;
  UserEntity? _userEntity;
  String? _tokenId;
  String _role = AppRole.noauth.toName;
  bool get loginState => _loginState;
  User? get user => _user;
  UserEntity? get userEntity => _userEntity;
  String? get tokenId => _tokenId;
  String get role => _role;

  set role(String role) {
    _role = role;
    notifyListeners();
  }

  set userEntity(UserEntity? userEntity) {
    _userEntity = userEntity;
    notifyListeners();
  }


  setCurrentAuthState(User? user) async {
    print("questo viene chiamato al logout?");
    print("USER ATTUALE");
    print(user);
    if (user == null) {
      _user = null;
      _loginState = false;
      _tokenId = null;
      _userEntity = null;
      // _role = await getCurrentRole();
    } else {
      _user = user;
      _loginState = true;
      _tokenId = await user.getIdToken();
      // _role = await getCurrentRole();
    }
    notifyListeners();
  }


  Future<String> getCurrentRole() async {
    return dummyFuture();
  }

  Future<String> dummyFuture() {
    var completer = Completer<String>();
    completer.complete(AppRole.user.toName);
    return completer.future;
  }

  void logout(){
    globalDio = Dio()..httpClientAdapter = BrowserHttpClientAdapter(withCredentials: true);
    FirebaseAuth.instance.signOut();
  }

  Future<void> onAppStart() async {
    // TODO ripristinare queste due righe per l'authentication
    FirebaseAuth.instance.authStateChanges().listen(setCurrentAuthState);
    setCurrentAuthState(user);
  }


}