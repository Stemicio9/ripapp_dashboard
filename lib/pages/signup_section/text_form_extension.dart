import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/language.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController passwordController;
  final Function onEditingComplete;

  const CustomTextFormField(
      {super.key,
      required this.passwordController,
      required this.onEditingComplete});

  @override
  State<StatefulWidget> createState() {
    return _CustomTextFormFieldState();
  }
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.passwordController,
      keyboardType: TextInputType.visiblePassword,
      obscureText: obscurePassword,
      textInputAction: TextInputAction.done,
      maxLines: 1,
      style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontSize: 18.0),
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: getCurrentLanguageValue(PASSWORD) ?? '',
          hintStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18.0),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                obscurePassword = !obscurePassword;
              });
            },
            child: const Icon(
              Icons.remove_red_eye,
              color: Colors.black,
              size: 25,
            ),
          )),
      onEditingComplete: () => widget.onEditingComplete,
    );
  }
}
