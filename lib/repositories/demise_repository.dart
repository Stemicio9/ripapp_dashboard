import 'dart:io';

import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:ripapp_dashboard/constants/rest_path.dart';
import 'package:ripapp_dashboard/cookies/CookiesManager.dart';
import 'package:ripapp_dashboard/models/DemisesSearchEntity.dart';
import 'package:ripapp_dashboard/models/demise_entity.dart';
import 'package:ripapp_dashboard/repositories/user_repository.dart';

class DemiseRepository{
  static final DemiseRepository _demiseRepository = DemiseRepository._internal();

  final Dio _dio = Dio()..httpClientAdapter = BrowserHttpClientAdapter(withCredentials: true);

  DemiseRepository._internal();

  Map<String, dynamic> buildHeaders() {
    return {
      "Content-Type": "application/json",
      "Cookie": CookiesManager.getCookiesAsString(),
      "app_version": appVersion,
    };
  }

  final String demiseUrl = "$baseUrl/api/auth/demiseWithoutCookie";
  final String searchDemisesByCityUrl = "$baseUrl/api/auth/search/demises";




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
    myoptions.headers = headers;
    //myoptions.headers!["set-cookie"] = "idtoken=123;";
    myoptions.headers!["Content-Type"] = "application/json";
    myoptions.headers!["app_version"] = appVersion;
    var response = await _dio.post(demiseUrl, data: demiseEntity, options: myoptions);
    //var response = await _dio.post(demiseUrl, data: demiseEntity);
    return response.data;
  }

  Future<List<DemiseEntity>> getDemisesByCities(DemisesSearchEntity demisesSearchEntity) async {
    Response res;
    try {
      res = await _dio.post(searchDemisesByCityUrl, data: demisesSearchEntity.toJson(), options: Options(headers: buildHeaders()));
    }
    on DioError catch (e) {
      return List.empty(growable: true);
    }
    if (res.statusCode != 201) {
      return List.empty(growable: true);
    }
    List<DemiseEntity> demises = (res.data as List).map((e) => DemiseEntity.fromJson(e)).toList();
    return demises;
  }

}