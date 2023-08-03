import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ripapp_dashboard/models/user_entity.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/new_pages/agency_profile/edit_profile_widget.dart';
import 'package:ripapp_dashboard/widgets/snackbars.dart';

class EditProfilePopup extends StatefulWidget {


  final String imageFile;
  final Future<bool> Function() onWillPop;
  UserEntity? selectedProfile;
  final Function onSubmit;

  EditProfilePopup({Key? key,
    required this.onWillPop,
    this.selectedProfile,
    required this.onSubmit,
    required this.imageFile,
  }) : super(key: key);
  @override
  State<EditProfilePopup> createState() => _EditProfilePopupState();
}

class _EditProfilePopupState extends State<EditProfilePopup> {

  final TextEditingController nameController = TextEditingController();
//  final TextEditingController emailController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool showConfirmPassword = false;
  var memoryImage;
  bool isNetwork = true;
  late String fileName = "";
  Uint8List? fileBytes;

  @override
  void initState() {
    assignTextEditingControllerValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: widget.onWillPop,
        child: Form(
            key: _formKey,
            child: EditProfileWidget(
              lastNameController: lastNameController,
              nameController: nameController,
            //  emailController: emailController,
              phoneController: phoneController,
              clearFields: clearFields,
              save: save,
              imageUrl: widget.imageFile,
              imageOnTap: formImageOnTap,
              isNetwork: isNetwork,
              memoryImage: memoryImage,
              changePassword: () async{
                await FirebaseAuth.instance.sendPasswordResetEmail(email: widget.selectedProfile!.email!);
                SuccessSnackbar(context, text: 'Ti abbiamo inviato una mail per il reset della password!');
                context.pop();
              },
              showConfirmPassword: showConfirmPassword,
              resetOnTap: (){
                setState(() {
                  showConfirmPassword = true;
                });
              },
              cancelOnTap: (){
                setState(() {
                  showConfirmPassword = false;
                });
              },
            )
        )


    );
  }

  assignTextEditingControllerValues() {
    nameController.text = widget.selectedProfile?.firstName ?? '';
   // emailController.text = widget.selectedProfile?.email ?? '';
    lastNameController.text = widget.selectedProfile?.lastName ?? '';
    phoneController.text = widget.selectedProfile?.phoneNumber ?? '';
  }

  void clearFields() {
    nameController.clear();
    lastNameController.clear();
  //  emailController.clear();
    phoneController.clear();
  }


  void save() async {
      if (widget.selectedProfile == null) return;
    if(_formKey.currentState!.validate()) {
      UserEntity userToSave = widget.selectedProfile!.copyWith(
        //dati che non verranno modificati
          id:  widget.selectedProfile!.id,
          agency: widget.selectedProfile!.agency,
          role: widget.selectedProfile!.role,
          city: widget.selectedProfile!.city,
          email: widget.selectedProfile!.email,


        //dati che verranno modificati
          firstName: nameController.text,
          lastName: lastNameController.text,
          phoneNumber: phoneController.text,
      );

      await manageImageChange();
      widget.onSubmit(userToSave);
    }
  }

  manageImageChange() async {
    final User user = FirebaseAuth.instance.currentUser!;
    final uid = user.uid;
    var path = 'profile_images/users_images/UID:$uid/';
    var fileList = await FirebaseStorage.instance.ref(path).listAll();
    if (fileList.items.isNotEmpty && fileName != "") {
      var fileesistente = fileList.items[0];
      fileesistente.delete();
    }
    if (fileName != "") {
      await FirebaseStorage.instance.ref("$path$fileName").putData(fileBytes!);
    }
  }

  formImageOnTap() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        fileBytes = result.files.first.bytes!;
        fileName = result.files.first.name;
        isNetwork = false;
        memoryImage = fileBytes;
      });
    }
  }
}
