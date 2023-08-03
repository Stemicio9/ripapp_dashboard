import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/constants/validators.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/product_form/product_form_image.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/utils/style_utils.dart';
import 'package:ripapp_dashboard/widgets/action_button.dart';
import 'package:ripapp_dashboard/widgets/utilities/compose_input.dart';
import 'package:ripapp_dashboard/widgets/utilities/empty_fields_widget.dart';

class EditProfileWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController lastNameController;
  //final TextEditingController emailController;
  final TextEditingController phoneController;

  final Function() save;
  final Function() clearFields;
  final Function() changePassword;
  final Function resetOnTap;
  final Function cancelOnTap;

  final bool showConfirmPassword;
  final String imageUrl;
  final Function() imageOnTap;
  final bool isNetwork;
  final Uint8List? memoryImage;




  EditProfileWidget(
      {Key? key,
        required this.nameController,
        required this.lastNameController,
        required this.save,
        required this.clearFields,
        required this.imageUrl,
        required this.imageOnTap,
        required this.isNetwork,
        this.memoryImage,
      //  required this.emailController,
        required this.phoneController,
        required this.changePassword,
        required this.showConfirmPassword,
        required this.resetOnTap,
        required this.cancelOnTap,
      })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: ProductFormImage(
                    height: 141,
                      width: 141,
                      imageUrl: imageUrl,
                      onTap: (){
                        imageOnTap();
                      },
                      isNetwork: isNetwork,
                      memoryImage: memoryImage),
                )
            ),

            Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        composeInput(
                            getCurrentLanguageValue(NAME) ?? "",
                            getCurrentLanguageValue(NAME) ?? "",
                            nameController,
                            paddingRight: 10
                        ),
                        composeInput(
                            getCurrentLanguageValue(LASTNAME) ?? "",
                            getCurrentLanguageValue(LASTNAME) ?? "",
                            lastNameController,
                            labelPaddingLeft: 3,
                            paddingLeft: 10
                        ),
                      ],
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [

                    /*    composeInput(getCurrentLanguageValue(EMAIL) ?? "",
                            getCurrentLanguageValue(EMAIL) ?? "",
                            emailController,
                            paddingRight: 10,
                            validator: validateEmail
                        ), */

                        composeInput(
                            getCurrentLanguageValue(PHONE_NUMBER) ?? "",
                            getCurrentLanguageValue(PHONE_NUMBER) ?? "",
                            inputFormatter: FilteringTextInputFormatter.digitsOnly,
                            phoneController,
                            paddingRight: 10
                        ),
                        Expanded(flex:1,child: Container())

                      ],
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex:1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

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
                                  visible: !showConfirmPassword,
                                  child: ActionButtonV2(
                                    action: resetOnTap,
                                    text: "Reset password",
                                    fontSize: 14,
                                    containerHeight: 35,
                                  ),
                                ),

                                Visibility(
                                    visible: showConfirmPassword,
                                    child: Row(
                                      children: [

                                        Padding(
                                          padding: getPadding(right: 6.5),
                                          child: ActionButtonV2(
                                            action: cancelOnTap,
                                            text: getCurrentLanguageValue(CANCEL) ?? "",
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
                                          action: changePassword,
                                          text: getCurrentLanguageValue(CONFIRM) ?? "",
                                          maxWidth: 100,
                                          fontSize: 14,
                                          containerHeight: 35,

                                        ),
                                      ],
                                    )
                                )
                              ],
                            )
                        ),

                        Expanded(flex:1,child: Container())

                      ],
                    ),

                  ],
                )),
          ],
        ),

        composeActionRow()

      ],
    );
  }

  Widget composeActionRow() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: EmptyFieldsWidget().emptyFields(clearFields),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: getPadding(top: 40),
            child: Align(
              alignment: Alignment.centerRight,
              child: ActionButtonV2(
                action: save,
                text: getCurrentLanguageValue(SAVE)!,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
