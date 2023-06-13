import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/language.dart';
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

import '../../../blocs/users_list_cubit.dart';
import 'package:number_paginator/number_paginator.dart';


enum UserRoles { Amministratore, Agenzia, Utente }

class UsersManage extends StatelessWidget{

  final String detailMessage = 'Dettagli';
  final String editMessage = 'Modifica';
  final String deleteMessage = 'Elimina';
  final String message = 'Le informazioni riguardanti questo utente verranno definitivamente eliminate. Sei sicuro di volerle eliminare?';
  final Function(bool isSomeListShowed) changeIsSomeListShowed;

  const UsersManage({
    required this.changeIsSomeListShowed,
  });


  @override
  Widget build(BuildContext context) {

    /*return BlocProvider(
        create: (_) => UsersListCubit(),
        child: UsersManageWidget(changeIsSomeListShowed: this.changeIsSomeListShowed,)
    );*/
    return UsersManageWidget(changeIsSomeListShowed: this.changeIsSomeListShowed,);
  }

}

class UsersManageWidget extends StatefulWidget {

  final String detailMessage = 'Dettagli';
  final String editMessage = 'Modifica';
  final String deleteMessage = 'Elimina';
  final String message = 'Le informazioni riguardanti questo utente verranno definitivamente eliminate. Sei sicuro di volerle eliminare?';

  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController filterController = TextEditingController();
  final Function(bool isSomeListShowed) changeIsSomeListShowed;

  UsersManageWidget({
    required this.changeIsSomeListShowed,
  });

  @override
  State<StatefulWidget> createState() {
    changeIsSomeListShowed(true);
    return UsersManageState();
  }
}

class UsersManageState extends State<UsersManageWidget> {

  UsersListCubit get _userListCubit => context.read<UsersListCubit>();

  List<String> cityOptions = <String>[
    'Milano'
  ];

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
    widget.nameController.text = "nome";
    widget.lastNameController.text = "cognome";
    widget.emailController.text = "email@mail.it";
    widget.phoneController.text = "3232";
    widget.filterController.text = "citta";
    widget.passwordController.text = "123456";
    return Content();

  }

  Widget Content(){
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
                        UsersForm(
                          onTap: (){formSubmit();},
                          cardTitle: getCurrentLanguageValue(ADD_USER)!,
                          nameController: widget.nameController,
                          emailController: widget.emailController,
                          phoneController: widget.phoneController,
                          filterController: widget.filterController,
                          options: cityOptions,
                          lastNameController: widget.lastNameController,
                          passwordController: widget.passwordController,
                          statusChange: setStatusFromDropdown,
                          agencyChange: setAgencyFromDropdown,
                          roles: UserRoles.values.map((e) => e.name).toList(),
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: green,
                                  content: const Text('Utente eliminato con successo!'),
                                  duration: const Duration(milliseconds: 3000),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                              );
                              Navigator.pop(context);
                            },
                            onCancel: () {
                              Navigator.pop(context);
                            },
                            message: widget.message
                        )
                );
              },
              edit: () {
                showDialog(
                    context: context,
                    barrierColor: blackTransparent,
                    builder: (ctx) =>
                        UsersForm(
                          statusChange: setStatusFromDropdown,
                          agencyChange: setAgencyFromDropdown,
                          onTap: () {
                            Navigator.pop(context);
                          },
                          cardTitle: getCurrentLanguageValue(EDIT_USER)!,
                          nameController: widget.nameController,
                          emailController: widget.emailController,
                          phoneController: widget.phoneController,
                          filterController: widget.filterController,
                          options: cityOptions,
                          lastNameController: widget.lastNameController,
                          passwordController: widget.passwordController,
                          roles: UserRoles.values.map((e) => e.name).toList(),
                        ));
              },
              showDetail: (dynamic p) {
                showDialog(
                    context: context,
                    builder: (ctx) =>
                        UsersDetail(
                          isAgency: p.status.toString() == 'UserStatus.agency' ? true : false,
                          agencyName: p.status.toString() == 'UserStatus.agency' ? p.agency.agencyName : '',
                          cardTitle: getCurrentLanguageValue(USER_DETAIL)!,
                          name: p.firstName,
                          id: p.id,
                          email: p.email,
                          phoneNumber: p.phoneNumber,
                          city: userEntity.city!.first.toString(),
                          //TODO check if lists or single city
                          lastName: p.lastName,
                          role: p.status.toString() == 'UserStatus.active' ? 'Utente' :
                          p.status.toString() == 'UserStatus.agency' ? 'Agenzia' :
                          'Amministratore',
                        ));
              },
              detailMessage: widget.detailMessage,
              editMessage: widget.editMessage,
              deleteMessage: widget.deleteMessage,
            ),
            //NumbersPage(),
          ],
        ),
      ),
    );
  }




  formSubmit(){
    userEntity.firstName = widget.nameController.text;
    userEntity.lastName = widget.lastNameController.text;
    userEntity.email = widget.emailController.text;
    userEntity.phoneNumber = widget.phoneController.text;
    userEntity.password = widget.passwordController.text;
    //  userEntity.city = widget.filterController.text;

    if (userEntity.email != "" && userEntity.password != "") {
      FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: userEntity.email ?? "",
          password: userEntity.password ?? "").then((value) async {
        if (value.user == null) {
          print("Utente nullo");
          return; //TODO: Handle error
        }

        print("SALVO SU DB LOCALE");
        _userListCubit.signup(userEntity);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: green,
            content: const Text('Utente aggiunto con successo!'),
            duration: const Duration(milliseconds: 3000),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        );
        Navigator.pop(context);
      });
    }

  }
}