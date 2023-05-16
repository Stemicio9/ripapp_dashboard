import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../../utils/size_utils.dart';
import '../../../../utils/style_utils.dart';
import '../../../../widgets/texts.dart';

class WakeDetail extends StatelessWidget {

  final String wakeDate;
  final String wakeNote;
  final String wakeHour;
  final String wakeAddress;



  const WakeDetail({
    required this.wakeDate,
    required this.wakeNote,
    required this.wakeHour,
    required this.wakeAddress,
    Key? key,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Texth1V2(
                testo: "Dati veglia",
                color: background,
                weight: FontWeight.w700,
              ),
            ),


          Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: getPadding(bottom: 5),
                            child: Text(
                              'DATA VEGLIA',
                              style: SafeGoogleFont(
                                'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: background,
                              ),
                            ),
                          ),
                          Texth3V2(testo: wakeDate, color: black),

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
                              'ORARIO VEGLIA',
                              style: SafeGoogleFont(
                                'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: background,
                              ),
                            ),
                          ),
                          Texth3V2(testo: wakeHour, color: black),

                        ],
                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: getPadding(bottom: 5),
                            child: Text(
                              'INDIRIZZO',
                              style: SafeGoogleFont(
                                'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: background,
                              ),
                            ),
                          ),
                          Texth3V2(testo: wakeAddress, color: black),


                        ],
                      )
                  ),
                ],
              ),



            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: getPadding(bottom: 5),
                            child: Text(
                              'NOTE VEGLIA',
                              style: SafeGoogleFont(
                                'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: background,
                              ),
                            ),
                          ),
                          Texth3V2(testo: wakeNote, color: black),

                        ],
                      )),
                  Expanded(
                      flex: 1,
                      child: Container()
                  ),
                  Expanded(
                      flex: 1,
                      child: Container()
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
