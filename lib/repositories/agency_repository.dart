import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ripapp_dashboard/authentication/firebase_authentication_listener.dart';
import 'package:ripapp_dashboard/constants/rest_path.dart';
import 'package:ripapp_dashboard/models/ProductOffered.dart';
import 'package:ripapp_dashboard/models/agency_entity.dart';
import 'package:ripapp_dashboard/models/product_entity.dart';
import 'package:ripapp_dashboard/models/user_entity.dart';
import 'package:ripapp_dashboard/repositories/user_repository.dart';
import 'package:ripapp_dashboard/utils/AccountSearchEntity.dart';
import 'package:ripapp_dashboard/utils/SaveAgencyMessage.dart';
import 'package:ripapp_dashboard/utils/UpdateAgencyMessage.dart';


class AgencyRepository{
  static final AgencyRepository _agencyRepository = AgencyRepository._internal();
  AgencyRepository._internal();
  final String agencyUrl = "$baseUrl/api/auth/agency";
  final String updateAgencyUrl = "$baseUrl/api/auth/agency/update";
  final String allAgenciesUrl = "$baseUrl/api/auth/agencies";
  final String allAgenciesProductsUrl = "$baseUrl/api/auth/products";
  final String allProductsOfferedByAgency = "$baseUrl/api/auth/productsOffered";
  final String allProductsOfferedByAgencyPaginated = "$baseUrl/api/auth/productsOfferedPaginated";
  final String indexedAgenciesUrl =  "$baseUrl/api/auth/agenciesWithIndex";
  final String deleteAgency ="$baseUrl/api/auth/agency";
  factory AgencyRepository() {
    return _agencyRepository ;
  }

  Future<dynamic> saveAgency(AgencyEntity agencyEntity) async {
    var response = await globalDio.post(agencyUrl, data: agencyEntity.toJson());
    SaveAgencyMessage saveAgencyMessage = SaveAgencyMessage.fromJson(response.data);

    if (saveAgencyMessage.message!.startsWith("Duplicate entry")) {
      throw Exception(saveAgencyMessage.message);
    }
    return saveAgencyMessage;
  }

  Future<dynamic> editAgency(AgencyEntity agencyEntity) async {
    var response = await globalDio.post(updateAgencyUrl, data: agencyEntity.toJson());
    UpdateAgencyMessage updateAgencyMessage = UpdateAgencyMessage.fromJson(response.data);
    return updateAgencyMessage;
  }


  Future<List<AgencyEntity>> getAgencies() async {
    Response res;
    try {
      res = await globalDio.get(allAgenciesUrl);
    }
    on DioError catch (e) {
      return List.empty(growable: true);
    }
    if (res.statusCode != 200) {
      return List.empty(growable: true);
    }
    List<AgencyEntity> agencies = (res.data as List).map((agency) => AgencyEntity.fromJson(agency)).toList();
    print("listaaaaaaa");
    print(agencies);
    return agencies;
  }

  Future<List<ProductOffered>> getAllAgencyProducts() async {
    Map<String, dynamic>? parameters = {};
    UserEntity? user = CustomFirebaseAuthenticationListener().userEntity;
    var userId = (user != null) ? user.id : "48";
    parameters.putIfAbsent("offset", () => 0);
    parameters.putIfAbsent("userid", () => userId!);
    Response res = await globalDio.get(allProductsOfferedByAgency, queryParameters: parameters);
    print("qualcosa");
    List<ProductOffered> productsOffered =  (jsonDecode(jsonEncode(res.data)) as List).map((e) => ProductOffered.fromJson(e)).toList();
    print(productsOffered);
    List<ProductOffered> products = (res.data as List).map((product) => ProductOffered.fromJson(product)).toList();
    return products;
  }

  Future<String> getAllAgencyProductsWithIndex(int pageIndex) async {
    Map<String, dynamic>? parameters = {};
    int pageNumber = 1;
    int pageElements = 5;
    AccountSearchEntity searchEntity = AccountSearchEntity(pageNumber: pageNumber, pageElements: pageElements);
    UserEntity? user = CustomFirebaseAuthenticationListener().userEntity;
    var userId = (user != null) ? user.id : "48";
    parameters.putIfAbsent("pageNumber", () => (pageIndex));
    parameters.putIfAbsent("pageElements", () => searchEntity.pageElements);
    parameters.putIfAbsent("userid", () => userId!);
    Response response;
    response = await globalDio.get(allProductsOfferedByAgencyPaginated, queryParameters: parameters);
    String goodJson = jsonEncode(response.data);
    var list = (jsonDecode(goodJson) as Map)["content"] as List;
    List<ProductEntity> products = (list).map((product) => ProductEntity.fromJson(product)).toList();
    return goodJson;
  }

  Future setAgencyProducts(List<ProductOffered> productsOffered) async {
    UserEntity? user = CustomFirebaseAuthenticationListener().userEntity;
    print("utente agenzia che tenta di cambiare i prodotti: $user");
    var userId = (user != null) ? user.id : "48";
    Map<String, dynamic>? parameters = {};
    parameters.putIfAbsent("userid", () => userId);

    Options myoptions = Options();
    Map<String, Object>? headers = Map();
    myoptions.headers = headers;
    //myoptions.headers!["set-cookie"] = "idtoken=123;";
    myoptions.headers!["Content-Type"] = "application/json";
    myoptions.headers!["app_version"] = appVersion;

    await globalDio.post(allProductsOfferedByAgency, data: productsOffered, queryParameters: parameters, options: myoptions);
  }

  Future<dynamic> removeAgency(int idAgency) async{
    String urlDeleteAgency = '$deleteAgency/$idAgency';
    var response = await globalDio.delete(urlDeleteAgency);
    return response.data;
  }

  Future<String> getAgenciesWithIndex(int pageIndex) async {
    Map<String, dynamic>? parameters = {};
    int pageNumber = 1;
    int pageElements = 10;
    AccountSearchEntity searchEntity = AccountSearchEntity(pageNumber: pageNumber, pageElements: pageElements);
    parameters.putIfAbsent("pageNumber", () => (pageIndex));
    parameters.putIfAbsent("pageElements", () => searchEntity.pageElements);
    Response response;
    print("sto facendo la richiesta con indice: $pageIndex");
    response = await globalDio.get(indexedAgenciesUrl, queryParameters: parameters);
    String goodJson = jsonEncode(response.data);
    var list = (jsonDecode(goodJson) as Map)["content"] as List;
    List<AgencyEntity> agencies = (list).map((agency) => AgencyEntity.fromJson(agency)).toList();
   // List<AgencyEntity> agencies = ((jsonDecode(goodJson) as Map)["content"] as List).map((agency) => AgencyEntity.fromJson(agency)).toList();
    return goodJson;
  }

}