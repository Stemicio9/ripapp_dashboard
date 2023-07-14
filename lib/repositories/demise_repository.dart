import 'dart:convert';
import 'dart:io';

import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:ripapp_dashboard/authentication/firebase_authentication_listener.dart';
import 'package:ripapp_dashboard/constants/rest_path.dart';
import 'package:ripapp_dashboard/cookies/CookiesManager.dart';
import 'package:ripapp_dashboard/models/DemisesSearchEntity.dart';
import 'package:ripapp_dashboard/models/demise_entity.dart';
import 'package:ripapp_dashboard/models/user_entity.dart';
import 'package:ripapp_dashboard/repositories/user_repository.dart';
import 'package:ripapp_dashboard/utils/AccountSearchEntity.dart';

class DemiseRepository{
  static final DemiseRepository _demiseRepository = DemiseRepository._internal();



  DemiseRepository._internal();

  Map<String, dynamic> buildHeaders() {
    return {
      "Content-Type": "application/json",
      "Cookie": CookiesManager.getCookiesAsString(),
      "app_version": appVersion,
    };
  }

  final String demiseUrl = "$baseUrl/api/auth/demise";
  final String searchDemisesByCityUrl = "$baseUrl/api/auth/demises";
  final String searchDemisesIgnorante = "$baseUrl/api/auth/demisesIgnorante";
  final String deleteDemiseUrl = "$baseUrl/api/auth/demise";




  factory DemiseRepository() {
    return _demiseRepository ;
  }

  Future<dynamic> saveDemise(DemiseEntity demiseEntity) async {
    //var response = await _dio.post(demiseUrl, data: demiseEntity.toJson(), options: Options(headers: values));
    Options myoptions = Options();
    //var token = UserRepository().firebaseToken;
    //myoptions.headers!["cookie"] = "idtoken=$token;";
    print("ciao");
    Map<String, Object>? headers = Map();
    print("ciao2");
    myoptions.headers = headers;
    print("ciao3");
    //myoptions.headers!["set-cookie"] = "idtoken=123;";
    myoptions.headers!["Content-Type"] = "application/json";
    myoptions.headers!["app_version"] = appVersion;
    print("ciao4");

    var response = await globalDio.post(demiseUrl, data: demiseEntity.toJson(), options: myoptions);

    //var response = await _dio.post(demiseUrl, data: demiseEntity);
     print(response.data);
    return response.data;
  }


  Future<dynamic> updateDemise(DemiseEntity demiseToBeUpdated) async {
    String demiseId = demiseToBeUpdated.id.toString();
    String urlUpdateDemise = '$demiseUrl/$demiseId';
    print('qui ci arrivo secondo te?');
    var response = await globalDio.put(urlUpdateDemise, data: demiseToBeUpdated.toJson());
  }


  Future<dynamic> deleteDemise(int idDemise) async{
    String urlDeleteDemise = '$deleteDemiseUrl/$idDemise';
    var response = await globalDio.delete(urlDeleteDemise);
    return response.data;
  }



  Future<List<DemiseEntity>> getDemisesByCities(DemisesSearchEntity demisesSearchEntity) async {
    Response res;
    try {
      //res = await _dio.post(searchDemisesByCityUrl, data: demisesSearchEntity.toJson(), options: Options(headers: buildHeaders()));
      UserEntity? user = CustomFirebaseAuthenticationListener().userEntity;
      var userId = (user != null) ? user.id : 48;
      Map<String, dynamic>? parameters = {};
      parameters.putIfAbsent("userid", () => userId);
      parameters.putIfAbsent("pageNumber", () => demisesSearchEntity.pageNumber);
      parameters.putIfAbsent("pageElements", () => demisesSearchEntity.pageElements);
      res = await globalDio.get(searchDemisesByCityUrl, queryParameters: parameters);
      print("esatto2");
    }
    on DioError catch (e) {
      return List.empty(growable: true);
    }
    if (res.statusCode != 201 && res.statusCode != 200) {
      return List.empty(growable: true);
    }
    print("esatto 3 " + res.data.toString());
    String goodJson = jsonEncode(res.data);
    List<DemiseEntity> demises = ((jsonDecode(goodJson) as Map)["content"] as List).map((e) => DemiseEntity.fromJson(e)).toList();

    print(" demises"+ demises.toString());
    return demises;
  }

  Future<List<DemiseEntity>> getDemisesPaginated(int pageIndex) async {
    Response res;

    Map<String, dynamic>? parameters = {};
    int pageNumber = 1;
    int pageElements = 30;
    AccountSearchEntity searchEntity = AccountSearchEntity(pageNumber: pageNumber, pageElements: pageElements);

    try {
      //res = await _dio.post(searchDemisesByCityUrl, data: demisesSearchEntity.toJson(), options: Options(headers: buildHeaders()));
      UserEntity? user = CustomFirebaseAuthenticationListener().userEntity;
      var userId = (user != null) ? user.id : 48;
      Map<String, dynamic>? parameters = {};
      parameters.putIfAbsent("userid", () => userId);
      parameters.putIfAbsent("pageNumber", () => (pageIndex));
      parameters.putIfAbsent("pageElements", () => searchEntity.pageElements);
      res = await globalDio.get(searchDemisesByCityUrl, queryParameters: parameters);
    }
    on DioError catch (e) {
      return List.empty(growable: true);
    }
    if (res.statusCode != 201 && res.statusCode != 200) {
      return List.empty(growable: true);
    }
    String goodJson = jsonEncode(res.data);
    List<DemiseEntity> demises =  ((jsonDecode(goodJson) as Map)["content"] as List).map((e) => DemiseEntity.fromJson(e)).toList();
    return demises;
  }

}