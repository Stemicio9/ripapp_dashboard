import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/blocs/profile_image_cubit.dart';
import 'package:ripapp_dashboard/constants/images_constants.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/widgets/dialog_card.dart';
import 'package:ripapp_dashboard/widgets/utilities/empty_fields_widget.dart';
import 'package:ripapp_dashboard/widgets/utilities/network_memory_image_utility.dart';
import '../../../../constants/colors.dart';
import '../../../../utils/size_utils.dart';
import '../../../../utils/style_utils.dart';
import '../../../../widgets/action_button.dart';
import '../../../../widgets/input.dart';


class EditProfileForm extends StatefulWidget {
  final String cardTitle;
  final TextEditingController nameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final dynamic nameValidator;
  final dynamic lastNameValidator;
  final dynamic phoneValidator;
  final dynamic emailValidator;
  final Function() onTap;
  final Function() emptyFields;
  bool showConfirmPassword;
  final Function() changePassword;


  EditProfileForm({
    super.key,
    required this.emptyFields,
    required this.onTap,
    required this.cardTitle,
    this.nameValidator,
    this.lastNameValidator,
    this.phoneValidator,
    this.emailValidator,
    required this.nameController,
    required this.lastNameController,
    required this.emailController,
    required this.phoneController,
    this.showConfirmPassword = false,
    required this.changePassword
  });

  @override
  State<StatefulWidget> createState() {
    return EditProfileFormState();
  }
}

class EditProfileFormState extends State<EditProfileForm> {
  ProfileImageCubit get _profileImageCubit => context.read<ProfileImageCubit>();
  var imageFile = ImagesConstants.imgDemisePlaceholder;
  var memoryImage;
  bool isNetwork = true;

  Future<dynamic> downloadUrlImage(String uid) async {
    var fileList = await FirebaseStorage.instance.ref(
        'profile_images/users_images/UID:$uid/').listAll();
    for (var element in fileList.items) {
      print(element.name);
    }

    if (fileList.items.isEmpty) {
      var fileList = await FirebaseStorage.instance.ref('profile_images/')
          .listAll();
      var file = fileList.items[0];
      var result = await file.getDownloadURL();
      return result;
    }
    var file = fileList.items[0];
    var result = await file.getDownloadURL();
    return result;
  }

