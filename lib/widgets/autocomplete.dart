import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/models/city_from_API.dart';
import '../blocs/selected_city_cubit.dart';
import '../constants/colors.dart';


class AutocompleteWidget extends StatefulWidget {
  final List<CityFromAPI> options;
  final dynamic validator;
  final String hintText;
  final double paddingLeft; //40
  final double paddingRight; //40
  final double paddingTop; //10
  final double paddingBottom; //10
  final FocusNode focusNode = FocusNode();
  final TextEditingController filterController;
  final Function(CityFromAPI city) addCityToInterestCities;

  AutocompleteWidget({
    super.key,
    required this.options,
    this.validator,
    required this.hintText,
    this.paddingLeft = 40,
    this.paddingRight = 40,
    this.paddingTop = 10,
    this.paddingBottom = 10,
    required this.filterController,
    required this.addCityToInterestCities,
  });

  @override
  State<StatefulWidget> createState() {
    return AutocompleteWidgetState();
  }
}

class AutocompleteWidgetState extends State<AutocompleteWidget> {
  String? city;
  SelectedCityCubit get _cityFromAPI => context.read<SelectedCityCubit>();
  String? inputString;

  @override
  Widget build(BuildContext context) {
    return
      BlocBuilder<SelectedCityCubit, SelectedCityState>(
        builder: (context, stateCity) {
      if (stateCity is SelectedCityState) {
        if (stateCity.selectedCity.name != null ) {
          city =  stateCity.selectedCity.name?? "";
        }
        return Padding(
          padding: EdgeInsets.only(
              left: widget.paddingLeft,
              right: widget.paddingRight,
              top: widget.paddingTop,
              bottom: widget.paddingBottom),
          child: Autocomplete<CityFromAPI>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable<CityFromAPI>.empty();
                }
                return widget.options.where((CityFromAPI option) {
                  return option.name!
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase());
                });
              },

              displayStringForOption: (CityFromAPI option) => option.name!,
              fieldViewBuilder: (BuildContext context,
                  TextEditingController textEditingController,
                  FocusNode focusNode,
                  VoidCallback onFieldSubmitted) {
                return TextFormField(
                  validator: widget.validator,
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
                      borderSide: BorderSide(color: rossoopaco),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: rossoopaco),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    hintText: widget.hintText,
                    hoverColor: white,
                    hintStyle: const TextStyle(color: darkGrey, fontSize: 14),
                    filled: true,
                    contentPadding: const EdgeInsets.only(left: 20),
                    fillColor: white,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                  focusNode: focusNode,
                  onFieldSubmitted: (String? value) {
                    _cityFromAPI.selectCity(value as CityFromAPI);
                    onFieldSubmitted();
                    print('You just typed a new entry  $city');
                  },
                );
              },
              optionsViewBuilder: (context, onSelected, options,) => Align(
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
                          itemBuilder: (BuildContext context, int index) {
                            final CityFromAPI option = options.elementAt(index);
                            return InkWell(
                              onTap: () => onSelected(option),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(option.name!),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
              onSelected: widget.addCityToInterestCities,
                  /*(CityFromAPI city) {
                _cityFromAPI.selectCity(city);
                debugPrint('You just selected $city');
              }*/),
        );
      } else {
        return ErrorWidget("exception2");
      }
    });

  }
}
