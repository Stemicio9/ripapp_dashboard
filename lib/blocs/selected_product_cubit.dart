import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/models/product_entity.dart';

@immutable
class SelectedProductState {
  final ProductEntity selectedProduct;


  const SelectedProductState({required this.selectedProduct});
}

class SelectedProductCubit extends Cubit<SelectedProductState> {
  SelectedProductCubit() : super(SelectedProductState(selectedProduct: ProductEntity.emptyProduct()));

  selectProduct(ProductEntity selectedProduct)async{
    print("cambio il prodotto selezionato, che è $selectedProduct");
    emit(SelectedProductState(selectedProduct: selectedProduct));
    print(selectedProduct);
  }

}