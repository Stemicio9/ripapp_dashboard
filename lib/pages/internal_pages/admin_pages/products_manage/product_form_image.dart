import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/utils/style_utils.dart';
import 'package:ripapp_dashboard/widgets/utilities/network_memory_image_utility.dart';

class ProductFormImage extends StatelessWidget {

  final String imageUrl;
  final Function() onTap;
  final bool isNetwork;
  final Uint8List? memoryImage;


  const ProductFormImage({Key? key, required this.imageUrl, required this.onTap, required this.isNetwork, this.memoryImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: getPadding(bottom: 5),
          child: Text(
            getCurrentLanguageValue(PHOTO)!.toUpperCase(),
            style: SafeGoogleFont(
              'Montserrat',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: background,
            ),
          ),
        ),
        InkWell(
            onTap: () {
              onTap();
            },
            child: Container(
              height: 130,
              width: 130,
              decoration: BoxDecoration(
                borderRadius:
                const BorderRadius.all(Radius.circular(3)),
                border: Border.all(color: background, width: 1),
                image: DecorationImage(
                  image: NetworkMemoryImageUtility(
                      isNetwork: isNetwork,
                      networkUrl: imageUrl,
                      memoryImage: memoryImage)
                      .provide(),
                  fit: BoxFit.cover,
                ),
              ),
            )),
      ],
    );
  }
}
