import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/language.dart';
import '../../../../utils/size_utils.dart';
import '../../../../utils/style_utils.dart';
import '../../../../widgets/input.dart';

class RelativeRow extends StatelessWidget {

  final onChanged;
  final List<String> kinship;
  final String value;
  final deleteRelative;
  final TextEditingController relativeController;
  final dynamic relativeValidator;
  final bool isDetail;


  const RelativeRow({
    Key? key,
    required this.onChanged,
    required this. kinship,
    this.relativeValidator,
    required this.relativeController,
    required this.deleteRelative,
    this.isDetail = false,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                          onChanged: (element){
                            print("element");
                            print(element);
                            onChanged(this, element);
                            },
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
                    ),

                ],
              )),

          Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5,bottom: 10),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                          onTap: (){deleteRelative(this);},
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
    );
  }
}
