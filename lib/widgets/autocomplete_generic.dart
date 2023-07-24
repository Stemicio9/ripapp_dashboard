

import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/validators.dart';
import 'package:ripapp_dashboard/widgets/utilities/classes/autocomplete_element.dart';

class GenericAutocomplete<T extends AutocompleteElement> extends StatelessWidget {

  final List<T> options;
  final String? Function(String?) validator;
  final String hintText;
  final Function(T) onSelected;
  final TextEditingController initialValue;

  const GenericAutocomplete({Key? key,
    required this.options,
    this.validator = notEmptyValidate,
    required this.hintText,
    required this.onSelected,
    required this.initialValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildAutocomplete();
  }


  Widget _buildAutocomplete() {
    return RawAutocomplete<T>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text == '') {
            return const Iterable.empty();
          }
          return options.where((T option) {
            return option.getOptionStringValue().toLowerCase().contains(textEditingValue.text.toLowerCase());
          });
        },
        displayStringForOption: (T option) => option.getDisplayString(),
        fieldViewBuilder: (BuildContext context,
            TextEditingController textEditingController,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted) {
          return TextFormField(
            validator: validator,
            controller: textEditingController,
            //initialValue: initialValue.text,
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
                borderSide: BorderSide(color: rossoopaco),
                borderRadius: BorderRadius.circular(3),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: rossoopaco),
                borderRadius: BorderRadius.circular(3),
              ),
              hintText: hintText,
              hoverColor: white,
              errorStyle: const TextStyle(color: Colors.redAccent),
              hintStyle: const TextStyle(color: darkGrey, fontSize: 14),
              filled: true,
              contentPadding: const EdgeInsets.only(left: 20),
              fillColor: white,
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
            focusNode: focusNode,
          );
        },
        optionsViewBuilder: (context, onSelected, options) => Align(
          alignment: Alignment.topLeft,
          child: Material(
            shape: const RoundedRectangleBorder(
              borderRadius:
              BorderRadius.vertical(bottom: Radius.circular(4.0)),
            ),
            child: Container(
              height: 52.0 * options.length,
              width: MediaQuery.of(context).size.width / 3.37,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: options.length,
                shrinkWrap: false,
                itemBuilder: (context, index){
                  return defaultItemViewBuilder(context, index, options, onSelected);
                },
              ),
            ),
          ),
        ));
  }


  Widget defaultItemViewBuilder(BuildContext context, int index, options, onSelected){
    final T t = options.elementAt(index);
    return InkWell(
      onTap: () {
        onSelected(t);
        this.onSelected(t);
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(t.getDisplayString()),
      ),
    );
  }
}
