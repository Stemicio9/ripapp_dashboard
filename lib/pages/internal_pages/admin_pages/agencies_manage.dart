import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/blocs/city_list_cubit.dart';
import 'package:ripapp_dashboard/blocs/searchAgenciesCubit.dart';
import 'package:ripapp_dashboard/blocs/selected_city_cubit.dart';
import 'package:ripapp_dashboard/blocs/users_list_cubit.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/constants/validators.dart';
import 'package:ripapp_dashboard/models/city_from_API.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/agencies_manage/agency_detail.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/agencies_manage/agency_form.dart';
import 'package:ripapp_dashboard/pages/internal_pages/header.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/agencies_manage/agencies_table.dart';
import 'package:ripapp_dashboard/widgets/delete_message_dialog.dart';
import 'package:ripapp_dashboard/repositories/agency_repository.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/widgets/snackbars.dart';
import '../../../blocs/selected_agency_cubit.dart';
import '../../../models/agency_entity.dart';

class AgenciesManage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AgenciesManageState();
  }
}

class AgenciesManageState extends State<AgenciesManage> {
  final String detailMessage = 'Dettagli';
  final String editMessage = 'Modifica';
  final String deleteMessage = 'Elimina';
  final String message = 'Le informazioni riguardanti questa agenzia verranno definitivamente eliminate. Verranno eliminati anche tutti gli utenti associati a questa agenzia. Sei sicuro di volerle eliminare?';

  SearchAgencyCubit get _searchAgencyCubit => context.read<SearchAgencyCubit>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _editKey = GlobalKey<FormState>();

  SelectedAgencyCubit get _selectedAgencyCubit => context.read<SelectedAgencyCubit>();
  List<CityFromAPI> cityList = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: getPadding(top: 60, bottom: 60, left: 5, right: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(
              deleteProfileOnTap: () {},
              onTap: () async {
                showDialog(
                    context: context,
                    builder: (ctx) => Form(
                          key: _formKey,
                          child: AgencyForm(
                            emptyFields: (){
                              nameController.text = "";
                              cityController.text = "";
                              emailController.text = "";
                              phoneController.text = "";
                            },
                            cityOptions: cityList,
                            cardTitle: getCurrentLanguageValue(ADD_AGENCY)!,
                            nameController: nameController,
                            emailController: emailController,
                            phoneController: phoneController,
                            cityController: cityController,
                            nameValidator: notEmptyValidate,
                            emailValidator: validateEmail,
                            cityValidator: notEmptyValidate,
                            phoneValidator: notEmptyValidate,
                            onSubmit: () {
                              formSubmit();
                            },
                            isAddPage: true,
                          ),
                        ));
              },
              pageTitle: getCurrentLanguageValue(AGENCIES_MANAGE)!,
              buttonText: getCurrentLanguageValue(ADD_AGENCY)!,
            ),
            AgenciesTable(
              delete: (dynamic p) {
                showDialog(
                    context: context,
                    builder: (ctx) => DeleteMessageDialog(
                        onConfirm: () {
                          _searchAgencyCubit.remove(p.id);
                          SuccessSnackbar(context,
                              text: 'Agenzia eliminata con successo!');

                          Navigator.pop(context);
                        },
                        onCancel: () {
                          Navigator.pop(context);
                        },
                        message: message));
              },
              edit: (dynamic p) {
                _selectedAgencyCubit.selectUser(p);
                showDialog(
                    context: context,
                    builder: (ctx) => Form(
                          key: _editKey,
                          child: AgencyForm(
                            emptyFields: (){
                              nameController.text = "";
                              cityController.text = "";
                              phoneController.text = "";
                            },
                            onSubmit: () {
                              if (_editKey.currentState!.validate()) {
                                AgencyEntity agencyEntity = AgencyEntity(
                                    id: p.id,
                                    agencyName: nameController.text,
                                    city: cityController.text,
                                    phoneNumber: phoneController.text);

                                saveOrEditAgency(agencyEntity, true);

                                Navigator.pop(context);
                              }
                            },
                            isAddPage: false,
                            cityOptions: cityList,
                            cardTitle: getCurrentLanguageValue(EDIT_AGENCY)!,
                            nameController: nameController,
                            emailController: emailController,
                            phoneController: phoneController,
                            cityController: cityController,
                            nameValidator: notEmptyValidate,
                            cityValidator: notEmptyValidate,
                            phoneValidator: notEmptyValidate,
                          ),
                        ));
              },
              showDetail: (dynamic p) {
                _selectedAgencyCubit.selectUser(p);
                showDialog(
                    context: context,
                    builder: (ctx) => AgencyDetail(
                          cardTitle: getCurrentLanguageValue(AGENCY_DETAIL)!,
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

  formSubmit() {
    if (_formKey.currentState!.validate()) {
      AgencyEntity agencyEntity = AgencyEntity(
        agencyName: nameController.text,
        city: cityController.text,
        email: emailController.text,
        phoneNumber: phoneController.text,
      );

      saveOrEditAgency(agencyEntity, false);

      Navigator.pop(context);
    }
  }

  saveOrEditAgency(AgencyEntity agencyEntity, bool isEdit) {
    if (isEdit) {
      AgencyRepository().editAgency(agencyEntity).then((savedAgency) {
        print("agenzia modificata");
        print(agencyEntity);
        clearControllers();
        SuccessSnackbar(context, text: "Agenzia modificata con successo");
      }, onError: (e) {
        ErrorSnackbar(context,
            text: "Errore generico durante la modifica dell\'agenzia");
      });
    } else {
      AgencyRepository().saveAgency(agencyEntity).then((savedAgency) {
        clearControllers();
        SuccessSnackbar(context, text: "Agenzia salvata con successo");
      }, onError: (e) {
        if (e.toString().contains("Duplicate entry")) {
          ErrorSnackbar(context,
              text: 'Questa email è già in uso da un\'altra agenzia');
        }
      });
    }
  }

  clearControllers() {
    nameController.text = "";
    emailController.text = "";
    phoneController.text = "";
    cityController.text = "";
  }
}
