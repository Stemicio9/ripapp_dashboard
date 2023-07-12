import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/blocs/selected_demise_cubit.dart';
import 'package:ripapp_dashboard/widgets/utilities/network_memory_image_utility.dart';

import '../../../../constants/colors.dart';
import '../../../../utils/size_utils.dart';
import '../../../../utils/style_utils.dart';
import '../../../../widgets/texts.dart';

class DeceasedDetail extends StatelessWidget{

  var imageFile;
  var memoryImage;
  late bool isNetwork;
  late String lastName;
  late String firstName;
  late String id;
  late String phoneNumber;
  late String city;
  late String cityOfInterest;
  late String deceasedDate;
  final File? obituary;
  late String age;
  final String obituaryName;
  final downloadObituary;

  DeceasedDetail({
    this.memoryImage,
    this.isNetwork = true,
    this.imageFile,
    this.id = "",
    this.age= "",
    this.lastName= "",
    this.firstName= "",
    this.phoneNumber= "",
    this.city= "",
    this.cityOfInterest= "",
    this.deceasedDate= "",
    this.obituary,
    required this.obituaryName,
    required this.downloadObituary,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedDemiseCubit, SelectedDemiseState>(
        builder: (context, stateDemise) {
          if (stateDemise is SelectedDemiseState) {
            id = stateDemise.selectedDemise.id.toString();
            firstName = stateDemise.selectedDemise.firstName ?? "";
            lastName = stateDemise.selectedDemise.lastName ?? "";
            phoneNumber = stateDemise.selectedDemise.phoneNumber ?? "";
            age = stateDemise.selectedDemise.age.toString();
            cityOfInterest = stateDemise.selectedDemise.cityEntities.toString();
            deceasedDate = stateDemise.selectedDemise.deceasedDate.toString();
            'Amministratore';
            try {
              city = stateDemise.selectedDemise.city?.name ?? "";
            }catch(e){
              city = "";
            }
            print("LA CITTà DETTAGLI DEL DEFUNTO  è : $city");

            return
      Card(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Texth1V2(
                testo: "Dati defunto",
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
                      Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            color: greyDrag,
                            border: Border.all(color: background, width: 1),
                            image: DecorationImage(
                              image: NetworkMemoryImageUtility(
                                  isNetwork: isNetwork,
                                  networkUrl: imageFile,
                                  memoryImage: memoryImage).provide(),
                              fit: BoxFit.cover,
                            )
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: getPadding(bottom: 5),
                        child: Text(
                          'ID',
                          style: SafeGoogleFont(
                            'Montserrat',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: background,
                          ),
                        ),
                      ),
                      Texth3V2(testo: id, color: black),

                      Padding(
                        padding: getPadding(bottom: 5,top: 20),
                        child: Text(
                          'ETÀ',
                          style: SafeGoogleFont(
                            'Montserrat',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: background,
                          ),
                        ),
                      ),
                      Texth3V2(testo: age, color: black),

                      Padding(
                        padding: getPadding(bottom: 5,top: 20),
                        child: Text(
                          'CITTÀ',
                          style: SafeGoogleFont(
                            'Montserrat',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: background,
                          ),
                        ),
                      ),
                      Texth3V2(testo: city, color: black)
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: getPadding(bottom: 5),
                        child: Text(
                          'NOME',
                          style: SafeGoogleFont(
                            'Montserrat',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: background,
                          ),
                        ),
                      ),
                      Texth3V2(testo: firstName, color: black),

                      Padding(
                        padding: getPadding(bottom: 5,top: 20),
                        child: Text(
                          'TELEFONO',
                          style: SafeGoogleFont(
                            'Montserrat',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: background,
                          ),
                        ),
                      ),
                      Texth3V2(testo: phoneNumber, color: black),


                      Padding(
                        padding: getPadding(bottom: 5,top: 20),
                        child: Text(
                          'COMUNE DI INTERESSE',
                          style: SafeGoogleFont(
                            'Montserrat',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: background,
                          ),
                        ),
                      ),
                      Texth3V2(testo: cityOfInterest, color: black),

                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: getPadding(bottom: 5),
                        child: Text(
                          'COGNOME',
                          style: SafeGoogleFont(
                            'Montserrat',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: background,
                          ),
                        ),
                      ),
                      Texth3V2(testo: lastName, color: black),

                      Padding(
                        padding: getPadding(bottom: 5,top: 20),
                        child: Text(
                          'DATA DEL DECESSO',
                          style: SafeGoogleFont(
                            'Montserrat',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: background,
                          ),
                        ),
                      ),
                      Texth3V2(testo: deceasedDate, color: black),

                      Padding(
                        padding: getPadding(bottom: 5,top: 20),
                        child: Text(
                          'NECROLOGIO',
                          style: SafeGoogleFont(
                            'Montserrat',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: background,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Texth3V2(testo: obituaryName, color: black),
                          ),
                          MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child:GestureDetector(
                                onTap: downloadObituary,
                                child: const Icon(
                                    Icons.download_rounded, color: background
                                ),
                              )
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
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