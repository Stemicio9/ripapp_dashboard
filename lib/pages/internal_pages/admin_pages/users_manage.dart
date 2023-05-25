import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/models/CityEntity.dart';
import 'package:ripapp_dashboard/models/UserStatusEnum.dart';
import 'package:ripapp_dashboard/models/user_entity.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/widgets/users_detail.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/widgets/users_form.dart';
import 'package:ripapp_dashboard/pages/internal_pages/header.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/widgets/delete_message_dialog.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/widgets/users_table.dart';
import 'package:ripapp_dashboard/repositories/user_repository.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';


class UsersManage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UsersManageState();
  }
}

class UsersManageState extends State<UsersManage> {

  final String detailMessage = 'Dettagli';
  final String editMessage = 'Modifica';
  final String deleteMessage = 'Elimina';
  final String message = 'Le informazioni riguardanti questo utente verranno definitivamente eliminate. Sei sicuro di volerle eliminare?';
  final String name = 'Davide';
  final String lastName = 'Rossi';
  final String id = '1';
  final String phoneNumber = '+39 0987654321';
  final String city = 'Roma';
  final String email = 'daviderossi@gmail.com';



  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    nameController.text="nome";
    lastNameController.text="cognome";
    emailController.text="email@mail.it";
    phoneController.text="3232";
    cityController.text="citta";
    return Padding(
      padding: getPadding(top: 60, bottom: 60, left: 5, right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(
            onTap: (){
              showDialog(
                  context: context,
                  builder: (ctx) => UsersForm(
                      onTap: () {
                        UserEntity userEntity = UserEntity();
                        userEntity.firstName = nameController.text;
                        userEntity.email = emailController.text;
                        userEntity.phoneNumber = phoneController.text;
                        // TODO change here the cityId (understand how)
                        userEntity.city = [CityEntity(cityid: "4", name: cityController.text)];
                        userEntity.lastName = lastNameController.text;
                        userEntity.password = /*passwordController.text*/ "passwordDifficile";
                        userEntity.status = /*dropdown.status*/ UserStatus.active;
                        if (userEntity.email != "" && userEntity.password != "") {
                          FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: userEntity.email ?? "",
                              password: userEntity.password ?? "").then((
                              value) async {
                            if (value.user == null) {
                              return; //TODO: Handle error
                            }
                            var response = await UserRepository().signup(userEntity);
                          });
                        }
                        Navigator.pop(context);
                      },
                      cardTitle: getCurrentLanguageValue(ADD_USER)!,
                      nameController: nameController,
                      emailController: emailController,
                      phoneController: phoneController,
                      cityController: cityController,
                      lastNameController: lastNameController
                  )

              );
            },
            pageTitle: getCurrentLanguageValue(USERS_MANAGE)!,
            buttonText: getCurrentLanguageValue(ADD_USER)!,
            ),

          UsersTable(
            delete: (){
              showDialog(
                  context: context,
                  builder: (ctx) => DeleteMessageDialog(
                      onConfirm: (){
                        Navigator.pop(context);
                      },
                      onCancel: (){
                        Navigator.pop(context);
                      },
                      message: message
                  )
              );
            },
            edit: (){
              showDialog(
                  context: context,
                  barrierColor: blackTransparent,
                  builder: (ctx) => UsersForm(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      cardTitle: getCurrentLanguageValue(EDIT_USER)!,
                      nameController: nameController,
                      emailController: emailController,
                      phoneController: phoneController,
                      cityController: cityController,
                      lastNameController: lastNameController
                  )

              );
            },
            showDetail: (){
              showDialog(
                  context: context,
                  builder: (ctx) =>UsersDetail(
                      cardTitle: getCurrentLanguageValue(USER_DETAIL)!,
                      name: name,
                      id: id,
                      email: email,
                      phoneNumber: phoneNumber,
                      city: city,
                      lastName: lastName
                  )
              );
            },
            detailMessage: detailMessage,
            editMessage: editMessage,
            deleteMessage: deleteMessage,
          )

        ],
      ),
    );
  }
}
