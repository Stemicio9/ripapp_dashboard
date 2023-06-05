import 'dart:convert';
import 'dart:js_interop';

import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:ripapp_dashboard/authentication/firebase_authentication_listener.dart';
import 'package:ripapp_dashboard/constants/rest_path.dart';
import 'package:ripapp_dashboard/models/ProductOffered.dart';
import 'package:ripapp_dashboard/models/agency_entity.dart';
import 'package:ripapp_dashboard/models/product_entity.dart';
import 'package:ripapp_dashboard/models/user_entity.dart';


class AgencyRepository{
  static final AgencyRepository _agencyRepository = AgencyRepository._internal();
  final Dio _dio = Dio()..httpClientAdapter = BrowserHttpClientAdapter(withCredentials: true);
  AgencyRepository._internal();
  final String agencyUrl = "$baseUrl/api/auth/agency";
  final String allAgenciesUrl = "$baseUrl/api/auth/agencies";
  final String allAgenciesProductsUrl = "$baseUrl/api/auth/products";
  final String allProductsOfferedByAgency = "$baseUrl/api/auth/productsOffered";

  factory AgencyRepository() {
    return _agencyRepository ;
  }

  Future<dynamic> saveAgency(AgencyEntity agencyEntity) async {
    //print(agencyEntity.toJson());
    var response = await _dio.post(agencyUrl, data: agencyEntity.toJson());
    return response.data;
  }

  Future<List<AgencyEntity>> getAgencies() async {
    Response res;
    try {
      res = await _dio.get(allAgenciesUrl);
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
    var userId = (user != null) ? user.id : "4";
    parameters.putIfAbsent("offset", () => 0);
    parameters.putIfAbsent("userid", () => userId!);
    Response res = await _dio.get(allProductsOfferedByAgency, queryParameters: parameters);
    print("qualcosa");
    List<ProductOffered> productsOffered =  (jsonDecode(jsonEncode(res.data)) as List).map((e) => ProductOffered.fromJson(e)).toList();
    print(productsOffered);
    List<ProductOffered> products = (res.data as List).map((product) => ProductOffered.fromJson(product)).toList();
    return products;
  }

  void setAgencyProducts(List<ProductOffered> productsOffered) async {
    UserEntity? user = CustomFirebaseAuthenticationListener().userEntity;
    var userId = (user != null) ? user.id : "4";
    Map<String, dynamic>? parameters = {};
    parameters.putIfAbsent("userid", () => userId);
    //_dio.post(allProductsOfferedByAgency, data: productsOffered, queryParameters: parameters);
  }

}