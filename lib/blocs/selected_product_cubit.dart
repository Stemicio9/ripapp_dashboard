import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/constants/images_constants.dart';
import 'package:ripapp_dashboard/models/product_entity.dart';

@immutable
class SelectedProductState {
  final ProductEntity selectedProduct;
  String imageUrl;


  SelectedProductState({required this.selectedProduct, required this.imageUrl});
}

class SelectedProductCubit extends Cubit<SelectedProductState> {
  SelectedProductCubit() : super(SelectedProductState(selectedProduct: ProductEntity.emptyProduct(), imageUrl: ImagesConstants.imgDemisePlaceholder));

  Future<dynamic> downloadUrlImage(String? firebaseId) async {
    var fileList = await FirebaseStorage.instance.ref('profile_images/products_images/productid:$firebaseId/').listAll();
    if (fileList.items.isEmpty) {
      var fileList = await FirebaseStorage.instance.ref('profile_images/').listAll();
      var file = fileList.items[0];
      var result = await file.getDownloadURL();
      return result;
    }
    var file = fileList.items[0];
    var result = await file.getDownloadURL();
    return result;
  }

  selectProduct(ProductEntity selectedProduct) async {
    var a = await downloadUrlImage(selectedProduct.firebaseId);
    emit(SelectedProductState(selectedProduct: selectedProduct, imageUrl: a));

    print(selectedProduct);
  }

}