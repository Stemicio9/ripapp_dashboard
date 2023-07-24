import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/models/CityEntity.dart';
import 'package:ripapp_dashboard/models/city_from_API.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/add_demise/chip_text/chip_text.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/add_demise/chips_row.dart';
import 'package:ripapp_dashboard/widgets/utilities/network_memory_image_utility.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/images_constants.dart';
import '../../../../constants/language.dart';
import '../../../../utils/size_utils.dart';
import '../../../../utils/style_utils.dart';
import '../../../../widgets/texts.dart';

class DeceasedDetail extends StatelessWidget{

  var imageFile;
  var memoryImage;
  final bool isNetwork;
  final String lastName;
  final String firstName;
  final String id;
  final String phoneNumber;
  final String city;
  final List<CityFromAPI> citiesOfInterest;
  final String deceasedDate;
  final File? obituary;
  final String age;
  final String obituaryName;
  final downloadObituary;

  DeceasedDetail({
    this.memoryImage,
    this.isNetwork = true,
    this.imageFile,
    required this.id,
    required this.age,
    required this.lastName,
    required this.firstName,
    required this.phoneNumber,
    required this.city,
    required this.citiesOfInterest,
    required this.deceasedDate,
    this.obituary,
    required this.obituaryName,
    required this.downloadObituary,
  });

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
                testo: "Dati defunto",
                color: background,
                weight: FontWeight.w700,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        padding: getPadding(right: 20),
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
                  flex: 2,
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
                  flex: 2,
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
                        padding: getPadding(top: 20),
                        child: Text(
                          'COMUNI DI INTERESSE',
                          style: SafeGoogleFont(
                            'Montserrat',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: background,
                          ),
                        ),
                      ),

                      ChipsRow(chips: citiesOfInterest)

                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
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
                                child: const Icon(Icons.download_rounded, color: background
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
}