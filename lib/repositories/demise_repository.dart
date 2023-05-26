import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:ripapp_dashboard/constants/rest_path.dart';
import 'package:ripapp_dashboard/models/demise_entity.dart';

class DemiseRepository{
  static final DemiseRepository _demiseRepository = DemiseRepository._internal();

  final Dio _dio = Dio()..httpClientAdapter = BrowserHttpClientAdapter(withCredentials: true);

  DemiseRepository._internal();

  final String demiseUrl = "$baseUrl/api/auth/demiseWithoutCookie";



  factory DemiseRepository() {
    return _demiseRepository ;
  }

  Future<dynamic> saveProduct(DemiseEntity demiseEntity) async {
    print("a zi ma che stai a di");
    var response = await _dio.post(demiseUrl, data: demiseEntity.toJson());
    return response.data;
  }

}