import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/entities/single_product_entity.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/utils/style_utils.dart';

class SingleProduct extends StatelessWidget {
  final SingleProductEntity singleProductEntity;

  const SingleProduct({Key? key, required this.singleProductEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          singleProductEntity.onTap(singleProductEntity);
        },
        child: Card(
          elevation: 5,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                  color: singleProductEntity.isSelected ? background : white,
                  width: 2)),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(3)),
                      color: greyDrag,
                      border: Border.all(
                        color: background,
                        width: 1,
                      ),
                      image: DecorationImage(
                        image: AssetImage(singleProductEntity.urlImage),
                        fit: BoxFit.cover,
                      )),
                ),
                Padding(
                  padding: getPadding(top: 25),
                  child: Text(
                    singleProductEntity.name,
                    style: SafeGoogleFont(
                        'Montserrat',
                        fontSize: 14,
                        color: background,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                Container(
                  width: 60,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Divider(
                    thickness: 1,
                    color: blackDivider,

                  ),
                ),

                 Text(
                    "€ ${singleProductEntity.price}",
                    style: SafeGoogleFont(
                        'Montserrat',
                        fontSize: 14,
                        color: background,
                        fontWeight: FontWeight.bold),
                  ),

              ],
            ),
          ),
        ));
  }
}
