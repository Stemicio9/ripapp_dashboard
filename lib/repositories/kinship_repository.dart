import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:ripapp_dashboard/constants/kinships.dart';
import 'package:ripapp_dashboard/constants/rest_path.dart';
import 'package:ripapp_dashboard/repositories/user_repository.dart';

class KinshipRepository{
  static final KinshipRepository _kinshipRepository = KinshipRepository._internal();
  KinshipRepository._internal();
  final String allKinshipUrl = "$baseUrl/api/auth/kinships";


  factory KinshipRepository() {
    return _kinshipRepository ;
  }

  Future<List<Kinship>> getAllKinship() async {
    print("qui ci arrivo!");
    Response res = await globalDio.get(allKinshipUrl);
    List<Kinship> kinship = (res.data as List).map((kinship) => Kinship.fromJson(kinship)).toList();
    return kinship ;

    /*
    json["agency"] != null ? AgencyEntity.fromJson(json["agency"]) : null,
    UserStatus.fromJson(json['status'])
    List<Kinship> productsOffered =  (jsonDecode(jsonEncode(res.data)) as List).map((e) => ProductOffered.fromJson(e)).toList();
    print(productsOffered);
    List<ProductOffered> products = (res.data as List).map((product) => ProductOffered.fromJson(product)).toList();*/
    List<Kinship> kinships = (res.data as List).map((kinship) => Kinship.fromJson(kinship)).toList();
    //print(res);

    //List<Kinship> kinships = (jsonDecode(jsonEncode(res.data)) as List).map((e) => Kinship.fromJson(e)).toList();;
    return kinships;
  }

}