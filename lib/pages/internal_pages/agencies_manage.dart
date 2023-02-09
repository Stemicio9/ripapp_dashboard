import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/pages/internal_pages/header.dart';
import 'package:ripapp_dashboard/pages/internal_pages/widgets/agencies_table.dart';
import 'package:ripapp_dashboard/pages/internal_pages/widgets/delete_message_dialog.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';

class AgenciesManage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AgenciesManageState();
  }
}


class AgenciesManageState extends State<AgenciesManage>{
  final String detailMessage = 'Dettagli';
  final String editMessage = 'Modifica';
  final String deleteMessage = 'Elimina';
  final String message = 'Le informazioni riguardanti questa agenzia verranno definitivamente eliminate. Sei sicuro di volerle eliminare?';


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getPadding(top: 60, bottom: 60, left: 5, right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(
            onTap: (){},
            pageTitle: getCurrentLanguageValue(AGENCIES_MANAGE)!,
            buttonText: getCurrentLanguageValue(ADD_AGENCY)!,
          ),

          AgenciesTable(
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