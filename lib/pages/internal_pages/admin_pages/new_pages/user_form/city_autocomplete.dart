
import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/models/city_from_API.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/add_demise/chips_row.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/widgets/autocomplete_generic.dart';

class CityAutocomplete extends StatelessWidget {

  final List<CityFromAPI> options;
  final Function(CityFromAPI) onSelected;
  final TextEditingController initialValue;
  final List<CityFromAPI> chips;
  final Function onDeleted;

  const CityAutocomplete({Key? key,
    required this.options,
    required this.onSelected,
    required this.initialValue,
    required this.chips,
    required this.onDeleted
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GenericAutocomplete<CityFromAPI>(
          options: options,
          hintText: "Comuni di interesse" ,
          onSelected: onSelected,
            validator: (String){
              return null;
            },
            initialValue: initialValue
        ),
        Padding(
          padding: getPadding(bottom: 30),
          child: ChipsRow(chips: chips, onDeleted: onDeleted),
        ),
      ],
    );
  }
}
