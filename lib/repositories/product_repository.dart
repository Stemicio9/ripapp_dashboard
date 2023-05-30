import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:ripapp_dashboard/models/product_entity.dart';
import 'package:ripapp_dashboard/repositories/user_repository.dart';

import '../constants/rest_path.dart';

class ProductRepository{
  static final ProductRepository _productRepository = ProductRepository._internal();
  final Dio _dio = Dio()..httpClientAdapter = BrowserHttpClientAdapter(withCredentials: true);
  ProductRepository._internal();
  //final String productUrl = "$baseUrl/api/auth/product/fine";
  final String productUrl = "$baseUrl/api/auth/productFromAdmin";


  factory ProductRepository() {
    return _productRepository ;
  }

  Future<dynamic> saveProduct(ProductEntity productEntity) async {
    print("3");
    print(productEntity);
    Map<String, String> values = {};
    values.putIfAbsent("idtoken", () => UserRepository().firebaseToken ?? "");
    var response = await _dio.post(productUrl, data: productEntity.toJson(), options: Options(headers: values));
    return response.data;
  }

}