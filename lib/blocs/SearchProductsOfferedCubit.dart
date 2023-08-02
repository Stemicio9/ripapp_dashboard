import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/models/ProductOffered.dart';
import 'package:ripapp_dashboard/repositories/agency_repository.dart';


@immutable
class SearchProductsOfferedState{}
class SearchProductsOfferedLoading extends SearchProductsOfferedState {}
class SearchProductsOfferedError extends SearchProductsOfferedState {}
class SearchProductsOfferedEmpty extends SearchProductsOfferedState {}
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
    if (agencyProductsRetrieved.isEmpty){
      emit(SearchProductsOfferedEmpty());
      return;
    }
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