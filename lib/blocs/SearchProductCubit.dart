



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
    List<ProductEntity> productsRetrieved = await ProductRepository().getAllProducts();
    if (productsRetrieved.length == 0){print("non ci sono prodotti da mostrare");}
    else{
      try {
        emit(SearchProductLoaded(productsRetrieved));
      }
      catch (e){
        print("error");
      }
    }
  }

  void changeSelectedProducts() {
    if (state is SearchProductLoaded) {
      var aLoadedState = state as SearchProductLoaded; //prende lo stato corrente
      emit(aLoadedState.copyWith());
    }
  }
}
