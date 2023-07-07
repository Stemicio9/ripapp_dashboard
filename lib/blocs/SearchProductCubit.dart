



import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/models/product_entity.dart';
import 'package:ripapp_dashboard/repositories/product_repository.dart';
import 'package:ripapp_dashboard/utils/DeleteProductMessage.dart';
@immutable
class SearchProductState{}
class SearchProductLoading extends SearchProductState {}
class SearchProductError extends SearchProductState {
  String errorMessage;
  SearchProductError(this.errorMessage);
}
class SearchProductLoaded extends SearchProductState {

  final List<ProductEntity> products;
  SearchProductLoaded(this.products);

  SearchProductLoaded copyWith({List<ProductEntity>? productsOffered,}) {
    return SearchProductLoaded(
        productsOffered ?? this.products,
    );
  }

}
class SaveProductLoaded extends SearchProductState {

  final ProductEntity productSaved;
  SaveProductLoaded(this.productSaved);

  SaveProductLoaded copyWith({ProductEntity? productSaved,}) {
    return SaveProductLoaded(
      productSaved ?? this.productSaved,
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
      DeleteProductMessage deleteMessage = await ProductRepository().deleteProduct(idProduct);
      fetchProducts();
    }catch(e){
      emit(SearchProductError(e.toString()));
    }
  }
   saveProduct(ProductEntity productEntity) async{
    emit(SearchProductLoading());
    try{
      var response = await ProductRepository().saveProduct(productEntity);
      ProductEntity p = ProductEntity.fromJson(response);
      fetchProducts();
    }catch(e){
      emit(SearchProductError(e.toString()));
    }
  }

  editProduct(ProductEntity productEntity) async {
    emit(SearchProductLoading());
    try{
      var response = await ProductRepository().editProduct(productEntity);
      print("HO EDITATO IL PRODOTTO");
      ProductEntity p = ProductEntity.fromJson(response);
      fetchProducts();
    }catch(e){
      print(e);
      emit(SearchProductError(e.toString()));
    }
  }

  void fetchProductsWithIndex(int pageIndex) async{
    emit(SearchProductLoading());
    try {
      var result = await ProductRepository().getAllProductsWithIndex(pageIndex).then((products) => emit(SearchProductLoaded(products)));
    }
    catch (e){
      print("error");

    }
  }
}
