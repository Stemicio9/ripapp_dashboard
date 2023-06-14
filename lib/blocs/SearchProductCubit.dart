



import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/models/ProductOffered.dart';
import 'package:ripapp_dashboard/models/agency_entity.dart';
import 'package:ripapp_dashboard/models/product_entity.dart';
import 'package:ripapp_dashboard/repositories/agency_repository.dart';
import 'package:ripapp_dashboard/repositories/product_repository.dart';
@immutable
class SearchProductState{}
class SearchProductLoading extends SearchProductState {}
class SearchProductError extends SearchProductState {}
class SearchProductLoaded extends SearchProductState {

  final List<ProductEntity> products;
  SearchProductLoaded(this.products);

  SearchProductLoaded copyWith({List<ProductEntity>? productsOffered,}) {
    return SearchProductLoaded(
        productsOffered ?? this.products,
    );
  }

}


class SearchProductCubit extends Cubit<SearchProductState>{
  SearchProductCubit() : super(SearchProductLoading());

  fetchProducts() async {
    emit(SearchProductLoading());
    try {
      var result = await ProductRepository().getAllProducts().then((products) => emit(SearchProductLoaded(products)));
    }
    catch (e){
      print("error");

    }
  }

  delete(idProduct)async{
    emit(SearchProductLoading());
    try{
      var result = await ProductRepository().deleteProduct(idProduct);
      fetchProducts();
    }catch(e){
      print("ERRORE");
      print(e);
      emit(SearchProductError());
    }
  }

  saveProduct(ProductEntity productEntity) async{
    emit(SearchProductLoading());
    try{
      var result = await ProductRepository().saveProduct(productEntity);
      fetchProducts();
    }catch(e){
      emit(SearchProductError());
    }
  }
}
