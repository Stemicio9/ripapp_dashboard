import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/constants/validators.dart';
import 'package:ripapp_dashboard/widgets/input.dart';

class ProductFormInputs extends StatelessWidget {

  final TextEditingController nameController;
  final TextEditingController priceController;

  const ProductFormInputs({super.key, required this.nameController, required this.priceController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InputsV2Widget(
          labelText: getCurrentLanguageValue(NAME)!.toUpperCase(),
          hinttext: getCurrentLanguageValue(NAME) ?? "",
          isVisible: true,
          controller: nameController,
          validator: notEmptyValidate,
          paddingLeft: 0,
          paddingRight: 0,
          borderSide: const BorderSide(color: greyState),
          activeBorderSide: const BorderSide(color: background),
        ),
        InputsV2Widget(
          hinttext: getCurrentLanguageValue(PRICE) ?? "",
          labelText: getCurrentLanguageValue(PRICE)!.toUpperCase() ,
          controller: priceController,
          labelPaddingTop: 20,
          isVisible: true,
          validator: notEmptyValidate,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
          ],
          paddingRight: 0,
          paddingLeft: 0,
          borderSide: const BorderSide(color: greyState),
          activeBorderSide: const BorderSide(color: background),
        ),
      ],
    );
  }
}
