import 'dart:js_interop';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/blocs/selected_user_cubit.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/constants/validators.dart';
import 'package:ripapp_dashboard/models/CityEntity.dart';
import 'package:ripapp_dashboard/models/UserStatusEnum.dart';
import 'package:ripapp_dashboard/models/agency_entity.dart';
import 'package:ripapp_dashboard/models/user_entity.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/widgets/users_detail.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/widgets/users_form.dart';
import 'package:ripapp_dashboard/pages/internal_pages/header.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/widgets/delete_message_dialog.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/widgets/users_table.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/widgets/scaffold.dart';
import 'package:ripapp_dashboard/widgets/snackbars.dart';
import '../../../blocs/users_list_cubit.dart';


enum UserRoles { Amministratore, Agenzia, Utente }

class UsersManage extends StatelessWidget{

  final String detailMessage = 'Dettagli';
  final String editMessage = 'Modifica';
  final String deleteMessage = 'Elimina';
  final String message = 'Le informazioni riguardanti questo utente verranno definitivamente eliminate. Sei sicuro di volerle eliminare?';



  @override
  Widget build(BuildContext context) {
    return UsersManageWidget();
  }

}

class UsersManageWidget extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return UsersManageWidgetState();
  }
}

class UsersManageWidgetState extends State<UsersManageWidget> {

  SelectedUserCubit get _selectedUserCubit => context.read<SelectedUserCubit>();
  UsersListCubit get _userListCubit => context.read<UsersListCubit>();
  List<String> cityOptions = <String>[
    'Milano'
  ];
  final String detailMessage = 'Dettagli';
  final String editMessage = 'Modifica';
  final String deleteMessage = 'Elimina';
  final String message = 'Le informazioni riguardanti questo utente verranno definitivamente eliminate. Sei sicuro di volerle eliminare?';
  final _formKey = GlobalKey<FormState>();
  final _editKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController filterController = TextEditingController();

  UserEntity userEntity = new UserEntity(
    id:1,
    firstName: 'Davide',
    lastName: 'Rossi',
    email: 'daviderossi@gmail.com',
    city: [CityEntity.defaultCity()],
    phoneNumber: '+39 0987654321',
    role: 'Amministratore'
  );

  setStatusFromDropdown(String userRole) {
    UserRoles role = UserRoles.values.firstWhere((e) => e.toString() == 'UserRoles.' + userRole);
    userEntity.role = role.toString();
    switch(role) {
      case UserRoles.Amministratore: {userEntity.status = UserStatus.admin;}
      break;

      case UserRoles.Agenzia: {userEntity.status = UserStatus.agency;}
      break;

      case UserRoles.Utente: {userEntity.status = UserStatus.active;}
      break;

      default: {}
      break;
    }
  }

  setAgencyFromDropdown(AgencyEntity agencyEntity){
    userEntity.agency = agencyEntity;
  }

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
              onTap: () {
                showDialog(
                    context: context,
                    builder: (ctx) =>
                        Form(
                          key:_formKey,
                          child: UsersForm(
                            cardTitle: getCurrentLanguageValue(ADD_USER)!,
                            nameController: nameController,
                            emailController: emailController,
                            phoneController: phoneController,
                            filterController: filterController,
                            options: cityOptions,
                            lastNameController: lastNameController,
                            passwordController: passwordController,
                            nameValidator: notEmptyValidate,
                            lastNameValidator: notEmptyValidate,
                            passwordValidator: validatePassword,
                            emailValidator: validateEmail,
                            phoneValidator: notEmptyValidate,
                            statusChange: setStatusFromDropdown,
                            agencyChange: setAgencyFromDropdown,
                            onTap: (){formSubmit();},
                            roles: UserRoles.values,
                          ),
                        ));
              },
              pageTitle: getCurrentLanguageValue(USERS_MANAGE)!,
              buttonText: getCurrentLanguageValue(ADD_USER)!,
            ),

            UsersTable(
              delete: (dynamic p) {
                showDialog(
                    context: context,
                    builder: (ctx) =>
                        DeleteMessageDialog(
                            onConfirm: () {
                              _userListCubit.delete(p.id);
                              SuccessSnackbar(context, text: 'Utente eliminato con successo!');

                              Navigator.pop(context);
                            },
                            onCancel: () {
                              Navigator.pop(context);
                            },
                            message: message
                        )
                );
              },
              edit: (dynamic p) {
                _selectedUserCubit.selectUser(p);
                showDialog(
                    context: context,
                    barrierColor: blackTransparent,
                    builder: (ctx) =>
                        Form(
                          key: _editKey,
                          child: UsersForm(
                             statusChange: setStatusFromDropdown,
                            agencyChange: setAgencyFromDropdown,
                            onTap: () {
                              if(_editKey.currentState!.validate()) {

                                nameController.text = "";
                                lastNameController.text = "";
                                passwordController.text = "";
                                emailController.text = "";
                                phoneController.text = "";
                                SuccessSnackbar(context, text: 'Utente modificato con successo!');
                                Navigator.pop(context);
                              }
                            },
                            isAddPage: false,
                            cardTitle: getCurrentLanguageValue(EDIT_USER)!,
                            nameController: nameController,
                            emailController: emailController,
                            phoneController: phoneController,
                            filterController: filterController,
                            options: cityOptions,
                            lastNameController: lastNameController,
                            passwordController: passwordController,
                            nameValidator: notEmptyValidate,
                            lastNameValidator: notEmptyValidate,
                            phoneValidator: notEmptyValidate,
                            roles: UserRoles.values,
                          ),
                        ));
              },
              showDetail: (dynamic p) {
                _selectedUserCubit.selectUser(p);
                showDialog(
                    context: context,
                    builder: (ctx) =>
                        UsersDetail(
                          isAgency: p.status.toString() == 'UserStatus.agency' ? true : false,
                          cardTitle: getCurrentLanguageValue(USER_DETAIL)!,
                        ));
              },
              detailMessage: detailMessage,
              editMessage: editMessage,
              deleteMessage: deleteMessage,
            ),
            //NumbersPage(),
          ],
        ),
      ),
    );
  }




  formSubmit(){
    if(_formKey.currentState!.validate()) {
      userEntity.firstName = nameController.text;
      userEntity.lastName = lastNameController.text;
      userEntity.email = emailController.text;
      userEntity.phoneNumber = phoneController.text;
      userEntity.password = passwordController.text;
      //  userEntity.city = widget.filterController.text;


        if (userEntity.email != "" && userEntity.password != "") {
          FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: userEntity.email ?? "",
              password: userEntity.password ?? "").then((value) async {
            if (value.user == null) {
              print("Utente nullo");
              return; //TODO: Handle error
            } else {
              userEntity.idtoken = value.user!.uid;
            }


            print("SALVO SU DB LOCALE");
            _userListCubit.signup(userEntity);
            nameController.text = "";
            lastNameController.text = "";
            passwordController.text = "";
            emailController.text = "";
            phoneController.text = "";

            SuccessSnackbar(context, text: 'Utente aggiunto con successo!');
            Navigator.pop(context);
          }, onError: (e){
                print(e);
                ErrorSnackbar(context, text: 'L\'email inserita è già usata da un altro utente!');
          });
        }

      }
    }

}