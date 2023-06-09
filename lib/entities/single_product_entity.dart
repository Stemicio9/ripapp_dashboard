


import 'package:ripapp_dashboard/blocs/SearchProductsOfferedCubit.dart';
import 'package:ripapp_dashboard/constants/images_constants.dart';
import 'package:ripapp_dashboard/models/ProductOffered.dart';



class SingleProductEntity {
  final int id; //fixme vedere se questo id va bene, l'ho aggiunto ma non so se logicamente va messo
  final String name;
  final String price;
  final String urlImage;
  bool isSelected;
  final Function(SingleProductEntity, SearchProductsOfferedLoaded) onTap;

  SingleProductEntity({
    this.id = 0,
    this.name = "Product",
    this.price = "Price",
    this.urlImage = ImagesConstants.imgProductPlaceholder,
    this.isSelected = false,
    this.onTap = constantFunction});

  static void constantFunction(SingleProductEntity singleProductEntity, SearchProductsOfferedLoaded state){}


  SingleProductEntity copyWith({
    String? name, String? urlImage,String? price, bool? isSelected, Function(SingleProductEntity, SearchProductsOfferedLoaded)? onTap
  }){
    return SingleProductEntity(
        name : name ?? this.name,
        price : price ?? this.price,
        isSelected: isSelected ?? this.isSelected,
        urlImage : urlImage ?? this.urlImage,
        onTap : onTap ?? this.onTap

    );
  }

}