import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/constants/validators.dart';
import 'package:ripapp_dashboard/models/city_from_API.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/utils/style_utils.dart';
import 'package:ripapp_dashboard/widgets/action_button.dart';
import 'package:ripapp_dashboard/widgets/autocomplete_generic.dart';
import 'package:ripapp_dashboard/widgets/utilities/compose_input.dart';
import 'package:ripapp_dashboard/widgets/utilities/empty_fields_widget.dart';

class AgencyFormWidget extends StatelessWidget {


  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final bool isAddPopup;
  final Function() clearFields;
  final Function save;
  final String city;


  // TO USE CITYAUTOCOMPLETE
  final TextEditingController cityController;
  final List<CityFromAPI> options;
  final Function(CityFromAPI) onSelected;

   const AgencyFormWidget({Key? key,
     required this.city,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.cityController,
    required this.isAddPopup,
    required this.options,
    required this.onSelected,
    required this.clearFields,
    required this.save
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3,left: 10),
                    child: Text(
                      "CITTÀ",
                      style: SafeGoogleFont(
                        'Montserrat',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: background,
                      ),
                    ),
                  ),
                  Padding(
                    padding: getPadding(left: 3),
                    child: GenericAutocomplete<CityFromAPI>(
                        city: city,
                        cityController: cityController,
                        options: options,
                        hintText: "Città" ,
                        onSelected: onSelected,
                        validator: notEmptyValidate
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            composeInput(
                getCurrentLanguageValue(PHONE_NUMBER) ?? "",
                getCurrentLanguageValue(PHONE_NUMBER) ?? "",
                phoneController,
                paddingRight: 10,
                inputFormatter: FilteringTextInputFormatter.digitsOnly
            ),

            isAddPopup ? composeInput(getCurrentLanguageValue(EMAIL) ?? "",
                getCurrentLanguageValue(EMAIL) ?? "",
                emailController,
                validator: validateEmail,
                labelPaddingLeft: 3,
                paddingLeft: 10,
            ) : Expanded(flex: 1,child: Container()),

          ],
        ),

        composeActionRow(),

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
