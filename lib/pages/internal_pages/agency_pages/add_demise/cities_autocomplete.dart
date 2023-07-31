import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/models/city_from_API.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/add_demise/chips_row.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/utils/style_utils.dart';
import 'package:ripapp_dashboard/widgets/autocomplete_generic.dart';

class CitiesAutocomplete extends StatelessWidget {

  final List<CityFromAPI> chips;
  final List<CityFromAPI> cityList;
  final Function(CityFromAPI) onSelected;
  final Function onDeleted;

  const CitiesAutocomplete({
    Key? key, required this.chips,
    required this.cityList, required this.onSelected,
    required this.onDeleted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: getPadding(bottom: 5),
          child: Text(
            'COMUNI DI INTERESSE',
            style: SafeGoogleFont(
              'Montserrat',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: background,
            ),
          ),
        ),

        GenericAutocomplete<CityFromAPI>(
            options: cityList,
            hintText:  "Comuni di interesse",
            onSelected: onSelected,
            validator: (String){
              return null;
            },
        ),

        ChipsRow(chips: chips, onDeleted: onDeleted),

      ],

    );
  }
}


