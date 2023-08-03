import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/authentication/firebase_authentication_listener.dart';
import 'package:ripapp_dashboard/models/ProductOffered.dart';
import 'package:ripapp_dashboard/models/agency_entity.dart';
import 'package:ripapp_dashboard/models/demise_entity.dart';
import 'package:ripapp_dashboard/models/product_entity.dart';
import 'package:ripapp_dashboard/models/user_entity.dart';
import 'package:ripapp_dashboard/repositories/agency_repository.dart';
import 'package:ripapp_dashboard/repositories/demise_repository.dart';
import 'package:ripapp_dashboard/repositories/product_repository.dart';
import 'package:ripapp_dashboard/repositories/user_repository.dart';
import 'package:ripapp_dashboard/utils/ResultSet.dart';
import 'package:ripapp_dashboard/widgets/scaffold.dart';
import 'package:ripapp_dashboard/widgets/snackbars.dart';

@immutable
class CurrentPageState {
   String page;
   int pageNumber;
  final List<ResultEntity> resultSet;
  final bool loading;
  int totalPages;

  CurrentPageState(this.page, this.resultSet, this.loading, this.pageNumber, this.totalPages);

  CurrentPageState copyWith(
      {String? page, List<ResultEntity>? resultSet,
        bool? loading, int? pageNumber,
        int? totalPages
      }) {
    return CurrentPageState(
        page ?? this.page,
        resultSet ?? this.resultSet,
        loading ?? this.loading,
        pageNumber ?? this.pageNumber,
        totalPages ?? this.totalPages
    );
  }
}


class CurrentPageCubit extends Cubit<CurrentPageState> {

  CurrentPageCubit() : super(CurrentPageState("", [], true, 0, 0));

  Future<List<ResultEntity>?> findResult(String pageName, int index) async {
    List<ResultEntity>? result;
    if (pageName == ScaffoldWidgetState.users_page){
      var goodJson = await UserRepository().getListWithIndex(index);
      var list = (jsonDecode(goodJson) as Map)["content"] as List;
      List<UserEntity> users = (list).map((user) => UserEntity.fromJson(user)).toList();
      state.totalPages = (jsonDecode(goodJson) as Map)["totalPages"] ?? 0;
      result = users;
    }
    else if (pageName == ScaffoldWidgetState.agencies_page){
      var goodJson = await AgencyRepository().getAgenciesWithIndex(index);
      var list = (jsonDecode(goodJson) as Map)["content"] as List;
      List<AgencyEntity> agencies = (list).map((agency) => AgencyEntity.fromJson(agency)).toList();
      state.totalPages = (jsonDecode(goodJson) as Map)["totalPages"] ?? 0;
      result = agencies;
    }
    else if (pageName == ScaffoldWidgetState.products_page){
      var goodJson = await ProductRepository().getAllProductsWithIndex(index);
      var list = (jsonDecode(goodJson) as Map)["content"] as List;
      List<ProductEntity> products = (list).map((product) => ProductEntity.fromJson(product)).toList();
      state.totalPages = (jsonDecode(goodJson) as Map)["totalPages"] ?? 0;
      result = products;
    }
    else if (pageName == ScaffoldWidgetState.agency_products_page){
      var goodJson = await AgencyRepository().getAllAgencyProductsWithIndex(index);
      var list = (jsonDecode(goodJson) as Map)["content"] as List;
      List<ProductEntity> products = (list).map((product) => ProductEntity.fromJson(product)).toList();
      state.totalPages = (jsonDecode(goodJson) as Map)["totalPages"] ?? 0;
      result = products;
    }
    else if (pageName == ScaffoldWidgetState.agency_demises_page){
      var goodJson = await DemiseRepository().getDemisesPaginated(index);
      var list = (jsonDecode(goodJson) as Map)["content"] as List;
      List<DemiseEntity> products = (list).map((demise) => DemiseEntity.fromJson(demise)).toList();
      state.totalPages = (jsonDecode(goodJson) as Map)["totalPages"] ?? 0;
      result = products;
    }
    return result;
  }