  void func(value) {
    _profileImageCubit.changeLoaded(true);
    imageFile = value;
  }


  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser!;
    final uid = user.uid;
    downloadUrlImage(uid).then((value) => func(value));
    return BlocBuilder<ProfileImageCubit, ProfileImageState>(
        builder: (context, state) {
          print("il nostro link è " + imageFile.toString());

          return Padding(
            padding: getPadding(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 900,
                  child: DialogCard(
                      cancelIcon: true,
                      paddingLeft: 10,
                      paddingRight: 10,
                      cardTitle: widget.cardTitle,
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Padding(
                                        padding: getPadding(bottom: 5),
                                        child: Text(
                                          'FOTO',
                                          style: SafeGoogleFont(
                                            'Montserrat',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: background,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                          onTap: () async {
                                            FilePickerResult? result = await FilePicker
                                                .platform.pickFiles();
                                            if (result != null) {
                                              Uint8List fileBytes = result.files
                                                  .first.bytes!;
                                              String fileName = result.files
                                                  .first.name;
                                              print('STAMPO IL FILE PICKATO');
                                              print(fileName);
                                              final User user = FirebaseAuth
                                                  .instance.currentUser!;
                                              final uid = user.uid;
                                              var path = 'profile_images/users_images/UID:$uid/';

                                              var fileList = await FirebaseStorage
                                                  .instance.ref(path).listAll();
                                              if (fileList.items.isNotEmpty) {
                                                var fileesistente = fileList
                                                    .items[0];
                                                fileesistente.delete();
                                              }
                                              isNetwork = false;
                                              await FirebaseStorage.instance
                                                  .ref("$path$fileName")
                                                  .putData(fileBytes);
                                              setState(() {
                                                memoryImage = fileBytes;
                                              });
                                            }
                                          },
                                          child: state.loaded ? Container(
                                            height: 130,
                                            width: 130,
                                            decoration: BoxDecoration(
                                                borderRadius: const BorderRadius
                                                    .all(Radius.circular(3)),
                                                color: greyDrag,
                                                border: Border.all(
                                                    color: background,
                                                    width: 1),
                                                image: DecorationImage(
                                                  image: NetworkMemoryImageUtility(
                                                      isNetwork: isNetwork,
                                                      networkUrl: imageFile,
                                                      memoryImage: memoryImage)
                                                      .provide(),
                                                  fit: BoxFit.cover,
                                                )
                                            ),
                                          ) : Container()
                                      )
                                    ],
                                  )),

                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Padding(
                                        padding: getPadding(bottom: 5),
                                        child: Text(
                                          'NOME',
                                          style: SafeGoogleFont(
                                            'Montserrat',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: background,
                                          ),
                                        ),
                                      ),
                                      InputsV2Widget(
                                        hinttext: getCurrentLanguageValue(
                                            NAME) ?? "",
                                        controller: widget.nameController,
                                        validator: widget.nameValidator,
                                        paddingLeft: 0,
                                        paddingRight: 20,
                                        borderSide: const BorderSide(
                                            color: greyState),
                                        activeBorderSide: const BorderSide(
                                            color: background),
                                      ),

                                      Padding(
                                        padding: getPadding(bottom: 5, top: 20),
                                        child: Text(
                                          'EMAIL',
                                          style: SafeGoogleFont(
                                            'Montserrat',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: background,
                                          ),
                                        ),
                                      ),
                                      InputsV2Widget(
                                        hinttext: getCurrentLanguageValue(
                                            EMAIL) ?? "",
                                        controller: widget.emailController,
                                        validator: widget.emailValidator,
                                        paddingRight: 20,
                                        paddingLeft: 0,
                                        borderSide: const BorderSide(
                                            color: greyState),
                                        activeBorderSide: const BorderSide(
                                            color: background),
                                      ),

                                      Padding(
                                        padding: getPadding(bottom: 5, top: 20),
                                        child: Text(
                                          'CAMBIA PASSWORD',
                                          style: SafeGoogleFont(
                                            'Montserrat',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: background,
                                          ),
                                        ),
                                      ),


                                      Visibility(
                                        visible: !widget.showConfirmPassword,
                                        child: ActionButtonV2(
                                          action: () {
                                            setState(() {
                                              widget.showConfirmPassword = true;
                                            });
                                          },
                                          text: "Reset password",
                                          fontSize: 14,
                                          containerHeight: 35,
                                        ),
                                      ),

                                      Visibility(
                                          visible: widget.showConfirmPassword,
                                          child: Row(
                                            children: [

                                              Padding(
                                                padding: getPadding(right: 6.5),
                                                child: ActionButtonV2(
                                                  action: () {
                                                    setState(() {
                                                      widget
                                                          .showConfirmPassword =
                                                      false;
                                                    });
                                                  },
                                                  text: getCurrentLanguageValue(
                                                      CANCEL) ?? "",
                                                  maxWidth: 100,
                                                  fontSize: 14,
                                                  containerHeight: 35,
                                                  borderColor: background,
                                                  textColor: background,
                                                  color: white,
                                                  hasBorder: true,

                                                ),
                                              ),

                                              ActionButtonV2(
                                                action: widget.changePassword,
                                                text: getCurrentLanguageValue(
                                                    CONFIRM) ?? "",
                                                maxWidth: 100,
                                                fontSize: 14,
                                                containerHeight: 35,

                                              ),
                                            ],
                                          )
                                      )
                                    ],
                                  )),

                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Padding(
                                        padding: getPadding(bottom: 5),
                                        child: Text(
                                          'COGNOME',
                                          style: SafeGoogleFont(
                                            'Montserrat',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: background,
                                          ),
                                        ),
                                      ),
                                      InputsV2Widget(
                                        hinttext: getCurrentLanguageValue(LAST_NAME) ?? "",
                                        controller: widget.lastNameController,
                                        validator: widget.lastNameValidator,
                                        paddingLeft: 0,
                                        paddingRight: 0,
                                        borderSide: const BorderSide(
                                            color: greyState),
                                        activeBorderSide: const BorderSide(
                                            color: background),
                                      ),

                                      Padding(
                                        padding: getPadding(bottom: 5, top: 20),
                                        child: Text(
                                          'TELEFONO',
                                          style: SafeGoogleFont(
                                            'Montserrat',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: background,
                                          ),
                                        ),
                                      ),
                                      InputsV2Widget(
                                        hinttext: getCurrentLanguageValue(PHONE_NUMBER)!,
                                        controller: widget.phoneController,
                                        validator: widget.phoneValidator,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        // O,
                                        keyboard: TextInputType.number,
                                        paddingRight: 0,
                                        paddingLeft: 0,
                                        borderSide: const BorderSide(
                                            color: greyState),
                                        activeBorderSide: const BorderSide(
                                            color: background),
                                      )

                                    ],
                                  )),
                            ],
                          ),

                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: EmptyFieldsWidget().emptyFields(widget.emptyFields),
                              ),

                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: getPadding(top: 40),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: ActionButtonV2(
                                      action: widget.onTap,
                                      text: getCurrentLanguageValue(SAVE)!,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                  ),
                )
              ],
            ),
          );
        });
  }

}