import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/validators.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/widgets/custom_image_view.dart';

class InputsV2Widget extends StatelessWidget {
  final double round = 30.0;
  final String hintText;
  TextEditingController controller;
  final dynamic validator;
  var onChanged;
  bool isPassword = false;
  bool autofocus;
  TextInputType keyboard;
  bool? enabled = true;
  final textInputAction;
  final prefixIcon;
  final bool isPrefixIcon;
  final double prefixIconWidth;
  final double prefixIconHeight;
  final suffixIcon;
  final String svgPath;
  final double suffixIconWidth;
  final double suffixIconHeight;
  final bool isSuffixIcon;
  final bool readOnly;
  final onTap;
  final iconOnTap;
  final BorderSide borderSide;
  final BorderSide activeBorderSide;

  final bool multiline;
  final int maxLine;
  final double fontSize; //14
  final double fontHintSize; //14
  final TextAlign? textAlign;
  final dynamic focusNode;
  final double contentPaddingLeft; //20
  final double contentPaddingRight; //0
  final double contentPaddingTop; //0
  final double elevation; //0
  final double borderRadius; //3
  final double paddingLeft; //40
  final double paddingRight; //40
  final double paddingTop; //10
  final double paddingBottom; //10
  final inputFormatters;

  InputsV2Widget(
      {required hinttext,
      required this.controller,
      this.isPassword = false,
      this.borderRadius = 3,
      this.elevation = 0,
      this.textAlign = TextAlign.start,
      this.contentPaddingLeft = 20,
      this.contentPaddingTop = 0,
      this.contentPaddingRight = 0,
      this.validator = defaultValidator,
      this.onChanged = funzioneCostante,
      this.autofocus = false,
      this.keyboard = TextInputType.text,
      this.enabled,
      this.textInputAction = TextInputAction.next,
      this.prefixIcon,
      this.multiline = false,
      this.maxLine = 4,
      this.fontSize = 14,
      this.fontHintSize = 14,
      this.paddingRight = 20,
      this.paddingTop = 0,
      this.paddingLeft = 20,
      this.paddingBottom = 0,
      this.focusNode,
      this.onTap,
      this.readOnly = false,
      this.isPrefixIcon = false,
      this.prefixIconHeight = 25,
      this.prefixIconWidth = 25,
      this.isSuffixIcon = false,
      this.suffixIconHeight = 25,
      this.suffixIconWidth = 25,
      this.suffixIcon,
      this.svgPath = '',
      this.iconOnTap,
      this.inputFormatters,
      this.borderSide = BorderSide.none,
      this.activeBorderSide = BorderSide.none})
      : hintText = hinttext;

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Padding(
        padding: EdgeInsets.only(
            left: paddingLeft,
            right: paddingRight,
            top: paddingTop,
            bottom: paddingBottom),
        child: TextFormField(
          readOnly: readOnly,
          onTap: onTap,
          focusNode: focusNode,
          textAlign: textAlign!,
          validator: validator,
          style: TextStyle(
            fontSize: fontSize,
          ),
          obscureText: isPassword,
          textInputAction: textInputAction,
          onChanged: onChanged,
          controller: controller,
          inputFormatters: inputFormatters,
          keyboardType: multiline ? TextInputType.multiline : keyboard,
          maxLines: multiline ? maxLine : 1,
          onEditingComplete: () => node.nextFocus(),
          enabled: enabled,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: borderSide,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: activeBorderSide,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: borderSide,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: activeBorderSide,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            hintText: hintText,
            hoverColor: white,
            hintStyle: TextStyle(color: darkGrey, fontSize: fontHintSize),
            filled: true,
            errorStyle: const TextStyle(color: redAccent),
            prefixIcon: isPrefixIcon
                ? Align(
                    widthFactor: 1.0,
                    heightFactor: 1.0,
                    child: CustomImageView(
                      imagePath: prefixIcon,
                      svgPath: svgPath,
                      height: getSize(
                        prefixIconHeight,
                      ),
                      width: getSize(
                        prefixIconWidth,
                      ),
                    ),
                  )
                : null,
            suffixIcon: isSuffixIcon
                ? Align(
                    widthFactor: 1.0,
                    heightFactor: 1.0,
                    child: CustomImageView(
                      imagePath: suffixIcon,
                      height: getSize(
                        suffixIconHeight,
                      ),
                      width: getSize(
                        suffixIconWidth,
                      ),
                      svgPath: svgPath,
                      onTap: iconOnTap,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(
                left: contentPaddingLeft,
                right: contentPaddingRight,
                top: multiline ? 40 : contentPaddingTop),
            fillColor: white,
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
        ));
  }
}

void funzioneCostante(String into) {}
