import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/constants/validators.dart';
import 'package:ripapp_dashboard/models/UserStatusEnum.dart';
import 'package:ripapp_dashboard/models/agency_entity.dart';
import 'package:ripapp_dashboard/models/city_from_API.dart';
import 'package:ripapp_dashboard/models/user_entity.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/new_pages/user_form/city_autocomplete.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/new_pages/users_manage_page.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/utils/style_utils.dart';
import 'package:ripapp_dashboard/widgets/action_button.dart';
import 'package:ripapp_dashboard/widgets/input.dart';
import 'package:ripapp_dashboard/widgets/utilities/empty_fields_widget.dart';

class UserFormWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController phoneController;
  final TextEditingController cityController;
  final bool isAddPopup;

  // TO USE CITYAUTOCOMPLETE
  final List<CityFromAPI> options;
  final Function(CityFromAPI) onSelected;

  final AgencyEntity? selectedAgency;
  final List<AgencyEntity> agencies;
  final Function(AgencyEntity?) agencyChange;

  final UserEntity selectedUser;
  final Function(UserRoles?) statusChange;

  final UserStatus? selectedStatus;

  final Function save;
  final Function() clearFields;

  final Set<CityFromAPI> chips;
  final Function(CityFromAPI) onDeleted;


   UserFormWidget(
      {Key? key,
        required this.nameController,
        required this.lastNameController,
        required this.emailController,
        required this.passwordController,
        required this.phoneController,
        required this.cityController,
        required this.options,
        required this.onSelected,
        required this.selectedAgency,
        required this.agencies,
        required this.agencyChange,
        required this.selectedUser,
        required this.statusChange,
        required this.selectedStatus,
        required this.save,
        required this.clearFields,
        required this.chips,
        required this.onDeleted,
        this.isAddPopup = true,

      })
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  Column(children: [
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

    isAddPopup ? Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
        children: [
          composeInput(getCurrentLanguageValue(EMAIL) ?? "",
              getCurrentLanguageValue(EMAIL) ?? "",
              emailController,
              paddingRight: 10,
              validator: validateEmail
          ),
          composeInput(getCurrentLanguageValue(PASSWORD) ?? "",
              getCurrentLanguageValue(PASSWORD) ?? "",
              passwordController,
              validator: validatePassword,
              labelPaddingLeft: 3,
              paddingLeft: 10,
              isPassword: true
          ),
        ],
      ) : Container(),
      Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Text(
                      "COMUNI DI INTERESSE",
                      style: SafeGoogleFont(
                        'Montserrat',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: background,
                      ),
                    ),
                  ),
                  Padding(
                    padding: getPadding(right: 3),
                    child: CityAutocomplete(
                      options: options,
                      onSelected: onSelected,
                      initialValue: cityController,
                      chips: chips.toList(),
                      onDeleted: onDeleted,
                    ),
                  ),
                ],
              ),
            ),
            composeInput(
                getCurrentLanguageValue(PHONE_NUMBER) ?? "",
                getCurrentLanguageValue(PHONE_NUMBER) ?? "",
                labelPaddingLeft: 3,
                paddingLeft: 10,
                phoneController,
                inputFormatter: FilteringTextInputFormatter.digitsOnly),
          ]),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          composeRole(),

          Expanded(
            flex: 1,
            child: selectedStatus == UserStatus.agency
                ? buildAgencyDropdown()
                : Container(),
          )
        ],
      ),
      composeActionRow(),

    ]
    );
  }



  Widget composeInput(
      String hint, String label, TextEditingController controller,
      {TextInputFormatter? inputFormatter, bool isPassword = false, Function validator = notEmptyValidate,
        double paddingRight = 0, double paddingLeft = 0, double labelPaddingLeft = 0}) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: getPadding(bottom: 30),
        child: InputsV2Widget(
          hinttext: hint,
          labelText: label.toUpperCase(),
          isVisible: true,
          controller: controller,
          validator: validator,
          paddingRight: paddingRight,
          paddingLeft: paddingLeft,
          isPassword: isPassword,
          inputFormatters: inputFormatter != null ? <TextInputFormatter>[inputFormatter] : <TextInputFormatter>[],
          labelPaddingLeft: labelPaddingLeft,
          borderSide: const BorderSide(color: greyState),
          activeBorderSide: const BorderSide(color: background),
        ),
      ),
    );
  }

  Widget buildAgencyDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 3,left: 10),
          child: Text(
            "AGENZIA",
            style: SafeGoogleFont(
              'Montserrat',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: background,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Container(
            height: 48,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                border: Border.all(color: greyState)
            ),
            child: DropdownButton<AgencyEntity>(
              hint: const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Seleziona agenzia",
                  style: TextStyle(
                    color: black,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              isExpanded: true,
              underline: const SizedBox(),
              value: selectedAgency,
              onChanged: agencyChange,
              items: agencies.map((AgencyEntity agency) {
                return DropdownMenuItem<AgencyEntity>(
                  value: agency,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      agency.agencyName ?? "",
                      style: const TextStyle(
                        color: black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        )],
    );
  }

  Widget composeRole() {
    return Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Text(
              "RUOLO",
              style: SafeGoogleFont(
                'Montserrat',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: background,
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: greyState)
                ),
                child: DropdownButton<UserRoles>(
                  hint: const Text(
                    "Seleziona ruolo",
                    style: TextStyle(
                      color: black,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),

                  isExpanded: true,
                  underline: const SizedBox(),
                  value: fromUserStatus(selectedStatus ?? selectedUser.status ?? UserStatus.active),
                  // value: widget.isAddPage ? fromUserStatus(state.selectedUser.status = UserStatus.active) : fromUserStatus(state.selectedUser.status ?? UserStatus.active),
                  onChanged: statusChange,
                  items: UserRoles.values.map((UserRoles role) {
                    return DropdownMenuItem<UserRoles>(
                      value: role,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          role.name,
                          style: const TextStyle(
                            color: black,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              )
          ),
        ],
      ),
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
