import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/kinships.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/add_demise/RelativeRow.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/utils/style_utils.dart';
import 'package:ripapp_dashboard/widgets/input.dart';

class RelativeRowWidget extends StatelessWidget {

  final RelativeRowNew relative;
  final Function(int index, Kinship kinship) kinshipChange;
  final Function(int index, String value) valueChange;
  final Function(int index) deleteRow;

  final TextEditingController phoneController = TextEditingController();

  RelativeRowWidget({Key? key,
    required this.relative,
    required this.kinshipChange,
    required this.valueChange,
    required this.deleteRow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    phoneController.text = relative.value;
    phoneController.selection = TextSelection.fromPosition(TextPosition(offset: phoneController.text.length));
    return SizedBox(
      height: 100,
      child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: getPadding(bottom: 5),
                  child: Text(
                    'IL PARENTE È:',
                    style: SafeGoogleFont(
                      'Montserrat',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: background,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(color: greyState)),
                      child: DropdownButton<Kinship>(
                        hint: const Text(
                          "Seleziona parentela",
                          style: TextStyle(
                            color: black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        isExpanded: true,
                        underline: const SizedBox(),
                        value: relative.kinship,
                        onChanged: (Kinship? value) {
                          kinshipChange(relative.currentIndex, value ?? Kinship.mother);
                        },
                        items: Kinship.values.map<DropdownMenuItem<Kinship>>(
                                (Kinship kinship) {
                              return DropdownMenuItem<Kinship>(
                                value: kinship,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    kinship.name,
                                    style: const TextStyle(
                                      color: black,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                      )),
                )
              ],
            )),
        Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: getPadding(bottom: 5),
                  child: Text(
                    'NUMERO PARENTE',
                    style: SafeGoogleFont(
                      'Montserrat',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: background,
                    ),
                  ),
                ),

                //widget.relativeController.text();
                InputsV2Widget(
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  hinttext:
                  getCurrentLanguageValue(RELATIVE_NUMBER) ?? "",
                  controller: phoneController,
                  paddingLeft: 0,
                  paddingRight: 0,
                  borderSide: const BorderSide(color: greyState),
                  activeBorderSide: const BorderSide(color: background),
                  onChanged: (String? value) {
                    valueChange(relative.currentIndex, value ?? "");
                  },
                ),
              ],
            )),
        Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5, bottom: 10),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                        onTap: () {
                          deleteRow(relative.currentIndex);
                        },
                        child: Icon(
                          Icons.delete_rounded,
                          color: rossoopaco,
                          size: 40,
                        )),
                  ),
                ),
              ],
            ))
      ],
    )
    );
  }
}
