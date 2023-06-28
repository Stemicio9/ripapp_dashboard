import 'dart:convert';
import 'dart:html';
import 'package:dio/browser.dart';
import 'package:ripapp_dashboard/authentication/firebase_authentication_listener.dart';
import 'package:ripapp_dashboard/constants/rest_path.dart';
import 'package:ripapp_dashboard/cookies/CookiesManager.dart';
import 'package:dio/dio.dart';
import 'package:ripapp_dashboard/models/UserStatusEnum.dart';
import 'package:ripapp_dashboard/models/city_from_API.dart';
import 'package:ripapp_dashboard/models/user_entity.dart';
import 'package:ripapp_dashboard/utils/AccountSearchEntity.dart';


 Dio globalDio = Dio()..httpClientAdapter = BrowserHttpClientAdapter(withCredentials: true);

class UserRepository {
  static final UserRepository _userRepository = UserRepository._internal();


  final String loginUrl = "$baseUrl/api/auth/login";
  final String accountUrl = "$baseUrl/api/auth/account";
  final String allUsersUrl = "$baseUrl/api/auth/accounts";
  final String signupUrl = "$baseUrl/api/saveUser";
  final String deleteUrl = "$baseUrl/api/auth/account";
  final String deleteUserUrl = "$baseUrl/api/auth/account";
  final String listAccountUrl = "$baseUrl/api/auth/account/list";
  final String updateUserUrl = "$baseUrl/api/auth/account";
  final String cityListUrl = "$baseUrl/api/auth/publicCityList";


  factory UserRepository() {
    return _userRepository;
  }

  UserRepository._internal();

  String? firebaseToken;

  setFirebaseToken(String token) {
    firebaseToken = token;
  }

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
    var response = await globalDio.post(loginUrl, data: values);
    return response;
  }

  Future<UserEntity> account() async {
    var response = await globalDio.get(accountUrl, options: Options(headers: buildHeaders()));

    print("ATTUALE UTENTE");
    print(response.data);
    return UserEntity.fromJson(response.data);
  }
  Future<List<UserEntity>> getList() async{

    Map<String, dynamic>? parameters = {};
    int pageNumber = 1;
    int pageElements = 9;
    AccountSearchEntity searchEntity = AccountSearchEntity(pageNumber: pageNumber, pageElements: pageElements);
    parameters.putIfAbsent("pageNumber", () => searchEntity.pageNumber);
    parameters.putIfAbsent("pageElements", () => searchEntity.pageElements);

    Response response;
    response = await globalDio.get(listAccountUrl, queryParameters: parameters);

    print("object");
    print(response.data);
    // todo this could be not necessary
    String goodJson = jsonEncode(response.data);

    //print("ecco il tuo content" + ((jsonDecode(goodJson) as Map)["content"] as List).toString());
    //List<UserEntity> users = ((jsonDecode(goodJson) as Map)["content"] as List).map((user) => UserEntity.fromJson(user)).toList();
    //print("ecco i tuoi utenti" + users.toString() + users.length.toString());

    List<UserEntity> userEntityList = (jsonDecode(goodJson) as List).map((e) => UserEntity.fromJson(e)).toList();
    return userEntityList;
    //return users;
  }
  Future<List<UserEntity>> getListWithIndex(int pageIndex) async{

    Map<String, dynamic>? parameters = {};
    int pageNumber = 1;
    int pageElements = 9;
    AccountSearchEntity searchEntity = AccountSearchEntity(pageNumber: pageNumber, pageElements: pageElements);
    parameters.putIfAbsent("pageNumber", () => (pageIndex));
    parameters.putIfAbsent("pageElements", () => searchEntity.pageElements);

    Response response;
    response = await globalDio.get(listAccountUrl, queryParameters: parameters);
    print("object");
    print(response.data);
    // todo this could be not necessary
    String goodJson = jsonEncode(response.data);

    var list = (jsonDecode(goodJson) as Map)["content"] as List;
    List<UserEntity> users = (list).map((user) => UserEntity.fromJson(user)).toList();
    print("ecco i tuoi utenti" + users.toString() + users.length.toString());
    //List<UserEntity> userEntityList = (jsonDecode(goodJson) as List).map((e) => UserEntity.fromJson(e)).toList();
    //return userEntityList;
    return users;
  }

  Future<dynamic> deleteUser(int idUser) async {
    String urlDeleteUser = '$deleteUserUrl/$idUser';
    var response = await globalDio.delete(urlDeleteUser);
    return response.data;
  }


  Future<dynamic> signup(UserEntity userEntity) async {
    print("REGISTRO UTENTE");
    print("USER STATUS: ");
    print("USER no: ");
    print("USER si: ");
    print("CIAO CIAO CIAO CIAO CIAO CIAO CIAO");
    print(userEntity.toJson());
    print("CIAO CIAO CIAO CIAO CIAO CIAO CIAO 2");
    var response = await globalDio.post(signupUrl,data: userEntity.toJson(), options: Options(headers: buildHeaders()));
    print("CIAO CIAO CIAO CIAO CIAO CIAO CIAO 3");
    print("risposta = " + response.toString());
    return response.data;
  }

  Future loginPreLayer(String token) async {
    CookiesManager.clear();
    print("SONO NEL LOGIN PRE LAYER");
    print(token);
    var response = await UserRepository().login(token);

    print("RISPOSTA LOGIN");
    print(response.data);
    print(response.headers);

    var accountResponse = await UserRepository().account();


    CustomFirebaseAuthenticationListener().role = userStatusToString(accountResponse.status);
    print("STATUS");
    print(accountResponse.status);
    CustomFirebaseAuthenticationListener().userEntity = accountResponse;


  }

  Future<List<UserEntity>> getAllUsers() async {
    Map<String, dynamic>? parameters = {};
    UserEntity? user = CustomFirebaseAuthenticationListener().userEntity;
    var userId = (user != null) ? user.id : "48";
    int pageNumber = 0;
    int pageElements = 10;
    int offset = pageNumber*pageElements;
    parameters.putIfAbsent("offset", () => offset);
    parameters.putIfAbsent("userid", () => userId!);
    AccountSearchEntity searchEntity = AccountSearchEntity(pageNumber: pageNumber, pageElements: pageElements);
    Options myoptions = Options();
    Map<String, Object>? headers = Map();
    myoptions.headers = headers;
    //myoptions.headers!["set-cookie"] = "idtoken=123;";
    myoptions.headers!["Content-Type"] = "application/json";
    Response res = await globalDio.get(allUsersUrl, data: searchEntity.toJson(), queryParameters: parameters, options: myoptions);
    print("dati = " + res.data.toString());
    print(res.data);
    List<UserEntity> users = (res.data as List).map((user) => UserEntity.fromJson(user)).toList();
    return users;
  }
  Future<List<CityFromAPI>> cityList() async {
    Response res;
    res = await globalDio.get(cityListUrl);
    List<CityFromAPI> cityList = (res.data as List).map((e) => CityFromAPI.fromJson(e)).toList();

    print("ECCO LE CITTà - simone");
    return cityList;
  }

  Future<dynamic> updateUser(int userId, UserEntity userEntity) async{
    String urlChiamato = '$updateUserUrl/$userId';
    var response = await globalDio.put(urlChiamato, data: userEntity.toJson());
    return UserEntity.fromJson(response.data);
  }

}
