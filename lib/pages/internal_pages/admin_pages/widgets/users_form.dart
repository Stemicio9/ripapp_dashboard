import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/blocs/searchAgenciesCubit.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/models/agency_entity.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/utils/style_utils.dart';
import 'package:ripapp_dashboard/widgets/action_button.dart';
import 'package:ripapp_dashboard/widgets/dialog_card.dart';
import 'package:ripapp_dashboard/widgets/input.dart';

class UsersForm extends StatelessWidget {

  final String cardTitle;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController cityController;
  final TextEditingController lastNameController;
  final TextEditingController passwordController;
  final dynamic nameValidator;
  final dynamic cityValidator;
  final dynamic emailValidator;
  final dynamic phoneValidator;
  final dynamic lastNameValidator;
  final dynamic passwordValidator;
  final onTap;
  final Function(String selectedValue) statusChange;
  final Function(AgencyEntity selectedAgency) agencyChange;
  final List<String> roles;


  const UsersForm({
    super.key,
    required this.onTap,
    required this.cardTitle,
    this.nameValidator,
    this.emailValidator,
    this.phoneValidator,
    this.cityValidator,
    this.lastNameValidator,
    this.passwordValidator,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.cityController,
    required this.passwordController,
    required this.lastNameController,
    required this.statusChange,
    required this.agencyChange,
    required this.roles,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => SearchAgencyCubit(),
        child: UsersFormWidget(onTap: onTap,
          cardTitle: cardTitle,
          nameController: nameController,
          phoneController: phoneController,
          emailController: emailController,
          cityController: cityController,
          passwordController: passwordController,
          lastNameController: lastNameController,
          statusChange: statusChange,
          agencyChange: agencyChange,
          roles: roles
        ),
    );
  }
}






class UsersFormWidget extends StatefulWidget{

  final String cardTitle;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController cityController;
  final TextEditingController lastNameController;
  final TextEditingController passwordController;
  final dynamic nameValidator;
  final dynamic cityValidator;
  final dynamic emailValidator;
  final dynamic phoneValidator;
  final dynamic lastNameValidator;
  final dynamic passwordValidator;
  final onTap;
  final Function(String selectedValue) statusChange;
  final Function(AgencyEntity selectedAgency) agencyChange;
  final List<String> roles;

  const UsersFormWidget({
    super.key,
    required this.onTap,
    required this.cardTitle,
    this.nameValidator,
    this.emailValidator,
    this.phoneValidator,
    this.cityValidator,
    this.lastNameValidator,
    this.passwordValidator,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.cityController,
    required this.passwordController,
    required this.lastNameController,
    required this.statusChange,
    required this.agencyChange,
    required this.roles,
  });

  @override
  State<StatefulWidget> createState() {
    return UsersFormWidgetState();
  }
}


class UsersFormWidgetState extends State<UsersFormWidget> {

  SearchAgencyCubit get _searchAgencyCubit => context.read<SearchAgencyCubit>();

  List<String> agencies = <String>[
    'Seleziona Agenzia',
    'Agenzia 1',
    'Agenzia 2',
    'Agenzia 3',
    'Agenzia 4',
    'Agenzia 5',
  ];

  late String selectedValue;
  late AgencyEntity selectedAgency;


