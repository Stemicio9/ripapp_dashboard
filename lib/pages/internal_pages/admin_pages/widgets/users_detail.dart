import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/blocs/selected_user_cubit.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/utils/style_utils.dart';
import 'package:ripapp_dashboard/widgets/dialog_card.dart';
import '../../../../blocs/selected_city_cubit.dart';
import '../../../../widgets/texts.dart';

class UsersDetail extends StatelessWidget {
  final String cardTitle;
  late int id;
  late String name;
  late String lastName;
  late String phoneNumber;
  late String email;
  late String city;
  late String role;
  late String agencyName;
  final bool? isAgency;

   UsersDetail({
    super.key,
    required this.cardTitle,
     this.name = "",
     this.id = 0,
     this.email = "",
     this.phoneNumber ="",
     this.city ="",
     this.lastName="",
     this.role = "",
     this.agencyName = "",
    this.isAgency = false
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedUserCubit, SelectedUserState>(
        builder: (context, state) {
      if (state is SelectedUserState) {
        id = state.selectedUser.id ?? 0;
        name = state.selectedUser.firstName ?? "";
        lastName = state.selectedUser.lastName ?? "";
        email = state.selectedUser.email ?? "";
        phoneNumber = state.selectedUser.phoneNumber ?? "";
        if (state.selectedUser.agency != null ) {
          agencyName =  state.selectedUser.agency!.agencyName ?? "";
        }
        role = state.selectedUser.status.toString() == 'UserStatus.active' ? 'Utente' :
        state.selectedUser.status.toString() == 'UserStatus.agency' ? 'Agenzia' :
        'Amministratore';
        //TODO IMPLEMENTARE CITTA
      //  city = state.selectedUser.city ?? "";

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
      else return ErrorWidget("exception");

        });

  }
}



