import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/utils/style_utils.dart';
import 'package:ripapp_dashboard/widgets/dialog_card.dart';

import '../../../../widgets/texts.dart';

class UsersDetail extends StatelessWidget {
  final String cardTitle;
  final int id;
  final String name;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String city;
  final String role;
  final String agencyName;
  final bool? isAgency;

  const UsersDetail({
    super.key,
    required this.cardTitle,
    required this.name,
    required this.id,
    required this.email,
    required this.phoneNumber,
    required this.city,
    required this.lastName,
    required this.role,
    required this.agencyName,
    this.isAgency = false
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
                              Texth3V2(testo: id.toString(), color: black),

                              Padding(
                                padding: getPadding(bottom: 5,top: 20),
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
                                  'RUOLO',
                                  style: SafeGoogleFont(
                                    'Montserrat',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: background,
                                  ),
                                ),
                              ),
                              Texth3V2(testo: role, color: black),
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


                                Visibility(
                                  visible: isAgency!,
                                  child: Padding(
                                    padding: getPadding(bottom: 5,top: 20),
                                    child: Text(
                                      'NOME AGENZIA',
                                      style: SafeGoogleFont(
                                        'Montserrat',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: background,
                                      ),
                                    ),
                                  ),
                                ),
                                Texth3V2(testo: agencyName, color: black),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
          )

        ],
      ),
    );
  }
}
