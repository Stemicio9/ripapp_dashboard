import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/pages/internal_pages/header.dart';
import 'package:ripapp_dashboard/pages/internal_pages/widgets/delete_message_dialog.dart';
import 'package:ripapp_dashboard/pages/internal_pages/widgets/products_table.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';

class ProductsManage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProductsManageState();
  }
}


class ProductsManageState extends State<ProductsManage>{
  final String detailMessage = 'Dettagli';
  final String editMessage = 'Modifica';
  final String deleteMessage = 'Elimina';
  final String message = 'Le informazioni riguardanti questo prodotto verranno definitivamente eliminate. Sei sicuro di volerle eliminare?';


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getPadding(top: 60, bottom: 60, left: 5, right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(
            onTap: (){},
            pageTitle: getCurrentLanguageValue(PRODUCTS_MANAGE)!,
            buttonText: getCurrentLanguageValue(ADD_PRODUCT)!,
          ),

          ProductsTable(
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