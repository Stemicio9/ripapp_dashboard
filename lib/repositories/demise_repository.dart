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
    print(demiseEntity.toJson());
    print("ciao5");
   try {
     var response = await globalDio.post(demiseUrl, data: JsonEncoder().convert(demiseEntity), options: myoptions);
     print("viene mandato = " + response.toString());

     //var response = await _dio.post(demiseUrl, data: demiseEntity);
     print(response.data);
     return response.data;
   }catch(e){
     print("errore saveDemise");
     print(e);
   }
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
      res = await globalDio.get(searchDemisesByCityUrl, queryParameters: parameters);
      print("RES CONTIENE");
      print("esatto2");
    }
    on DioError catch (e) {
      print("errore getDemise");
      print(e);
      return List.empty(growable: true);
    }
    if (res.statusCode != 201 && res.statusCode != 200) {
      return List.empty(growable: true);
    }
    print("GET DEMISES");
    print("NON ENTRO PROPRIO DOVE DEVO ENTRARE");
    print(res.data);
    List<dynamic> resultList = res.data as List;
    print("Ho la resultlist");
    Iterable<DemiseEntity> iterable = resultList.map((e) => DemiseEntity.fromJson(e));
    print("Ho iterable");
    List<DemiseEntity> demises = iterable.toList();
    print("Ho trasformato in lista finale");
  //  List<DemiseEntity> demises = resultList.map((e) => DemiseEntity.fromJson(e)).toList();
    print(demises);
    print("object");

    return demises;
  }

}