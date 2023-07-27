
import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/models/city_from_API.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/add_demise/chips_row.dart';
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
      children: [
        GenericAutocomplete<CityFromAPI>(
          options: options,
          hintText: getCurrentLanguageValue(CITY) ?? "",
          onSelected: onSelected,
          initialValue: initialValue
        ),
        ChipsRow(chips: chips, onDeleted: onDeleted),
      ],
    );
  }
}
