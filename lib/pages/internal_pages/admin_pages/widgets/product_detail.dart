import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/utils/style_utils.dart';
import 'package:ripapp_dashboard/widgets/dialog_card.dart';

import '../../../../constants/images_constants.dart';
import '../../../../constants/language.dart';
import '../../../../widgets/texts.dart';

class ProductDetail extends StatelessWidget {
  final String cardTitle;
  final String id;
  final String name;
  final String price;
  final String productPhoto;
  final File? imageFile;

  const ProductDetail({
    super.key,
    required this.cardTitle,
    required this.name,
    required this.id,
    required this.price,
    required this.productPhoto,
    this.imageFile
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: getPadding(left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 650,
            child: DialogCard(
              paddingLeft: 10,
              paddingRight: 10,
              cancelIcon: true,
              cardTitle: cardTitle,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex:1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                  )
                                      : null,
                                ),
                                child: imageFile == null ? Image.asset(
                                  ImagesConstants.imgProductPlaceholder,
                                  fit: BoxFit.cover,
                                ) : const SizedBox(),
                              ),

                            ],
                          )
                      ),

                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: getPadding(bottom: 5,top: 20),
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
                            Texth3V2(testo: id, color: black),

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
                            Texth3V2(testo: price, color: black),
                          ],
                        ),

                      ),

                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                          ],
                        ),

                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
