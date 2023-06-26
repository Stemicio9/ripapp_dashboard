import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ripapp_dashboard/authentication/firebase_authentication_listener.dart';
import 'package:ripapp_dashboard/blocs/firebase_storage/firebase_storage_bloc.dart';
import 'package:ripapp_dashboard/blocs/profile_image_cubit.dart';
import 'package:ripapp_dashboard/blocs/users_list_cubit.dart';
import 'package:ripapp_dashboard/models/user_entity.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/widgets/delete_message_dialog.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/edit_profile_form.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/profile_data.dart';
import 'package:ripapp_dashboard/widgets/snackbars.dart';
import '../../../constants/language.dart';
import '../../../constants/validators.dart';
import '../../../utils/size_utils.dart';
import '../header.dart';

class AgencyProfile extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  BlocProvider<FirebaseStorageCubit>(create: (_) => FirebaseStorageCubit(), child: AgencyProfileWidget(),);
  }

}


class AgencyProfileWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AgencyProfileState();
  }
}

class AgencyProfileState extends State<AgencyProfileWidget> {
  final String message = 'Sei sicuro di voler eliminare definitivamente questo profilo?';

  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late UserEntity userEntity;
  UsersListCubit get _userListCubit => context.read<UsersListCubit>();
  ProfileImageCubit get _profileImageCubit => context.read<ProfileImageCubit>();
  var imageFile;

  Future<dynamic> downloadUrlImage(String uid) async {
    var fileList = await FirebaseStorage.instance.ref('profile_images/users_images/$uid/').listAll();
    print("LA LISTA INTERA DEI FILE DI $uid");
    for (var element in fileList.items) {
      print(element.name);
    }

    if (fileList.items.isEmpty) {
      print("NON CI SONO FILE NELLA LISTA");
      var fileList = await FirebaseStorage.instance.ref('demise_placeholder.jpeg').listAll();
      var file = fileList.items[0];
      var result = await file.getDownloadURL();
      return result;
    }

    print("CI SONO FILE NELLA LISTA");

    var file = fileList.items[0];
    var result = await file.getDownloadURL();

    print("HO APPENA PESCATO IMMAGINE DI UTENTE $uid");
    print("URL IMMAGINE = $result");

    return result;
  }

  void func(value){
    _profileImageCubit.changeLoaded(true);
    imageFile = value;
    print('DIO $imageFile');
  }
  
  @override
  void initState() {
    final User user = FirebaseAuth.instance.currentUser!;
    final uid = user.uid;
    downloadUrlImage(uid).then((value) => func(value));

    print("qui ci arrivo?");
    userEntity = CustomFirebaseAuthenticationListener().userEntity!;
    nameController.text = userEntity.firstName!;
    lastNameController.text = userEntity.lastName!;
    emailController.text = userEntity.email!;
    phoneController.text = userEntity.phoneNumber!;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {


    return BlocBuilder<ProfileImageCubit, ProfileImageState>(
        builder: (context, state) {
        print("il nostro link è " + imageFile.toString());
        return Padding(
        padding: getPadding(top: 60, bottom: 60, left: 5, right: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(
              deleteProfileOnTap: () {
                showDialog(
                    context: context,
                    builder: (ctx) =>
                        DeleteMessageDialog(
                            onConfirm: () {
                              print(userEntity.id);
                              _userListCubit.delete(userEntity.id);
                              FirebaseAuth.instance.signOut();
                            },
                            onCancel: () {
                              context.pop;
                            },
                            message: message
                        )
                );
              },
              isVisible: true,
              buttonText: getCurrentLanguageValue(EDIT_PROFILE) ?? "",
              showDeleteProfile: true,
              pageTitle: getCurrentLanguageValue(MY_PROFILE)!,
              onTap: () {
                showDialog(
                    context: context,
                    builder: (ctx) =>
                        Form(
                          key: _formKey,
                          child: EditProfileForm(
                              cardTitle: getCurrentLanguageValue(
                                  EDIT_PROFILE) ?? "",
                              nameController: nameController,
                              lastNameController: lastNameController,
                              emailController: emailController,
                              phoneController: phoneController,
                              phoneValidator: notEmptyValidate,
                              emailValidator: validateEmail,
                              lastNameValidator: notEmptyValidate,
                              nameValidator: notEmptyValidate,
                              changePassword: () {
                                SuccessSnackbar(context,
                                    text: 'Ti abbiamo inviato una mail per il reset della password!');
                                Navigator.pop(context);
                              },
                              imageOnTap: () async {

                              },
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  SuccessSnackbar(context, text: 'Profilo modificato con successo!');
                                  Navigator.pop(context);
                                }
                              }),
                        ));
              },
            ),

            state.loaded ?  ProfileData(
              imageFile: imageFile,
              nameController: nameController,
              emailController: emailController,
              lastNameController: lastNameController,
              phoneNumberController: phoneController,
            ) : Container()
          ],
        ),
      );
      }
    );

  }
}
