import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/models/ProductOffered.dart';
import 'package:ripapp_dashboard/models/agency_entity.dart';
import 'package:ripapp_dashboard/models/product_entity.dart';
import 'package:ripapp_dashboard/repositories/agency_repository.dart';
import 'package:ripapp_dashboard/repositories/product_repository.dart';


@immutable
class SearchProductsOfferedState{}
class SearchProductsOfferedLoading extends SearchProductsOfferedState {}
class SearchProductsOfferedError extends SearchProductsOfferedState {}
class SearchProductsOfferedLoaded extends SearchProductsOfferedState {

  final List<ProductOffered> productsOffered;
  SearchProductsOfferedLoaded(this.productsOffered);

  SearchProductsOfferedLoaded copyWith({List<ProductOffered>? productsOffered,}) {
    return SearchProductsOfferedLoaded(
      productsOffered ?? this.productsOffered,
    );
  }

}


class SearchProductsOfferedCubit extends Cubit<SearchProductsOfferedState>{
  SearchProductsOfferedCubit() : super(SearchProductsOfferedLoading());

  fetchProducts() async {
    emit(SearchProductsOfferedLoading());
    List<ProductOffered> agencyProductsRetrieved = await AgencyRepository().getAllAgencyProducts();
    if (agencyProductsRetrieved.length == 0){print("non ci sono prodotti da mostrare");}
    else{
      try {
        emit(SearchProductsOfferedLoaded(agencyProductsRetrieved));
      }
      catch (e){
        print("error");
      }
    }
  }

  void changeSelectedProducts() {
    if (state is SearchProductsOfferedLoaded) {
      var aLoadedState = state as SearchProductsOfferedLoaded; //prende lo stato corrente
      emit(aLoadedState.copyWith());
    }
  }
}