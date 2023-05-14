import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../utils/size_utils.dart';
import 'input.dart';

class AutocompleteWidget extends StatelessWidget{

  final List<String> options;
  final String hintText;
  final double paddingLeft; //40
  final double paddingRight; //40
  final double paddingTop; //10
  final double paddingBottom; //10
  final FocusNode focusNode = FocusNode();
  final TextEditingController filterController;

  AutocompleteWidget({
    required this.options,
    required this.hintText,
    required this.filterController,
    this.paddingBottom = 0,
    this.paddingTop = 0,
    this.paddingLeft = 40,
    this.paddingRight = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            left: paddingLeft,
            right: paddingRight,
            top: paddingTop,
            bottom: paddingBottom),
        child: Autocomplete<String>(

        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text == '') {
            return const Iterable<String>.empty();
          }
          return options.where((String option) {
            return option.contains(textEditingValue.text.toLowerCase());
          });
        },

       fieldViewBuilder: (BuildContext context, TextEditingController textEditingController,
            FocusNode focusNode, VoidCallback onFieldSubmitted) {
          return TextFormField(
            controller: textEditingController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: greyState),
                borderRadius: BorderRadius.circular(3),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: background),
                borderRadius: BorderRadius.circular(3),
              ),
              errorBorder: OutlineInputBorder(
                borderSide:  BorderSide(color: rossoopaco),
                borderRadius: BorderRadius.circular(3),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide:  BorderSide(color: rossoopaco),
                borderRadius: BorderRadius.circular(3),
              ),
              hintText: hintText,
              hoverColor: white,
              hintStyle: const TextStyle(color: darkGrey, fontSize: 14),
              filled: true,
              contentPadding: const EdgeInsets.only(left: 20),
              fillColor: white,
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
            focusNode: focusNode,
            onFieldSubmitted: (String value) {
              onFieldSubmitted();
              print('You just typed a new entry  $value');
            },
          );
        },
          optionsViewBuilder: (context, onSelected, options) => Align(
            alignment: Alignment.topLeft,
            child: Material(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(4.0)),
              ),
              child: Container(
                height: 52.0 * options.length,
                width: MediaQuery.of(context).size.width/3.37,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: options.length,
                  shrinkWrap: false,
                  itemBuilder: (BuildContext context, int index) {
                    final String option = options.elementAt(index);
                    return InkWell(
                      onTap: () => onSelected(option),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(option),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        onSelected: (String selection) {
          debugPrint('You just selected $selection');
        },
      ),
    );
  }

}