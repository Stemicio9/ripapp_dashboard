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
  final List<Widget> relativeRows;


  AddRelative({
    super.key,
    required this.relativeRows,
    required this.addRelative,
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
              height: 200,
              child: ListView.builder(
                itemCount: relativeRows.length,
                itemBuilder: (context, index) {
                  return relativeRows[index];
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}