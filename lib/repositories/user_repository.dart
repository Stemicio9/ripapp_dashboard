import 'dart:io';

import 'package:dio/browser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ripapp_dashboard/authentication/firebase_authentication_listener.dart';
import 'package:ripapp_dashboard/constants/rest_path.dart';
import 'package:ripapp_dashboard/cookies/CookiesManager.dart';
import 'package:ripapp_dashboard/models/UserEntity.dart';
import 'package:dio/dio.dart';
import 'package:ripapp_dashboard/models/UserStatusEnum.dart';
import 'package:ripapp_dashboard/models/user_entity.dart';

class UserRepository {
  static final UserRepository _userRepository = UserRepository._internal();
  final Dio _dio = Dio()..httpClientAdapter = BrowserHttpClientAdapter(withCredentials: true);

  final String loginUrl = "$baseUrl/api/auth/login";
  final String accountUrl = "$baseUrl/api/auth/account";
  final String signupUrl = "$baseUrl/api/saveUser";

  factory UserRepository() {
    return _userRepository;
  }

  UserRepository._internal();

  String? firebaseToken;
  setFirebaseToken(String token) {firebaseToken = token;}

  Map<String, dynamic> buildHeaders() {
    return {
      "Content-Type": "application/json",
      "Cookie": CookiesManager.getCookiesAsString(),
      "app_version": appVersion,
    };
  }


  Future<dynamic> login(String token) async {
    Map<String, String> values = {};
    print("TOKEN FIREBASE");
    print(token);
    values.putIfAbsent("idtoken", () => token);
    var response = await _dio.post(loginUrl, data: values);
    return response;
  }

  Future<UserEntity> account() async {
    var response = await _dio.get(accountUrl, options: Options(headers: buildHeaders()));

    print("ATTUALE UTENTE");
    print(response.data);
    return UserEntity.fromJson(response.data);
  }

  Future<dynamic> signup(UserEntity userEntity) async {
    print("REGISTRO UTENTE");
    userEntity.status = UserStatus.active;
    print("USER STATUS: ");
    print(userEntity.status);
    var response = await _dio.post(signupUrl,data: userEntity, options: Options(headers: buildHeaders()));
    return response.data;
  }

  Future loginPreLayer(String token) async {
    var response = await UserRepository().login(token);
    CookiesManager.clear();

    print("RISPOSTA LOGIN");
    print(response.data);
    print(response.headers);


    /*
      ciaocia@cia.it
      123456
     */

    var accountResponse = await UserRepository().account();

    print("STATUS");
    print(accountResponse.status);

    CustomFirebaseAuthenticationListener().role = userStatusToString(accountResponse.status);
    CustomFirebaseAuthenticationListener().userEntity = accountResponse;
  }

}
