import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/validators.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/widgets/input.dart';

Widget composeInput(
    String hint, String label, TextEditingController controller,
    {TextInputFormatter? inputFormatter, bool isPassword = false, Function validator = notEmptyValidate,
      double paddingRight = 0, double paddingLeft = 0, double labelPaddingLeft = 0}) {
  return Expanded(
    flex: 1,
    child: Padding(
      padding: getPadding(bottom: 30),
      child: InputsV2Widget(
        hinttext: hint,
        labelText: label.toUpperCase(),
        isVisible: true,
        controller: controller,
        validator: validator,
        paddingRight: paddingRight,
        paddingLeft: paddingLeft,
        isPassword: isPassword,
        inputFormatters: inputFormatter != null ? <TextInputFormatter>[inputFormatter] : <TextInputFormatter>[],
        labelPaddingLeft: labelPaddingLeft,
        borderSide: const BorderSide(color: greyState),
        activeBorderSide: const BorderSide(color: background),
      ),
    ),
  );
}