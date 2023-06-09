import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/blocs/searchAgenciesCubit.dart';
import 'package:ripapp_dashboard/blocs/users_list_cubit.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/widgets/agency_detail.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/widgets/agency_form.dart';
import 'package:ripapp_dashboard/pages/internal_pages/header.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/widgets/agencies_table.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/widgets/delete_message_dialog.dart';
import 'package:ripapp_dashboard/repositories/agency_repository.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';

import '../../../models/agency_entity.dart';
import '../../../models/user_entity.dart';

class AgenciesManage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => UsersListCubit(),
        child: AgenciesManageWidget(),
    );
  }

}


class AgenciesManageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AgenciesManageWidgetState();
  }
}

class AgenciesManageWidgetState extends State<AgenciesManageWidget> {
  final String detailMessage = 'Dettagli';
  final String editMessage = 'Modifica';
  final String deleteMessage = 'Elimina';
  final String message = 'Le informazioni riguardanti questa agenzia verranno definitivamente eliminate. Sei sicuro di volerle eliminare?';
  final String city = 'Roma';

  SearchAgencyCubit get _searchAgencyCubit => context.read<SearchAgencyCubit>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: getPadding(top: 60, bottom: 60, left: 5, right: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(
              deleteProfileOnTap: (){},
              onTap: () async {
                showDialog(context: context, builder: (ctx)=> AgencyForm(
                    cardTitle: getCurrentLanguageValue(ADD_AGENCY)!,
                    nameController: nameController,
                    emailController: emailController,
                    phoneController: phoneController,
                    cityController: cityController,
                  onSubmit: () {
                    AgencyEntity agencyEntity = AgencyEntity(
                      agencyName: nameController.text,
                      city: cityController.text,
                      email: emailController.text,
                      phoneNumber: phoneController.text,
                    );
                    _searchAgencyCubit.saveAgency(agencyEntity);
                    print("salvataggio agenzia...");
                    Navigator.pop(context);
                  },
                ));
              },
              pageTitle: getCurrentLanguageValue(AGENCIES_MANAGE)!,
              buttonText: getCurrentLanguageValue(ADD_AGENCY)!,
            ),
            AgenciesTable(
              delete: (dynamic p, dynamic agencies) {
                showDialog(
                    context: context,
                    builder: (ctx) => DeleteMessageDialog(
                        onConfirm: () {
                          for(var e in agencies){
                            if(e.id == p.id){
                              _searchAgencyCubit.remove(e.id!);
                            }
                          }
                          Navigator.pop(context);
                        },
                        onCancel: () {
                          Navigator.pop(context);
                        },
                        message: message
                    ));
              },
              edit: () {
                showDialog(context: context, builder: (ctx)=> AgencyForm(
                    onSubmit: (){
                      print("aggiornamento operatore agenzia...");
                    },
                    cardTitle: getCurrentLanguageValue(EDIT_AGENCY)!,
                    nameController: nameController,
                    emailController: emailController,
                    phoneController: phoneController,
                    cityController: cityController));
              },
              showDetail: (dynamic p) {
                showDialog(
                    context: context,
                    builder: (ctx) => AgencyDetail(
                        cardTitle: getCurrentLanguageValue(AGENCY_DETAIL)!,
                        name: p.agencyName,
                        id: p.id,
                        email: p.email,
                        phoneNumber: p.phoneNumber,
                        city: city
                    ));
              },
              detailMessage: detailMessage,
              editMessage: editMessage,
              deleteMessage: deleteMessage,
            )
          ],
        ),
      ),
    );
  }
}


Future saveAgency(AgencyEntity agencyEntity) async {
  var response = await AgencyRepository().saveAgency(agencyEntity);
  print(response);
}
