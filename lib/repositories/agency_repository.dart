import 'dart:js_interop';

import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:ripapp_dashboard/authentication/firebase_authentication_listener.dart';
import 'package:ripapp_dashboard/constants/rest_path.dart';
import 'package:ripapp_dashboard/models/agency_entity.dart';


class AgencyRepository{
  static final AgencyRepository _agencyRepository = AgencyRepository._internal();
  final Dio _dio = Dio()..httpClientAdapter = BrowserHttpClientAdapter(withCredentials: true);
  AgencyRepository._internal();
  final String agencyUrl = "$baseUrl/api/auth/agency";
  final String allAgenciesUrl = "$baseUrl/api/auth/agencies";

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
    if (res.statusCode != 201) {
      return List.empty(growable: true);
    }
    List<AgencyEntity> agencies = (res.data as List).map((agency) => AgencyEntity.fromJson(agency)).toList();
    return agencies;
  }

}