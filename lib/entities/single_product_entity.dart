


import 'package:ripapp_dashboard/constants/images_constants.dart';



class SingleProductEntity {
  final String name;
  final String price;
  final String urlImage;
  bool isSelected;
  final Function(SingleProductEntity) onTap;

  SingleProductEntity({
    this.name = "Product",
    this.price = "Price",
    this.urlImage = ImagesConstants.imgProductPlaceholder,
    this.isSelected = false,
    this.onTap = constantFunction});

  static void constantFunction(SingleProductEntity singleProductEntity){}


  SingleProductEntity copyWith({
    String? name, String? urlImage,String? price, bool? isSelected, Function(SingleProductEntity)? onTap
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