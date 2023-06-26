import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:ripapp_dashboard/authentication/firebase_authentication_listener.dart';
import 'package:ripapp_dashboard/models/user_entity.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/widgets/delete_message_dialog.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/edit_profile_form.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/profile_data.dart';
import 'package:ripapp_dashboard/repositories/user_repository.dart';
import 'package:ripapp_dashboard/widgets/snackbars.dart';

import '../../../constants/colors.dart';
import '../../../constants/language.dart';
import '../../../constants/validators.dart';
import '../../../utils/size_utils.dart';
import '../header.dart';

class AgencyProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AgencyProfileState();
  }
}

class AgencyProfileState extends State<AgencyProfile> {
  final String message =
      'Sei sicuro di voler eliminare definitivamente questo profilo?';

  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String imageFile = "";
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  late UserEntity userEntity;


  @override
  void initState() {
    userEntity = CustomFirebaseAuthenticationListener().userEntity!;
    nameController.text = userEntity.firstName!;
    lastNameController.text = userEntity.lastName!;
    emailController.text = userEntity.email!;
    phoneController.text = userEntity.phoneNumber!;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getPadding(top: 60, bottom: 60, left: 5, right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(
            deleteProfileOnTap: () {
              showDialog(
                  context: context,
                  builder: (ctx) => DeleteMessageDialog(
                      onConfirm: () async {
                        var id = CustomFirebaseAuthenticationListener().userEntity?.id ?? 0;
                        try{
                          UserRepository().deleteUser(id);
                          CustomFirebaseAuthenticationListener().logout();
                        }catch(e){
                          // ignore
                          Navigator.pop(context);
                        }
                      },
                      onCancel: () {
                        Navigator.pop(context);
                      },
                      message: message));
            },
            isVisible: true,
            buttonText: getCurrentLanguageValue(EDIT_PROFILE) ?? "",
            showDeleteProfile: true,
            pageTitle: getCurrentLanguageValue(MY_PROFILE)!,
            onTap: () {
              showDialog(
                  context: context,
                  builder: (ctx) => Form(
                        key: _formKey,
                        child: EditProfileForm(
                            cardTitle: getCurrentLanguageValue(EDIT_PROFILE) ?? "",
                            nameController: nameController,
                            lastNameController: lastNameController,
                            emailController: emailController,
                            phoneController: phoneController,
                            phoneValidator: notEmptyValidate,
                            emailValidator: validateEmail,
                            lastNameValidator: notEmptyValidate,
                            nameValidator: notEmptyValidate,
                            imageFile: imageFile,
                            changePassword: () {
                              SuccessSnackbar(context, text: 'Ti abbiamo inviato una mail per il reset della password!');
                              Navigator.pop(context);
                            },
                            imageOnTap: () async {
                              FilePickerResult? result = await FilePicker.platform.pickFiles();
                              //TODO SALVARE IMMAGINE SU FIRESTORAGE E MOSTRARE L'IMMAGINE PICKATA NEL BOX
                              if (result != null) {
                                Uint8List fileBytes = result.files.first.bytes!;
                                String fileName = result.files.first.name;
                                print('STAMPO IL FILE PICKATO');
                                print(fileName);

                                setState(() {
                                  imageFile = fileBytes.toString();
                                  print('STAMPO IMMAGINE NEL BOX');
                                  print(imageFile);
                                });
                                final User user = auth.currentUser!;
                                final uid = user.uid;
                                var path = 'profile_images/users_images/$uid/$fileName';
                                await FirebaseStorage.instance.ref(path).putData(fileBytes);
                              }
                            },
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                var id = CustomFirebaseAuthenticationListener().userEntity?.id ?? 0;
                                try{
                                  UserRepository().updateUser(id, compileUserEntity());
                                  SuccessSnackbar(context, text: 'Profilo modificato con successo!');
                                }catch(e){
                                  // ignore
                                  ErrorSnackbar(context, text: "Errore generico durante la modifica dell'utente, contattare il team di sviluppo");
                                }

                                Navigator.pop(context);
                              }
                            }),
                      ));
            },
          ),

          ProfileData(
            nameController: nameController,
            emailController: emailController,
            lastNameController: lastNameController,
            phoneNumberController: phoneController,
          )
        ],
      ),
    );
  }


  UserEntity compileUserEntity(){
    UserEntity result = CustomFirebaseAuthenticationListener().userEntity!;
    result.firstName = nameController.text;
    result.lastName = lastNameController.text;
    result.email = emailController.text;
    result.phoneNumber = phoneController.text;
    return result;
  }
}