  void refreshPage() async {
    emit(CurrentPageState(state.page, [], true, state.pageNumber, state.totalPages));
    List<ResultEntity>? resultSet = await findResult(state.page, state.pageNumber);
    emit(CurrentPageState(state.page, resultSet!, false, state.pageNumber, state.totalPages));
  }

  signup(UserEntity userEntity) async {
    try {
      var result = await UserRepository().signup(userEntity);
      refreshPage();
    } catch (e) {
      print(e);
    }
  }

  deleteUser(idUser) async {
    try {
      var result = await UserRepository().deleteUser(idUser);
      if(state.resultSet.length == 1){
        state.pageNumber = state.pageNumber-1;
      }
      refreshPage();
    } catch (e) {
      print(e);
    }
  }

  editUser(UserEntity userEntity) async {
    try{
      var result = await UserRepository().editUser(userEntity);
      refreshPage();
    }catch(e){
      print(e);
    }
  }


  addAgency(AgencyEntity agencyEntity) async {
    try {
      var result = await AgencyRepository().saveAgency(agencyEntity);
      refreshPage();
    } catch (e) {
      print(e);
    }
  }

  editAgency(AgencyEntity agencyEntity) async {
    try {
      var result = await AgencyRepository().editAgency(agencyEntity);
      refreshPage();
    } catch (e) {
      print(e);
    }
  }
  deleteAgency(idAgency) async {
    try {
      var result = await AgencyRepository().removeAgency(idAgency);
      if(state.resultSet.length == 1){
        state.pageNumber = state.pageNumber-1;
      }
      refreshPage();
    } catch (e) {
      print(e);
    }
  }


  addProduct(ProductEntity productEntity) async {
    try {
      var result = await ProductRepository().saveProduct(productEntity);
      refreshPage();
    } catch (e) {
      print(e);
    }
  }

  editProduct(ProductEntity productEntity) async {
    try {
      var result = await ProductRepository().editProduct(productEntity);
      refreshPage();
    } catch (e) {
      print(e);
    }
  }

  Future deleteProduct(productId) async {
      var result = await ProductRepository().deleteProduct(productId);
      if(state.resultSet.length == 1){
        state.pageNumber = state.pageNumber-1;
      }
      refreshPage();

  }


  setAgencyProducts(List<ProductOffered> productsOffered) async {
      var result =  await AgencyRepository().setAgencyProducts(productsOffered);
      state.pageNumber = 0;
      refreshPage();

  }

  void updateDemise(DemiseEntity demiseEntity){
    try{
      DemiseRepository().updateDemise(demiseEntity);
      refreshPage();
    }catch(e){
      print(e);
    }
  }

  void addDemise(DemiseEntity demiseEntity){
    try{
      DemiseRepository().saveDemise(demiseEntity);
      refreshPage();
    }catch(e){
      print(e);
    }
  }

  Future editProfile(context, UserEntity userEntity) async{
    /*UserRepository().editUser(userEntity).then((res) {
      //CustomFirebaseAuthenticationListener().userEntity = res;
      String? token = CustomFirebaseAuthenticationListener().tokenId;
      if (token != null){
        UserRepository().loginPreLayer(token);
      }
      SuccessSnackbar(context, text: "Profilo modificato con successo");
    }, onError: (e) {
      ErrorSnackbar(context, text: "Errore generico durante la modifica dell\'utente");
    });*/
    return UserRepository().editUser(userEntity);
  }



  void loadPage(String page, int index) async {
    emit(CurrentPageState(page, const [], true, index, state.totalPages));
    List<ResultEntity>? resultSet = await findResult(page, index);
    emit(CurrentPageState(page, resultSet!, false, index, state.totalPages));
  }

  void changeCurrentPage(String page) {
    emit(state.copyWith(page: page));
  }


}