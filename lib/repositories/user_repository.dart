import 'dart:convert';
import 'package:dio/browser.dart';
import 'package:ripapp_dashboard/authentication/firebase_authentication_listener.dart';
import 'package:ripapp_dashboard/constants/rest_path.dart';
import 'package:ripapp_dashboard/cookies/CookiesManager.dart';
import 'package:dio/dio.dart';
import 'package:ripapp_dashboard/models/UserStatusEnum.dart';
import 'package:ripapp_dashboard/models/user_entity.dart';

class UserRepository {
  static final UserRepository _userRepository = UserRepository._internal();
  final Dio _dio = Dio()..httpClientAdapter = BrowserHttpClientAdapter(withCredentials: true);

  final String loginUrl = "$baseUrl/api/auth/login";
  final String accountUrl = "$baseUrl/api/auth/account";
  final String allUsersUrl = "$baseUrl/api/auth/accounts";
  final String signupUrl = "$baseUrl/api/saveUser";
  final String deleteUrl = "$baseUrl/api/auth/account";
  final String deleteUserUrl = "$baseUrl/api/auth/account";
  final String listAccountUrl = "$baseUrl/api/auth/account/list";



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
  Future<List<UserEntity>> getList() async{
    Response response;
    response = await _dio.get(listAccountUrl);
    print("object");
    print(response.data);
    // todo this could be not necessary
    String goodJson = jsonEncode(response.data);
    List<UserEntity> userEntityList = (jsonDecode(goodJson) as List).map((e) => UserEntity.fromJson(e)).toList();
    return userEntityList;
  }

  Future<dynamic> deleteUser(int idUser) async{
    String urlDeleteUser = '$deleteUserUrl/$idUser';
    var response = await _dio.delete(urlDeleteUser);
    return response.data;
  }


  Future<dynamic> signup(UserEntity userEntity) async {
    print("REGISTRO UTENTE");
    print("USER STATUS: ");
    print("USER no: ");
    print("USER si: ");
    print("CIAO CIAO CIAO CIAO CIAO CIAO CIAO");
    print(userEntity.toJson());
    var response = await _dio.post(signupUrl,data: userEntity.toJson(), options: Options(headers: buildHeaders()));
    return response.data;
  }

  Future loginPreLayer(String token) async {
    var response = await UserRepository().login(token);
    CookiesManager.clear();

    print("RISPOSTA LOGIN");
    print(response.data);
    print(response.headers);

    var accountResponse = await UserRepository().account();

    print("STATUS");
    print(accountResponse.status);

    CustomFirebaseAuthenticationListener().role = userStatusToString(accountResponse.status);
    CustomFirebaseAuthenticationListener().userEntity = accountResponse;


  }

  Future<List<UserEntity>> getAllUsers() async {
    Map<String, dynamic>? parameters = {};
    UserEntity? user = CustomFirebaseAuthenticationListener().userEntity;
    var userId = (user != null) ? user.id : "4";
    parameters.putIfAbsent("offset", () => 0);
    parameters.putIfAbsent("userid", () => userId!);
    Response res = await _dio.get(allUsersUrl, queryParameters: parameters);
    print("dati = " + res.data.toString());
    List<UserEntity> users = (res.data as List).map((user) => UserEntity.fromJson(user)).toList();
    return users;
  }
  Future<dynamic> cityList()async{
    Response response;
    response = await _dio.get("https://axqvoqvbfjpaamphztgd.functions.supabase.co/comuni");
    print(response.data);
    return response.data;
  }

}
