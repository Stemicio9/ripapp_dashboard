import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/pages/internal_pages/header.dart';
import 'package:ripapp_dashboard/pages/internal_pages/widgets/delete_message_dialog.dart';
import 'package:ripapp_dashboard/pages/internal_pages/widgets/users_table.dart';
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


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getPadding(top: 60, bottom: 60, left: 5, right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(
            onTap: (){},
            pageTitle: getCurrentLanguageValue(USERS_MANAGE)!,
            buttonText: getCurrentLanguageValue(ADD_USER)!,
            ),

          UsersTable(
            delete: (){
              showDialog(
                  context: context,
                  barrierColor: blackTransparent,
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
            edit: (){},
            showDetail: (){},
            detailMessage: detailMessage,
            editMessage: editMessage,
            deleteMessage: deleteMessage,
          )

        ],
      ),
    );
  }
}
