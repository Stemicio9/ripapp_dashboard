import 'package:dio/dio.dart';
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
    var response = await _dio.post(agencyUrl, data: agencyEntity);
    return response.data;
  }

}