

import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/entities/single_product_entity.dart';

class SingleProduct extends StatelessWidget {

  final SingleProductEntity singleProductEntity;

  const SingleProduct({Key? key, required this.singleProductEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return GestureDetector(
       onTap: (){singleProductEntity.onTap(singleProductEntity);},
       child: Card(
           margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(10),
             side: BorderSide(
                 color: singleProductEntity.isSelected ? background : white,
                 width: 3
             )
           ),
         child:  Padding(
           padding: const EdgeInsets.all(20),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               Text(singleProductEntity.name),
               Container(
                 height: 80,
                 width: 80,
                 decoration: BoxDecoration(
                     borderRadius: const BorderRadius.all(Radius.circular(3)),
                     color: greyDrag,
                     border: Border.all(
                       color: background,
                       width: 1,
                     ),
                     image: DecorationImage(
                       image: AssetImage(
                           singleProductEntity.urlImage),
                       fit: BoxFit.cover,
                     )),
               ),
             ],
           ),
         ),
       )
     );
  }
}
