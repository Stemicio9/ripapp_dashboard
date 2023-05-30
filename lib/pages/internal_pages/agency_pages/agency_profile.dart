import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/widgets/delete_message_dialog.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/edit_profile_form.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/profile_data.dart';

import '../../../constants/colors.dart';
import '../../../constants/language.dart';
import '../../../utils/size_utils.dart';
import '../header.dart';

class AgencyProfile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return AgencyProfileState();
  }

}


class AgencyProfileState extends State<AgencyProfile>{

  final String message = 'Sei sicuro di voler eliminare definitivamente questo profilo?';

  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  late Image imageFile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getPadding(top: 60, bottom: 60, left: 5, right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(
            deleteProfileOnTap: (){
              showDialog(
                  context: context,
                  builder: (ctx)=> DeleteMessageDialog(
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
            isVisible: true,
            buttonText: getCurrentLanguageValue(EDIT_PROFILE) ?? "",
            showDeleteProfile: true,
            pageTitle: getCurrentLanguageValue(MY_PROFILE)!,
            onTap: (){
              showDialog(
                  context: context,
                  builder: (ctx) => EditProfileForm(
                      imageOnTap: () async {
                        //TODO: IMPLEMENTARE IMAGEPICKER
                        // Uint8List? bytesFromPicker = await ImagePickerWeb.getImageAsBytes();
                        Image? pickedImage = await ImagePickerWeb.getImageAsWidget();
                        print(pickedImage);
                        setState(() {
                          imageFile = pickedImage!;
                        });
                      },
                      onTap: (){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: green,
                            content: const Text('Profilo modificato con successo!'),
                            duration: const Duration(milliseconds: 3000),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        );
                        Navigator.pop(context);
                      },
                      cardTitle: getCurrentLanguageValue(EDIT_PROFILE) ?? "",
                      nameController: nameController,
                      lastNameController: lastNameController,
                      emailController: emailController,
                      phoneController: phoneController
                  )
              );
            },

          ),

          ProfileData(nameController: nameController, emailController: emailController, lastNameController: lastNameController, phoneNumberController: phoneController,)
        ],
      ),
    );
  }

}