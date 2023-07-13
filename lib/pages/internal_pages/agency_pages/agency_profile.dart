import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ripapp_dashboard/authentication/firebase_authentication_listener.dart';
import 'package:ripapp_dashboard/blocs/profile_image_cubit.dart';
import 'package:ripapp_dashboard/blocs/users_list_cubit.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget/action.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget/action_widget_list.dart';
import 'package:ripapp_dashboard/models/user_entity.dart';
import 'package:ripapp_dashboard/pages/internal_pages/page_header.dart';
import 'package:ripapp_dashboard/utils/image_utils.dart';
import 'package:ripapp_dashboard/widgets/delete_message_dialog.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/edit_profile_form.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/profile_data.dart';
import 'package:ripapp_dashboard/repositories/user_repository.dart';
import 'package:ripapp_dashboard/widgets/snackbars.dart';
import '../../../constants/language.dart';
import '../../../constants/validators.dart';
import '../../../utils/size_utils.dart';

class AgencyProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AgencyProfileState();
  }
}

class AgencyProfileState extends State<AgencyProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late UserEntity userEntity;
  UsersListCubit get _userListCubit => context.read<UsersListCubit>();
  ProfileImageCubit get _profileImageCubit => context.read<ProfileImageCubit>();
  var imageFile;

  @override
  void initState() {
    userEntity = CustomFirebaseAuthenticationListener().userEntity!;
    nameController.text = userEntity.firstName!;
    lastNameController.text = userEntity.lastName!;
    emailController.text = userEntity.email!;
    phoneController.text = userEntity.phoneNumber!;
    super.initState();
  }

  void func(value){
    _profileImageCubit.changeLoaded(true);
    imageFile = value;
  }

  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser!;
    final uid = user.uid;
    ImageUtils().downloadUrlImageUser(uid).then((value) => func(value));
    return BlocBuilder<ProfileImageCubit, ProfileImageState>(
        builder: (context, state) {
          print("il nostro link è " + imageFile.toString());
          return Padding(
            padding: getPadding(top: 30, bottom: 30, left: 5, right: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const PageHeader(pageTitle: "Il mio profilo"),

                ActionWidgetList(actions: composeSuperiorActions()),

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
  List<ActionDefinition> composeSuperiorActions(){
    var actions = <ActionDefinition>[];
    actions.add(ActionDefinition(
      text: "Modifica profilo",
      isButton: true,
      action: () {
        showDialog(
            context: context,
            builder: (ctx) => editProfile()
        );
      },
      actionInputs: List.empty(growable: true)
    ));

    actions.add(ActionDefinition(
      text: "Elimina profilo",
      buttonColor: rossoopaco,
      isButton: true,
      action: () {
        showDialog(
            context: context,
            builder: (ctx) => deleteProfile()
        );
      },
      actionInputs: List.empty(growable: true)
    ));
    return actions;
  }

  deleteProfile() {
    return DeleteMessageDialog(
        onConfirm: () async {
          _userListCubit.delete(userEntity.id);
          final User user = FirebaseAuth.instance.currentUser!;
          final uid = user.uid;
          var path = 'profile_images/users_images/UID:$uid/';
          var fileList = await FirebaseStorage.instance.ref(path).listAll();
          if (fileList.items.isNotEmpty) {
            var fileesistente = fileList.items[0];
            fileesistente.delete();
          }
          FirebaseAuth.instance.signOut();
        },
        onCancel: () {
          context.pop;
        },
        message: 'Sei sicuro di voler eliminare definitivamente questo profilo?'
    );
  }

  Widget editProfile(){
    return  Form(
      key: _formKey,
      child: EditProfileForm(
          emptyFields: (){
            nameController.text = "";
            lastNameController.text = "";
            emailController.text = "";
            phoneController.text = "";
          },
          cardTitle: getCurrentLanguageValue(EDIT_PROFILE) ?? "",
          nameController: nameController,
          lastNameController: lastNameController,
          emailController: emailController,
          phoneController: phoneController,
          phoneValidator: notEmptyValidate,
          emailValidator: validateEmail,
          lastNameValidator: notEmptyValidate,
          nameValidator: notEmptyValidate,
          changePassword: () {
            SuccessSnackbar(context, text: 'Ti abbiamo inviato una mail per il reset della password!');
            Navigator.pop(context);
          },
          onTap: () async {
            if (_formKey.currentState!.validate()) {

              UserEntity ue = UserEntity(
                  id: userEntity.id,
                  firstName: nameController.text,
                  lastName: lastNameController.text,
                  email: emailController.text,
                  phoneNumber: phoneController.text,
                  agency: userEntity.agency,
                  role: userEntity.role

              );

              UserRepository().editUser(ue).then((res) {
                SuccessSnackbar(context, text: "Profilo modificato con successo");
              }, onError: (e) {
                ErrorSnackbar(context, text: "Errore generico durante la modifica dell\'utente");
              });

              //TODO AGGIORNARE CORRETTAMENTE L'UTENTE DOPO L'EDIT
              String token = UserRepository().getFirebaseToken();
              await UserRepository().loginPreLayer(token);
              context.pop();
              setState(() {
              });
            }
          }),
    );
  }
}
