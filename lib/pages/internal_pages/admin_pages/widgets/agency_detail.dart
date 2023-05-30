import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/utils/style_utils.dart';
import 'package:ripapp_dashboard/widgets/dialog_card.dart';

import '../../../../widgets/texts.dart';

class AgencyDetail extends StatelessWidget {
  final String cardTitle;
  final String id;
  final String name;
  final String phoneNumber;
  final String email;
  final String city;

  const AgencyDetail({
    super.key,
    required this.cardTitle,
    required this.name,
    required this.id,
    required this.email,
    required this.phoneNumber,
    required this.city,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: getPadding(left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 700,
            child: DialogCard(
                paddingLeft: 10,
                paddingRight: 10,
                cancelIcon: true,
                cardTitle: cardTitle,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                              'EMAIL',
                              style: SafeGoogleFont(
                                'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: background,
                              ),
                            ),
                          ),
                          Texth3V2(testo: email, color: black),
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
                          Texth3V2(testo: city, color: black),
                        ],
                      ),
                    ),


                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
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
                            Texth3V2(testo: name, color: black),

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
                          ],
                        ),
                      ),
                    )
                  ],
                )
               ),
          )
        ],
      ),
    );
  }
}
