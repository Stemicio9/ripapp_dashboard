import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/blocs/city_list_cubit.dart';
import 'package:ripapp_dashboard/blocs/searchAgenciesCubit.dart';
import 'package:ripapp_dashboard/blocs/selected_demise_cubit.dart';
import 'package:ripapp_dashboard/blocs/selected_user_cubit.dart';
import 'package:ripapp_dashboard/constants/app_roles.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/models/agency_entity.dart';
import 'package:ripapp_dashboard/models/city_from_API.dart';
import 'package:ripapp_dashboard/models/user_entity.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/utils/style_utils.dart';
import 'package:ripapp_dashboard/widgets/action_button.dart';
import 'package:ripapp_dashboard/widgets/dialog_card.dart';
import 'package:ripapp_dashboard/widgets/input.dart';
import '../../../../widgets/autocomplete.dart';

class UsersForm extends StatelessWidget {
  final String cardTitle;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController lastNameController;
  final TextEditingController passwordController;
  final TextEditingController filterController;
  final dynamic nameValidator;
  final List<String> options;
  final dynamic emailValidator;
  final dynamic phoneValidator;
  final dynamic lastNameValidator;
  final dynamic passwordValidator;
  final onTap;
  final Function(String selectedValue) statusChange;
  final Function(AgencyEntity selectedAgency) agencyChange;
  final List<String> roles;

  const UsersForm(
      {super.key,
      required this.onTap,
      required this.cardTitle,
      this.nameValidator,
      this.emailValidator,
      this.phoneValidator,
      this.lastNameValidator,
      this.passwordValidator,
      required this.nameController,
      required this.emailController,
      required this.filterController,
      required this.phoneController,
      required this.passwordController,
      required this.lastNameController,
      required this.statusChange,
      required this.agencyChange,
      required this.roles,
      required this.options});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SearchAgencyCubit(),
        ),
          BlocProvider(
            create: (_) => SelectedDemiseCubit(),
          ),
        ],
        child: UsersFormWidget(
            onTap: onTap,
            cardTitle: cardTitle,
            options: options,
            filterController: filterController,
            nameController: nameController,
            phoneController: phoneController,
            emailController: emailController,
            passwordController: passwordController,
            lastNameController: lastNameController,
            statusChange: statusChange,
            agencyChange: agencyChange,
            roles: roles,
            nameValidator: nameValidator,
            lastNameValidator: lastNameValidator,
          emailValidator: emailValidator,
          passwordValidator: passwordValidator,
          phoneValidator: phoneValidator,
        ),
    );
  }
}


class UsersFormWidget extends StatefulWidget{

  final String cardTitle;
  late TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController lastNameController;
  final TextEditingController filterController;
  final TextEditingController passwordController;
  final dynamic nameValidator;
  final List<String> options;
  final dynamic emailValidator;
  final dynamic phoneValidator;
  final dynamic lastNameValidator;
  final dynamic passwordValidator;
  final onTap;
  final Function(String selectedValue) statusChange;
  final Function(AgencyEntity selectedAgency) agencyChange;
  final List<String> roles;

  UsersFormWidget(
      {super.key,
      required this.onTap,
      required this.cardTitle,
      this.nameValidator,
      this.emailValidator,
      this.phoneValidator,
      this.lastNameValidator,
      this.passwordValidator,
      required this.nameController,
      required this.emailController,
      required this.filterController,
      required this.phoneController,
      required this.passwordController,
      required this.lastNameController,
      required this.statusChange,
      required this.agencyChange,
      required this.roles,
      required this.options});

  @override
  State<StatefulWidget> createState() {
    return UsersFormWidgetState();
  }
}

class UsersFormWidgetState extends State<UsersFormWidget> {
  SearchAgencyCubit get _searchAgencyCubit => context.read<SearchAgencyCubit>();

  CityListCubit get _cityListCubit => context.read<CityListCubit>();
  late String selectedValue;
  late AgencyEntity selectedAgency;
  List<CityFromAPI> cityList = [];
  List<String> emptyList = ['Seleziona agenzia'];
  late UserEntity userEntity;

