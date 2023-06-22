
import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:ripapp_dashboard/authentication/firebase_authentication_listener.dart';
import 'package:ripapp_dashboard/models/ProductOffered.dart';
import 'package:ripapp_dashboard/models/product_entity.dart';
import 'package:ripapp_dashboard/models/user_entity.dart';
import 'package:ripapp_dashboard/repositories/user_repository.dart';

import '../constants/rest_path.dart';

class ProductRepository{
  static final ProductRepository _productRepository = ProductRepository._internal();
  final Dio _dio = Dio()..httpClientAdapter = BrowserHttpClientAdapter(withCredentials: true);
  ProductRepository._internal();
  //final String productUrl = "$baseUrl/api/auth/product/fine";
  final String productUrl = "$baseUrl/api/auth/productFromAdmin";
  final String allProductsUrl = "$baseUrl/api/auth/all-products";
  final String deleteProductUrl = "$baseUrl/api/auth/delete";


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


  Future<dynamic> deleteProduct(int idProduct) async{
    String urlDeleteProduct = '$deleteProductUrl/$idProduct';
    var response = await _dio.delete(urlDeleteProduct);
    return response.data;
  }
  Future<dynamic> getAllProducts() async {
    UserEntity? user = CustomFirebaseAuthenticationListener().userEntity;
    var userId = (user != null) ? user.id : 48;
    Map<String, dynamic>? parameters = {};
    parameters.putIfAbsent("userId", () => userId);
    var response = await _dio.get(allProductsUrl, queryParameters: parameters);
    List<ProductEntity> products = (response.data as List).map((product) => ProductEntity.fromJson(product)).toList();
    return products;
  }

}