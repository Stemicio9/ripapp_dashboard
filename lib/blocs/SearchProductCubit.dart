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

  final List<ProductOffered> productsOffered;
  SearchProductLoaded(this.productsOffered);

  SearchProductLoaded copyWith({List<ProductOffered>? productsOffered,}) {
    return SearchProductLoaded(
        productsOffered ?? this.productsOffered,
    );
  }

}


class SearchProductCubit extends Cubit<SearchProductState>{
  SearchProductCubit() : super(SearchProductLoading());

  fetchProducts() async {
    emit(SearchProductLoading());
    List<ProductOffered> agencyProductsRetrieved = await AgencyRepository().getAllAgencyProducts();
    print("piccolo sunto della situazione: " + agencyProductsRetrieved.toString());
    if (agencyProductsRetrieved.length == 0){print("non ci sono prodotti da mostrare");}
    else{
      try {
        emit(SearchProductLoaded(agencyProductsRetrieved));
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