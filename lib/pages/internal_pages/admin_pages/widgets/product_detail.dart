import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/blocs/selected_product_cubit.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/utils/style_utils.dart';
import 'package:ripapp_dashboard/widgets/dialog_card.dart';
import '../../../../constants/images_constants.dart';
import '../../../../widgets/texts.dart';

class ProductDetail extends StatelessWidget {
  final String cardTitle;
  late int id;
  late String name;
  late double price;
  final String productPhoto;
  final File? imageFile;

   ProductDetail({
    super.key,
    required this.cardTitle,
     this.name = "",
     this.id = 0,
     this.price = 0,
    required this.productPhoto,
    this.imageFile
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedProductCubit, SelectedProductState>(
        builder: (context, state) {
      if (state is SelectedProductState) {
        id = state.selectedProduct.id ?? 0;
        name = state.selectedProduct.name ?? "";
        price = state.selectedProduct.price ?? 0;
        return Container(
      padding: getPadding(left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 550,
            child: DialogCard(
                paddingLeft: 10,
                paddingRight: 10,
                cancelIcon: true,
                cardTitle: cardTitle,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                          color: greyDrag,
                          border: Border.all(color: background, width: 1),
                          image: imageFile != null ?
                          DecorationImage(
                            image: FileImage(imageFile!),
                            fit: BoxFit.contain,
                          ) :  DecorationImage(
                            image: AssetImage(ImagesConstants.imgProductPlaceholder),
                            fit: BoxFit.cover,
                          )
                      ),
                    ),


                    Padding(
                      padding: getPadding(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                          Padding(
                            padding: getPadding(bottom: 5),
                            child: Text(
                              'ID',
                              style: SafeGoogleFont(
                                'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: background,
                              ),
                            ),
                          ),
                          Texth3V2(testo: id.toString(), color: black),

                          Padding(
                            padding: getPadding(bottom: 5,top: 20),
                            child: Text(
                              'NOME',
                              style: SafeGoogleFont(
                                'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: background,
                              ),
                            ),
                          ),
                          Texth3V2(testo: name, color: black),

                          Padding(
                            padding: getPadding(bottom: 5,top:20),
                            child: Text(
                              'PREZZO',
                              style: SafeGoogleFont(
                                'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: background,
                              ),
                            ),
                          ),
                          Texth3V2(
                              testo: '€ $price',
                              color: black
                          ),

                        ],
                      ),
                    ),

                  ],
                )

            ),
          )
        ],
      ),
    );
      }
      else return ErrorWidget("exception");
        });
  }
}