  @override
  void initState() {
    selectedValue = widget.roles.first;
    widget.statusChange(selectedValue);
    _searchAgencyCubit.fetchAgencies();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    print("REBUILDO");
    print(selectedValue);
    return Container(
      padding: getPadding(left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 700,
            child: DialogCard(
                cancelIcon: true,
                paddingLeft: 10,
                paddingRight: 10,
                cardTitle: widget.cardTitle,
                child: Column(
                  children: [
                    Padding(
                      padding: getPadding(bottom: 30),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    hinttext: getCurrentLanguageValue(NAME)!,
                                    controller: widget.nameController,
                                    validator: widget.nameValidator,
                                    paddingLeft: 0,
                                    paddingRight: 10,
                                    borderSide: const BorderSide(color: greyState),
                                    activeBorderSide: const BorderSide(color: background),
                                  )
                                ],
                              )),
                          Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: getPadding(bottom: 5,left: 3),
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
                                    hinttext: getCurrentLanguageValue(LAST_NAME)!,
                                    controller: widget.lastNameController,
                                    validator: widget.lastNameValidator,
                                    paddingRight: 0,
                                    paddingLeft: 10,
                                    borderSide: const BorderSide(color: greyState),
                                    activeBorderSide: const BorderSide(color: background),
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: getPadding(bottom: 30),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: getPadding(bottom: 5),
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
                                    hinttext: getCurrentLanguageValue(EMAIL)!,
                                    controller: widget.emailController,
                                    validator: widget.emailValidator,
                                    paddingLeft: 0,
                                    paddingRight: 10,
                                    borderSide: const BorderSide(color: greyState),
                                    activeBorderSide: const BorderSide(color: background),
                                  )
                                ],
                              )),
                          Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: getPadding(bottom: 5,left: 3),
                                    child: Text(
                                      'PASSWORD',
                                      style: SafeGoogleFont(
                                        'Montserrat',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: background,
                                      ),
                                    ),
                                  ),
                                  InputsV2Widget(
                                    isPassword: true,
                                    hinttext: getCurrentLanguageValue(PASSWORD)!,
                                    controller: widget.passwordController,
                                    validator: widget.passwordValidator,
                                    paddingRight: 0,
                                    paddingLeft: 10,
                                    borderSide: const BorderSide(color: greyState),
                                    activeBorderSide: const BorderSide(color: background),
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: getPadding(bottom: 30),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: getPadding(bottom: 5),
                                    child: Text(
                                      'CITTÀ',
                                      style: SafeGoogleFont(
                                        'Montserrat',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: background,
                                      ),
                                    ),
                                  ),
                                  InputsV2Widget(
                                    hinttext: getCurrentLanguageValue(CITY)!,
                                    controller: widget.cityController,
                                    validator: widget.cityValidator,
                                    paddingLeft: 0,
                                    paddingRight: 10,
                                    borderSide: const BorderSide(color: greyState),
                                    activeBorderSide: const BorderSide(color: background),
                                  )
                                ],
                              )),
                          Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: getPadding(bottom: 5,left: 3),
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
                                    paddingRight: 0,
                                    paddingLeft: 10,
                                    borderSide: const BorderSide(color: greyState),
                                    activeBorderSide: const BorderSide(color: background),
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: getPadding(bottom: 40),
                      child: Row(
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
                                      child: DropdownButton<String>(
                                        hint: const Text(
                                          "Seleziona ruolo",
                                          style: TextStyle(
                                            color: black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),

                                        isExpanded: true,
                                        underline:  const SizedBox(),
                                        value: selectedValue,
                                        onChanged: (String? value) {
                                          setState(() {
                                            selectedValue = value!;
                                            widget.statusChange(selectedValue);
                                          });
                                        },
                                        items: widget.roles.map((String role) {
                                          return  DropdownMenuItem<String>(
                                            value: role,
                                            child:  Padding(
                                              padding: const EdgeInsets.only(left: 20),
                                              child: Text(
                                                role,
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
                              child: selectedValue == 'Agenzia' ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: getPadding(bottom: 5,left: 6),
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
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Container(
                                      height: 48,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(3),
                                          border: Border.all(color: greyState)
                                      ),
                                      child: BlocBuilder<SearchAgencyCubit, SearchAgencyState>(
                                          builder: (context, state){

                                            if (state is SearchAgencyLoading)
                                              return CircularProgressIndicator();
                                            else if (state is SearchAgencyLoaded) {
                                              if ((state.agencies as List)
                                                  .length == 0) {
                                                return ErrorWidget(
                                                    "lista vuota"); //TODO aggiungere errore
                                              }
                                              else {
                                                List<
                                                    AgencyEntity> agencies = state
                                                    .agencies;

                                                return DropdownButton<AgencyEntity>(
                                                  hint: const Text(
                                                    "Seleziona agenzia",
                                                    style: TextStyle(
                                                      color: black,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.normal,
                                                    ),
                                                  ),

                                                  isExpanded: true,
                                                  underline: const SizedBox(),
                                                  value: state.selectedAgency,
                                                  onChanged: (
                                                      AgencyEntity? value) {
                                                    _searchAgencyCubit
                                                        .changeSelectedAgency(
                                                        value);
                                                    print("valoreeee ");
                                                    print(value.toString());
                                                    if (value != null)
                                                      widget.agencyChange(
                                                          value!);
                                                  },
                                                  items: agencies.map((
                                                      AgencyEntity agency) {
                                                    return DropdownMenuItem<
                                                        AgencyEntity>(
                                                      value: agency,
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .only(left: 20),
                                                        child: Text(
                                                          agency?.agencyName ??
                                                              "",
                                                          style:
                                                          const TextStyle(
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
                                            else
                                            return ErrorWidget("errore di connessione"); //TODO aggiungere errore
                                        }
                                        ),
                                      ),
                                    ),
                                ],
                              ) : Container()),
                        ],
                      ),
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: ActionButtonV2(
                        action: widget.onTap,
                        text: getCurrentLanguageValue(SAVE)!,
                      ),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}