import 'dart:js_interop';

import 'package:dio/dio.dart';
import 'package:ripapp_dashboard/authentication/firebase_authentication_listener.dart';
import 'package:ripapp_dashboard/constants/rest_path.dart';
import 'package:ripapp_dashboard/models/agency_entity.dart';


class AgencyRepository{
  static final AgencyRepository _agencyRepository = AgencyRepository._internal();
  final Dio _dio = Dio();
  AgencyRepository._internal();
  final String agencyUrl = "$baseUrl/api/auth/agency";

  factory AgencyRepository() {
    return _agencyRepository ;
  }

  Future<dynamic> saveAgency(AgencyEntity agencyEntity) async {
    print("Salvo l'agenzia..");
    Map<String, String> values = {};
    values.putIfAbsent("idtoken", () => CustomFirebaseAuthenticationListener().userEntity?.idtoken ?? "");
    values.putIfAbsent("agency", () => agencyEntity.toJson().toString());
    var response = await _dio.post(agencyUrl, data: values);
    return response.data;
  }

}