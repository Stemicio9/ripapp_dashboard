import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/widgets/detail_label.dart';
import '../../../../constants/colors.dart';
import '../../../../widgets/texts.dart';

class FuneralDetail extends StatelessWidget {

  final String funeralDate;
  final String funeralNote;
  final String funeralHour;
  final String funeralAddress;

  const FuneralDetail({
    required this.funeralDate,
    required this.funeralNote,
    required this.funeralHour,
    required this.funeralAddress,
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
                testo: "Dati funerale",
                color: background,
                weight: FontWeight.w700,
              ),
            ),
            Row(
                children: [
                  DetailLabel(
                      flex: 1,
                      labelText: getCurrentLanguageValue(FUNERAL_DATE)!.toUpperCase(),
                      text: funeralDate
                  ),

                  DetailLabel(
                      flex: 1,
                      labelText: getCurrentLanguageValue(FUNERAL_HOUR)!.toUpperCase(),
                      text: funeralHour
                  ),

                  DetailLabel(
                      flex: 1,
                      labelText: getCurrentLanguageValue(FUNERAL_ADDRESS)!.toUpperCase(),
                      text: funeralAddress
                  ),
                ],
              ),

            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  DetailLabel(
                      flex: 1,
                      labelText: getCurrentLanguageValue(FUNERAL_NOTE)!.toUpperCase(),
                      text: funeralNote
                  ),
                  Expanded(
                      flex: 2,
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
