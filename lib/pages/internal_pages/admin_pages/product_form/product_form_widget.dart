import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/product_form/product_form_image.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/product_form/product_form_inputs.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/widgets/action_button.dart';
import 'package:ripapp_dashboard/widgets/utilities/empty_fields_widget.dart';

class ProductFormWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController priceController;

  final bool isAddPopup;
  final Function() save;
  final Function() clearFields;

  final String imageUrl;
  final Function() onTap;
  final bool isNetwork;
  final Uint8List? memoryImage;

  ProductFormWidget(
      {Key? key,
        required this.nameController,
        required this.priceController,
        required this.save,
        required this.clearFields,
        this.isAddPopup = true,
        required this.imageUrl,
        required this.onTap,
        required this.isNetwork,
        this.memoryImage,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: ProductFormImage(
                        imageUrl: imageUrl,
                        onTap: (){
                          onTap();
                          },
                        isNetwork: isNetwork,
                        memoryImage: memoryImage),
                  )),
              Expanded(
                  flex: 2,
                  child: ProductFormInputs(
                    nameController: nameController,
                    priceController: priceController,

                  ))
            ]),

        composeActionRow(),


      ],
    );
  }
  Widget composeActionRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        EmptyFieldsWidget().emptyFields(clearFields),

        Padding(
          padding: getPadding(top: 40),
          child: Align(
            alignment: Alignment.centerRight,
            child: ActionButtonV2(
              action: save,
              text: getCurrentLanguageValue(SAVE)!,
            ),
          ),
        ),

      ],
    );
  }
}
