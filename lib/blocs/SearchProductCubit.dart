



import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/models/product_entity.dart';
import 'package:ripapp_dashboard/repositories/product_repository.dart';
import 'package:ripapp_dashboard/widgets/snackbars.dart';
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

  delete(idProduct, BuildContext context)async{
    emit(SearchProductLoading());
    try{
      var result = await ProductRepository().deleteProduct(idProduct);
      SuccessSnackbar(context, text: 'Prodotto eliminato con successo!');
      fetchProducts();
    }catch(e){
      print("ERRORE");
      print(e);
      // todo capire l'errore ed in base all'errore mostrare la snackbar corretta
      ErrorSnackbar(context, text: 'Non puoi eliminare il prodotto perchè è presente nel catalogo di alcune agenzie');
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
