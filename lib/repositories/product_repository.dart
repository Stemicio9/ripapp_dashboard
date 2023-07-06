
import 'dart:convert';

import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:ripapp_dashboard/authentication/firebase_authentication_listener.dart';
import 'package:ripapp_dashboard/models/ProductOffered.dart';
import 'package:ripapp_dashboard/models/product_entity.dart';
import 'package:ripapp_dashboard/models/user_entity.dart';
import 'package:ripapp_dashboard/repositories/user_repository.dart';
import 'package:ripapp_dashboard/utils/AccountSearchEntity.dart';
import 'package:ripapp_dashboard/utils/DeleteProductMessage.dart';

import '../constants/rest_path.dart';

class ProductRepository{
  static final ProductRepository _productRepository = ProductRepository._internal();
  ProductRepository._internal();
  //final String productUrl = "$baseUrl/api/auth/product/fine";
  final String productUrl = "$baseUrl/api/auth/productFromAdmin";
  final String updateProductUrl = "$baseUrl/api/auth/productFromAdmin/update";
  final String allProductsUrl = "$baseUrl/api/auth/all-products";
  final String deleteProductUrl = "$baseUrl/api/auth/delete";
  final String indexedProductsUrl =  "$baseUrl/api/auth/productsWithIndex";


  factory ProductRepository() {
    return _productRepository ;
  }

  Future<dynamic> saveProduct(ProductEntity productEntity) async {
    Map<String, String> values = {};
    String? token = await UserRepository().getFirebaseToken();
    values.putIfAbsent("idtoken", () => token ?? "");
    var response = await globalDio.post(productUrl, data: productEntity.toJson(), options: Options(headers: values));
    return response.data;
  }


  Future<DeleteProductMessage> deleteProduct(int idProduct) async{
    String urlDeleteProduct = '$deleteProductUrl/$idProduct';
    print("b1");
    var response = await globalDio.delete(urlDeleteProduct);
    print("response è " + response.data.toString());
    DeleteProductMessage deleteProductMessage = DeleteProductMessage.fromJson(response.data);
    if (deleteProductMessage.message!.startsWith("il prodotto è già in uso da parte di"))
      throw new Exception(deleteProductMessage.message);
    return deleteProductMessage;
  }
  Future<dynamic> getAllProducts() async {
    UserEntity? user = CustomFirebaseAuthenticationListener().userEntity;
    var userId = (user != null) ? user.id : 48;
    Map<String, dynamic>? parameters = {};
    parameters.putIfAbsent("userId", () => userId);
    var response = await globalDio.get(allProductsUrl, queryParameters: parameters);
    List<ProductEntity> products = (response.data as List).map((product) => ProductEntity.fromJson(product)).toList();
    return products;
  }

  Future<List<ProductEntity>> getAllProductsWithIndex(int pageIndex) async {
    Map<String, dynamic>? parameters = {};
    int pageNumber = 1;
    int pageElements = 9;
    AccountSearchEntity searchEntity = AccountSearchEntity(pageNumber: pageNumber, pageElements: pageElements);
    parameters.putIfAbsent("pageNumber", () => (pageIndex));
    parameters.putIfAbsent("pageElements", () => searchEntity.pageElements);
    Response response;
    response = await globalDio.get(indexedProductsUrl, queryParameters: parameters);
    String goodJson = jsonEncode(response.data);
    //print("ecco il tuo content" + ((jsonDecode(goodJson) as Map)["content"] as List).toString());
    List<ProductEntity> products = ((jsonDecode(goodJson) as Map)["content"] as List).map((product) => ProductEntity.fromJson(product)).toList();
    return products;
  }

  editProduct(ProductEntity productEntity) async{
      Map<String, String> values = {};
      String token = await UserRepository().getFirebaseToken();
      values.putIfAbsent("idtoken", () => token ?? "");
      var response = await globalDio.post(updateProductUrl, data: productEntity.toJson(), options: Options(headers: values));
      return response.data;
  }

}