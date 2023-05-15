import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ripapp_dashboard/widgets/action_button.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/language.dart';
import '../../../../utils/size_utils.dart';
import '../../../../utils/style_utils.dart';
import '../../../../widgets/input.dart';
import '../../../../widgets/texts.dart';

class AddRelative extends StatelessWidget{

  final addRelative;
  final deleteRelative;
  final TextEditingController relativeController;
  final dynamic relativeValidator;
  final List<String> kinship;
  final onChanged;
  final String value;

  AddRelative({
    required this.onChanged,
    required this. kinship,
    super.key,
    required this.addRelative,
    this.relativeValidator,
    required this.relativeController,
    required this.deleteRelative,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(top: 30, right: 30,left: 30,bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //page title
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Texth1V2(
                testo: "Dati parenti",
                color: background,
                weight: FontWeight.w700,
              ),
            ),

            //add relative button
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: ActionButtonV2(
                action: addRelative,
                text: 'Aggiungi parente',
                maxHeight: 30,
                fontSize: 14,
                containerHeight: 30,
              ),
            ),

            SizedBox(
              height: 90,
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
                              'IL DEFUNTO È:',
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
                                border: Border.all(color: greyState)
                              ),
                              child: DropdownButton<String>(
                                hint: const Text(
                                  "Seleziona parentela",
                                  style: TextStyle(
                                    color: black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),

                                isExpanded: true,
                                underline:  const SizedBox(),
                                value: value,
                                onChanged: onChanged,
                                items: kinship.map((String kinship) {
                                  return  DropdownMenuItem<String>(
                                    value: kinship,
                                    child:  Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        "$kinship di",
                                        style: const TextStyle(
                                          color: black,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
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
                          InputsV2Widget(
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            hinttext: getCurrentLanguageValue(RELATIVE_NUMBER) ?? "",
                            controller: relativeController,
                            validator: relativeValidator,
                            paddingLeft: 0,
                            paddingRight: 0,
                            borderSide: const BorderSide(color: greyState),
                            activeBorderSide:
                            const BorderSide(color: background),
                          )
                        ],
                      )),
                  Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: deleteRelative,
                                  child: Icon(
                                    Icons.delete_rounded,
                                    color: rossoopaco,
                                    size: 40,
                                  )
                              ),
                            ),
                          ),
                        ],
                      )
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}