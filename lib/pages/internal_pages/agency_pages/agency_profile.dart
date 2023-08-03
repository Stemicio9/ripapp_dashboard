import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ripapp_dashboard/authentication/firebase_authentication_listener.dart';
import 'package:ripapp_dashboard/blocs/CurrentPageCubit.dart';
import 'package:ripapp_dashboard/blocs/profile_image_cubit.dart';
import 'package:ripapp_dashboard/blocs/users_list_cubit.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget/action.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget/action_widget_list.dart';
import 'package:ripapp_dashboard/models/user_entity.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/new_pages/agency_profile/edit_profile_popup.dart';
import 'package:ripapp_dashboard/pages/internal_pages/page_header.dart';
import 'package:ripapp_dashboard/utils/image_utils.dart';
import 'package:ripapp_dashboard/widgets/delete_message_dialog.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/edit_profile_form.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/profile_data.dart';
import 'package:ripapp_dashboard/repositories/user_repository.dart';
import 'package:ripapp_dashboard/widgets/dialog_card.dart';
import 'package:ripapp_dashboard/widgets/scaffold.dart';
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
  CurrentPageCubit get _currentPageCubit => context.read<CurrentPageCubit>();
  ProfileImageCubit get _profileImageCubit => context.read<ProfileImageCubit>();
  var imageFile;

  /*
  * faccio update -> modifica istanza di customfirebase con l'oggetto tornato
  * update, loginprelayer, setstate
  * */
  @override
  void initState() {
    _currentPageCubit.loadPage(ScaffoldWidgetState.agency_edit_profile_page, 0);
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
    print("ecco cosa si : $userEntity");
    nameController.text = userEntity.firstName!;
    lastNameController.text = userEntity.lastName!;
    emailController.text = userEntity.email!;
    phoneController.text = userEntity.phoneNumber!;
    final User user = FirebaseAuth.instance.currentUser!;
    final uid = user.uid;
    ImageUtils().downloadUrlImageUser(uid).then((value) => func(value));
    return BlocBuilder<ProfileImageCubit, ProfileImageState>(
        builder: (context, state) {
          print("il nostro link è $imageFile");
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
      action: ( ) {
        showDialog(
            context: context,
            builder: (ctx) => composeDialog()
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
          context.pop();
        },
        message: 'Sei sicuro di voler eliminare definitivamente questo profilo?'
    );
  }


  Widget composeDialog( ){
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: getPadding(left: 20, right: 20),
            width: 1100,
            child: DialogCard(
                cardTitle: getCurrentLanguageValue(EDIT_PROFILE) ?? "",
                cancelIcon: true,
                paddingLeft: 10,
                paddingRight: 10,
                child: EditProfilePopup(
                  imageFile: imageFile,
                  onWillPop: () {
                    return Future.value(true);
                  },
                  selectedProfile: userEntity,
                  onSubmit: (UserEntity internalUserEntity){
                    _currentPageCubit.editProfile(context,internalUserEntity).then((value) => refreshPage(value));
                    context.pop();
                  },
                )
            ),

          ),
        ],
    );
  }

  refreshPage(UserEntity newUser) {
    SuccessSnackbar(context, text: "Profilo modificato con successo");
    String? token = CustomFirebaseAuthenticationListener().tokenId;
    if (token != null){
      UserRepository().loginPreLayer(token).then((value) => completeRefresh());
    }

  }

  completeRefresh() {
    userEntity = CustomFirebaseAuthenticationListener().userEntity!;
    setState(() {
      print("sto facendo il set state");
    });
    UserRepository().setAuthenticationValues(CustomFirebaseAuthenticationListener().userEntity);
  }
}