  @override
  void initState() {
    selectedValue = widget.roles.first;
    widget.statusChange(selectedValue);
    _searchAgencyCubit.fetchAgencies();
    _cityListCubit.fetchCityList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("REBUILDO");
    print(selectedValue);
    return BlocBuilder<SelectedUserCubit, SelectedUserState>(
        builder: (context, state) {
      print("OLAAAA");
      print(state.runtimeType);
      print(state.selectedUser.toJson());
      UserEntity userEntity = state.selectedUser;
      widget.nameController.text = state.selectedUser.firstName ?? "";
      widget.lastNameController.text = state.selectedUser.lastName ?? "";
      widget.emailController.text = state.selectedUser.email ?? "";
      widget.phoneController.text = state.selectedUser.phoneNumber ?? "";
      widget.passwordController.text = state.selectedUser.password ?? "";
      print(userEntity);
      print("OLAAA2");
      return Container(
        padding: getPadding(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        hinttext:
                                            getCurrentLanguageValue(NAME)!,
                                        controller: widget.nameController,
                                        validator: widget.nameValidator,
                                        paddingLeft: 0,
                                        paddingRight: 10,
                                        borderSide:
                                            const BorderSide(color: greyState),
                                        activeBorderSide:
                                            const BorderSide(color: background),
                                      )
                                    ],
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: getPadding(bottom: 5, left: 3),
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
                                        hinttext:
                                            getCurrentLanguageValue(LAST_NAME)!,
                                        controller: widget.lastNameController,
                                        validator: widget.lastNameValidator,
                                        paddingRight: 0,
                                        paddingLeft: 10,
                                        borderSide:
                                            const BorderSide(color: greyState),
                                        activeBorderSide:
                                            const BorderSide(color: background),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        hinttext:
                                            getCurrentLanguageValue(EMAIL)!,
                                        controller: widget.emailController,
                                        validator: widget.emailValidator,
                                        paddingLeft: 0,
                                        paddingRight: 10,
                                        borderSide:
                                            const BorderSide(color: greyState),
                                        activeBorderSide:
                                            const BorderSide(color: background),
                                      )
                                    ],
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: getPadding(bottom: 5, left: 3),
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
                                        hinttext:
                                            getCurrentLanguageValue(PASSWORD)!,
                                        controller: widget.passwordController,
                                        validator: widget.passwordValidator,
                                        paddingRight: 0,
                                        paddingLeft: 10,
                                        borderSide:
                                            const BorderSide(color: greyState),
                                        activeBorderSide:
                                            const BorderSide(color: background),
                                      )
                                    ],
                                  )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: getPadding(bottom: 30),
                          child: BlocBuilder<CityListCubit, CityListState>(
                              builder: (context, cityState) {
                            if (cityState is CityListLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (cityState is CityListLoaded) {
                              cityList = cityState.listCity;
                              if (cityList.isNotEmpty) {
                                return Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                            AutocompleteWidget(
                                              options: cityList,
                                              paddingRight: 10,
                                              paddingLeft: 0,
                                              hintText: getCurrentLanguageValue(
                                                  CITY)!,
                                              filterController:
                                                  widget.filterController,
                                            )
                                          ],
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: getPadding(
                                                  bottom: 5, left: 3),
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
                                              hinttext: getCurrentLanguageValue(
                                                  PHONE_NUMBER)!,
                                              controller:
                                                  widget.phoneController,
                                              validator: widget.phoneValidator,
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                              ],
                                              paddingRight: 0,
                                              paddingLeft: 10,
                                              borderSide: const BorderSide(
                                                  color: greyState),
                                              activeBorderSide:
                                                  const BorderSide(
                                                      color: background),
                                            )
                                          ],
                                        )),
                                  ],
                                );
                              }
                            }
                              return ErrorWidget("errore di connessione");


                          }),
                        ),
                        Padding(
                          padding: getPadding(bottom: 40),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Container(
                                          height: 48,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              border:
                                                  Border.all(color: greyState)),
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
                                            underline: const SizedBox(),
                                            value: selectedValue,
                                            onChanged: (String? value) {
                                              setState(() {
                                                selectedValue = value!;
                                                widget.statusChange(
                                                    selectedValue);
                                              });
                                            },
                                            items:
                                                widget.roles.map((String role) {
                                              return DropdownMenuItem<String>(
                                                value: role,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20),
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
                                  child: selectedValue == 'Agenzia'
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: getPadding(
                                                  bottom: 5, left: 4),
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
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Container(
                                                height: 48,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                    border: Border.all(
                                                        color: greyState)),
                                                child: BlocBuilder<
                                                        SearchAgencyCubit,
                                                        SearchAgencyState>(
                                                    builder: (context, state) {
                                                  if (state
                                                      is SearchAgencyLoading) {
                                                    return const Center(
                                                        child:
                                                            CircularProgressIndicator());
                                                  } else if (state
                                                      is SearchAgencyLoaded) {
                                                    if (state
                                                        .agencies.isEmpty) {
                                                      return DropdownButton<
                                                          String>(
                                                        hint: const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 20),
                                                          child: Text(
                                                            "Seleziona agenzia",
                                                            style: TextStyle(
                                                              color: black,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                          ),
                                                        ),
                                                        isExpanded: true,
                                                        underline:
                                                            const SizedBox(),
                                                        onChanged:
                                                            (String? value) {},
                                                        items: emptyList.map<
                                                            DropdownMenuItem<
                                                                String>>((String
                                                            value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Text(value),
                                                          );
                                                        }).toList(),
                                                      );
                                                    } else {
                                                      List<AgencyEntity>
                                                          agencies =
                                                          state.agencies;

                                                      return DropdownButton<
                                                          AgencyEntity>(
                                                        hint: const Text(
                                                          "Seleziona agenzia",
                                                          style: TextStyle(
                                                            color: black,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                        ),
                                                        isExpanded: true,
                                                        underline:
                                                            const SizedBox(),
                                                        value: state
                                                            .selectedAgency,
                                                        onChanged:
                                                            (AgencyEntity?
                                                                value) {
                                                          _searchAgencyCubit
                                                              .changeSelectedAgency(
                                                                  value);
                                                          print("valoreeee ");
                                                          print(
                                                              value.toString());
                                                          if (value != null)
                                                            widget.agencyChange(
                                                                value!);
                                                        },
                                                        items: agencies.map(
                                                            (AgencyEntity
                                                                agency) {
                                                          return DropdownMenuItem<
                                                              AgencyEntity>(
                                                            value: agency,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 20),
                                                              child: Text(
                                                                agency.agencyName ??
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
                                                    return ErrorWidget(
                                                        "errore di connessione"); //TODO aggiungere errore
                                                }),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container()),
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
              ),
            )
          ],
        ),
      );
    });
  }
}