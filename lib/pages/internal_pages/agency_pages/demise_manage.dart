import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/demise_detail.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/demise_form.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/demise_table.dart';
import 'package:ripapp_dashboard/pages/internal_pages/header.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/widgets/delete_message_dialog.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';

class DemiseManage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DemiseManageState();
  }
}


class DemiseManageState extends State<DemiseManage>{
  final String detailMessage = 'Dettagli';
  final String editMessage = 'Modifica';
  final String deleteMessage = 'Elimina';
  final String message = 'Le informazioni riguardanti questo decesso verranno definitivamente eliminate. Sei sicuro di volerle eliminare?';

  final String name = 'Davide';
  final String lastName = 'Rossi';
  final String id = '1';
  final String phoneNumber = '+39 0987654321';
  final String city = 'Roma';
  final String churchName = 'Nome Chiesa';
  final String churchAddress = 'Via Milano, 46';
  final String description = 'Descrizione del decesso';



  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController churchNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController churchAddressController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getPadding(top: 60, bottom: 60, left: 5, right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(
            onTap: (){
              showDialog(
                  context: context,
                  builder: (ctx) => DemiseForm(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      cardTitle: getCurrentLanguageValue(ADD_DEMISE)!,
                      nameController: nameController,
                      descriptionController: descriptionController,
                      phoneController: phoneController,
                      cityController: cityController,
                      lastNameController: lastNameController,
                      churchAddressController: churchAddressController,
                      churchNameController: churchNameController
                  )
              );
            },
            pageTitle: getCurrentLanguageValue(DEATHS_INSERT)!,
            buttonText: getCurrentLanguageValue(ADD_DEMISE)!,
          ),

          DemiseTable(
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
                  builder: (ctx) => DemiseForm(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      cardTitle: getCurrentLanguageValue(EDIT_DEMISE)!,
                      nameController: nameController,
                      descriptionController: descriptionController,
                      phoneController: phoneController,
                      cityController: cityController,
                      lastNameController: lastNameController,
                      churchAddressController: churchAddressController,
                      churchNameController: churchNameController
                  )
              );
            },
            showDetail: (){
              showDialog(
                  context: context,
                  builder: (ctx) => DemiseDetail(
                      cardTitle: getCurrentLanguageValue(DEMISE_DETAIL)!,
                      name: name,
                      id: id,
                      description: description,
                      phoneNumber: phoneNumber,
                      city: city,
                      lastName: lastName,
                      churchAddress: churchAddress,
                      churchName: churchName
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