import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/models/product_entity.dart';
import 'package:ripapp_dashboard/repositories/agency_repository.dart';
import 'package:ripapp_dashboard/repositories/product_repository.dart';

@immutable
class SearchProductState{}
class SearchProductLoading extends SearchProductState {}
class SearchProductError extends SearchProductState {}
class SearchProductLoaded extends SearchProductState {

  final List<ProductEntity> availableProducts;
  final List<ProductEntity> agencyProducts;
  SearchProductLoaded(this.availableProducts, this.agencyProducts);

  SearchProductLoaded copyWith({List<ProductEntity>? availableProducts, List<ProductEntity>? agencyProducts,}) {
    return SearchProductLoaded(
        availableProducts ?? this.availableProducts,
        agencyProducts ?? this.agencyProducts
    );
  }

}


class SearchProductCubit extends Cubit<SearchProductState>{
  SearchProductCubit() : super(SearchProductLoading());

  fetchProducts() async {
    emit(SearchProductLoading());
    List<ProductEntity> availableProductsRetrieved = await ProductRepository().getAvailableProducts();
    List<ProductEntity> agencyProductsRetrieved = await AgencyRepository().getAllAgencyProducts();
    print("piccolo sunto della situazione: prodotti totali: " + availableProductsRetrieved.toString() + " \n prodotti miei: " + agencyProductsRetrieved.toString());
    if (availableProductsRetrieved.length == 0){print("non ci sono prodotti da mostrare");}
    else{
      try {
        emit(SearchProductLoaded(availableProductsRetrieved, agencyProductsRetrieved));
      }
      catch (e){
        print("error");
      }
    }
  }
}