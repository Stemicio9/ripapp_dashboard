import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/constants/validators.dart';
import 'package:ripapp_dashboard/models/UserStatusEnum.dart';
import 'package:ripapp_dashboard/models/agency_entity.dart';
import 'package:ripapp_dashboard/models/city_from_API.dart';
import 'package:ripapp_dashboard/models/user_entity.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/new_pages/users_manage_page.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/add_demise/cities_autocomplete.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/utils/style_utils.dart';
import 'package:ripapp_dashboard/widgets/action_button.dart';
import 'package:ripapp_dashboard/widgets/input.dart';
import 'package:ripapp_dashboard/widgets/utilities/empty_fields_widget.dart';


class UserFormInputs extends StatelessWidget {


  final TextEditingController nameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController cityController;
  final TextEditingController phoneController;

  final Function() action;
  final Function(UserRoles?) statusChange;
  final Function(AgencyEntity?) agencyChange;
  final List<CityFromAPI> cityList;
  final bool isAddPage;
  final bool isPassword;
  final Function() iconOnTap;
  final Function() emptyFields;
  final List<UserRoles> roles;
  final suffixIcon;
  final UserEntity selectedUser;
  final List<AgencyEntity> agencies;
  AgencyEntity? selectedAgency;
  List<String> emptyList = ['Seleziona agenzia'];
  final List<CityFromAPI> chips;
  final Function(CityFromAPI) onSelected;
  final Function onDeleted;


  UserFormInputs({
    super.key,

    required this.chips,
    required this.emptyFields,
    required this.nameController,
    required this.lastNameController,
    required this.emailController,
    required this.passwordController,
    required this.cityController,
    required this.phoneController,
    required this.action,
    required this.isAddPage,
    required this.suffixIcon,
    required this.cityList,
    required this.isPassword,
    required this.iconOnTap,
    required this.roles,
    required this.statusChange,
    required this.agencyChange,
    required this.selectedUser,
    required this.agencies,
    this.selectedAgency,
    required this.onSelected,
    required this.onDeleted
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: getPadding(bottom: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Expanded(
                  flex: 1,
                  child: InputsV2Widget(
                    isVisible: true,
                    labelText: getCurrentLanguageValue(NAME)!.toUpperCase(),
                    hinttext: getCurrentLanguageValue(NAME)!,
                    controller: nameController,
                    validator: notEmptyValidate,
                    paddingLeft: 0,
                    paddingRight: 10,
                    borderSide: const BorderSide(color: greyState),
                    activeBorderSide: const BorderSide(color: background),
                  )
              ),
              Expanded(
                  flex: 1,
                  child: InputsV2Widget(
                    isVisible: true,
                    labelText: getCurrentLanguageValue(LAST_NAME)!.toUpperCase(),
                    hinttext: getCurrentLanguageValue(LAST_NAME)!,
                    controller: lastNameController,
                    labelPaddingLeft: 4,
                    validator: notEmptyValidate,
                    paddingRight: 0,
                    paddingLeft: 10,
                    borderSide: const BorderSide(color: greyState),
                    activeBorderSide: const BorderSide(color: background),
                  )
              ),
            ],
          ),
        ),
        Visibility(
          visible: isAddPage,
          child: Padding(
            padding: getPadding(bottom: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Expanded(
                    flex: 1,
                    child: InputsV2Widget(
                      isVisible: true,
                      labelText: getCurrentLanguageValue(EMAIL)!.toUpperCase(),
                      hinttext: getCurrentLanguageValue(EMAIL)!,
                      controller: emailController,
                      validator: validateEmail,
                      paddingLeft: 0,
                      paddingRight: 10,
                      borderSide: const BorderSide(color: greyState),
                      activeBorderSide: const BorderSide(color: background),
                    )
                ),
                Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputsV2Widget(
                          iconOnTap: iconOnTap,
                          isVisible: true,
                          isPassword: isPassword,
                          labelPaddingLeft: 4,
                          labelText: getCurrentLanguageValue(PASSWORD)!.toUpperCase(),
                          hinttext: getCurrentLanguageValue(PASSWORD)!,
                          controller: passwordController,
                          validator: validatePassword,
                          paddingRight: 0,
                          suffixIcon: suffixIcon,
                          isSuffixIcon: true,
                          suffixIconHeight: 25,
                          suffixIconWidth: 25,
                          paddingLeft: 10,
                          borderSide: const BorderSide(color: greyState),
                          activeBorderSide: const BorderSide(color: background),
                        )
                      ],
                    )
                ),
              ],
            ),
          ),
        ),
        Padding(
            padding: getPadding(bottom: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: getPadding(right: 3),
                    child: CitiesAutocomplete(
                      chips: chips,
                      cityList: cityList,
                      onSelected: onSelected,
                      onDeleted: onDeleted,
                    ),
                   )
                  ),
                Expanded(
                    flex: 1,
                    child: InputsV2Widget(
                      hinttext: getCurrentLanguageValue(PHONE_NUMBER)!,
                      labelText: getCurrentLanguageValue(PHONE_NUMBER)!.toUpperCase(),
                      isVisible: true,
                      controller: phoneController,
                      validator: notEmptyValidate,
                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                      paddingRight: 0,
                      paddingLeft: 10,
                      labelPaddingLeft: 4,
                      borderSide: const BorderSide(color: greyState),
                      activeBorderSide: const BorderSide(color: background),
                    )
                ),
              ],
            )
        ),
        Padding(
          padding: getPadding(bottom: 40),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: getPadding(bottom: 5),
                        child: Text(
                          'RUOLO',
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
                            value: fromUserStatus(selectedUser.status ?? UserStatus.active),
                            // value: widget.isAddPage ? fromUserStatus(state.selectedUser.status = UserStatus.active) : fromUserStatus(state.selectedUser.status ?? UserStatus.active),
                            onChanged: statusChange,
                            items: roles.map((UserRoles role) {
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
                        ),
                      ),
                    ],
                  )),
              Expanded(
                  flex: 1,
                  child: selectedUser.status?.name.toLowerCase() == 'agency' ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //AGENCY WITH LABEL
                      Padding(
                        padding: getPadding(bottom: 5, left: 4),
                        child: Text(
                          'AGENZIA',
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
                          child: composeDropdown()
                        ),
                      ),
                    ],
                  ) : Container()),
            ],
          ),
        ),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: EmptyFieldsWidget().emptyFields(emptyFields),
            ),

            Expanded(
              flex: 1,
              child: Padding(
                padding: getPadding(top: 40),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ActionButtonV2(
                    action: action,
                    text: getCurrentLanguageValue(SAVE)!,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }


  Widget composeDropdown(){
    if (agencies.isEmpty) {
      return DropdownButton<String>(
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
        onChanged: (String? value) {},
        items: emptyList.map<DropdownMenuItem<String>>((
            String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      );
    }
    else {

      if (selectedUser.agency == null && selectedUser.status == UserStatus.agency) {
        agencyChange(selectedAgency!);
      }
      return DropdownButton<AgencyEntity>(
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
        value: selectedUser.agency ?? selectedAgency,
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
      );
    }
  }

}