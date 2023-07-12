import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/blocs/selected_demise_cubit.dart';

import '../../../../constants/colors.dart';
import '../../../../utils/size_utils.dart';
import '../../../../utils/style_utils.dart';
import '../../../../widgets/texts.dart';

class FuneralDetail extends StatelessWidget {

  late String funeralDate;
  late String funeralNote;
  late String funeralHour;
  late String funeralAddress;



   FuneralDetail({
    this.funeralDate = "",
    this.funeralNote = "",
    this.funeralHour = "",
    this.funeralAddress = "",
    Key? key,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedDemiseCubit, SelectedDemiseState>(
        builder: (context, stateDemise) {
          if (stateDemise is SelectedDemiseState) {
            funeralDate = stateDemise.selectedDemise.funeralDateTime.toString();
            funeralNote = stateDemise.selectedDemise.funeralNotes.toString();
            funeralAddress = stateDemise.selectedDemise.funeralAddress.toString();
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
                  Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: getPadding(bottom: 5),
                            child: Text(
                              'DATA FUNERALE',
                              style: SafeGoogleFont(
                                'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: background,
                              ),
                            ),
                          ),
                          Texth3V2(testo: funeralDate, color: black),

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
                              'ORARIO FUNERALE',
                              style: SafeGoogleFont(
                                'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: background,
                              ),
                            ),
                          ),
                          Texth3V2(testo: funeralHour, color: black),

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
                          Texth3V2(testo: funeralAddress, color: black),


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
                              'NOTE FUNERALE',
                              style: SafeGoogleFont(
                                'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: background,
                              ),
                            ),
                          ),
                          Texth3V2(testo: funeralNote, color: black),

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
  else return ErrorWidget("exception");

});
  }
}
