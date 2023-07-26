import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/widgets/detail_label.dart';
import '../../../../constants/colors.dart';
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
                DetailLabel(
                    flex: 1,
                    labelText: getCurrentLanguageValue(WAKE_DATE)!.toUpperCase(),
                    text: wakeDate
                ),
                DetailLabel(
                    flex: 1,
                    labelText: getCurrentLanguageValue(WAKE_HOUR)!.toUpperCase(),
                    text: wakeHour
                ),
                DetailLabel(
                    flex: 1,
                    labelText: getCurrentLanguageValue(WAKE_ADDRESS)!.toUpperCase(),
                    text: wakeAddress
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  DetailLabel(
                      flex: 1,
                      labelText: getCurrentLanguageValue(WAKE_NOTE)!.toUpperCase(),
                      text: wakeNote
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
