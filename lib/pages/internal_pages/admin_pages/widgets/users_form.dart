import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/blocs/city_list_cubit.dart';
import 'package:ripapp_dashboard/blocs/searchAgenciesCubit.dart';
import 'package:ripapp_dashboard/blocs/selected_user_cubit.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/images_constants.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/models/UserStatusEnum.dart';
import 'package:ripapp_dashboard/models/agency_entity.dart';
import 'package:ripapp_dashboard/models/user_entity.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/users_manage.dart';
import 'package:ripapp_dashboard/models/city_from_API.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/utils/style_utils.dart';
import 'package:ripapp_dashboard/widgets/action_button.dart';
import 'package:ripapp_dashboard/widgets/dialog_card.dart';
import 'package:ripapp_dashboard/widgets/input.dart';
import '../../../../blocs/selected_city_cubit.dart';
import '../../../../widgets/autocomplete.dart';




class UsersForm extends StatefulWidget {
  final String cardTitle;
  late TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController lastNameController;
  final TextEditingController filterController;
  final TextEditingController passwordController;
  final dynamic nameValidator;
  final List<CityFromAPI> options;
  final dynamic emailValidator;
  final dynamic phoneValidator;
  final dynamic lastNameValidator;
  final dynamic passwordValidator;
  final dynamic cityValidator;
  final onTap;
  final Function(String selectedValue) statusChange;
  final Function(AgencyEntity selectedAgency) agencyChange;
  late  List<UserRoles> roles;
  final bool isAddPage;


  UsersForm({
    super.key,
    required this.onTap,
    required this.cardTitle,
    this.nameValidator,
    this.emailValidator,
    this.phoneValidator,
    this.lastNameValidator,
    this.passwordValidator,
    this.cityValidator,
    required this.nameController,
    required this.emailController,
    required this.filterController,
    required this.phoneController,
    required this.passwordController,
    required this.lastNameController,
    required this.statusChange,
    required this.agencyChange,
    required this.roles,
    required this.options,
    this.isAddPage = true
  });

  @override
  State<StatefulWidget> createState() {
    return UsersFormState();
  }
}

class UsersFormState extends State<UsersForm> {
  SearchAgencyCubit get _searchAgencyCubit => context.read<SearchAgencyCubit>();
  SelectedUserCubit get _selectedUserCubit => context.read<SelectedUserCubit>();
  late bool _passwordVisible;

  CityListCubit get _cityListCubit => context.read<CityListCubit>();
  late String selectedValue;
  late AgencyEntity selectedAgency;
  List<CityFromAPI> cityList = [];
  List<String> emptyList = ['Seleziona agenzia'];
  late UserEntity userEntity;
  String? city;

  @override
  void initState() {
    _searchAgencyCubit.fetchAgencies();
    _cityListCubit.fetchCityList();
    _passwordVisible = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedCityCubit, SelectedCityState>(
        builder: (context, stateCity) {
          if (stateCity is SelectedCityState) {
            widget.filterController.text = stateCity.selectedCity.name ?? widget.filterController.text;
            print(widget.filterController.text);
            return BlocBuilder<SelectedUserCubit, SelectedUserState>(
                builder: (context, state) {
                  if (state is SelectedUserState) {
                    if(widget.isAddPage){
                      widget.nameController.text = "";
                      widget.phoneController.text = "";
                      widget.lastNameController.text = "";
                    }else{
                    widget.nameController.text = state.selectedUser.firstName ?? widget.nameController.text;
                    widget.lastNameController.text = state.selectedUser.lastName ?? widget.lastNameController.text;
                    widget.phoneController.text = state.selectedUser.phoneNumber ?? widget.phoneController.text;
                    }
                    if (state.selectedUser.status == null) {
                      widget.statusChange(UserRoles.Utente.name);
                    }
                    return Padding(
                        padding: getPadding(left: 20, right: 20),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
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

                                                            //NAME WITH LABEL
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

                                                            //SURNAME WITH LABEL
                                                            Padding(
                                                              padding: getPadding(bottom: 5,left: 4),
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
                                              Visibility(
                                                visible: widget.isAddPage,
                                                child: Padding(
                                                  padding: getPadding(bottom: 30),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                          flex: 1,
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [

                                                              //EMAIL WITH LABEL
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

                                                              //PASSWORD WITH LABEL
                                                              Padding(
                                                                padding: getPadding(bottom: 5,left: 4),
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
                                                                iconOnTap: (){
                                                                  setState(() {
                                                                    _passwordVisible = !_passwordVisible;
                                                                  });
                                                                },
                                                                isPassword: !_passwordVisible,
                                                                hinttext: getCurrentLanguageValue(PASSWORD)!,
                                                                controller: widget.passwordController,
                                                                validator: widget.passwordValidator,
                                                                paddingRight: 0,
                                                                suffixIcon: _passwordVisible ? ImagesConstants.imgPassSee : ImagesConstants.imgPassUnsee,
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
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: BlocBuilder<CityListCubit, CityListState>(
                                                            builder: (context, cityState) {
                                                              if (cityState is CityListLoading) {
                                                                return const Center(child: CircularProgressIndicator());
                                                              } else if (cityState is CityListLoaded) {
                                                                cityList = cityState.listCity;
                                                                if (cityList.isNotEmpty) {
                                                                  return Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [

                                                                      // CITY WITH LABEL
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
                                                                        validator: widget.cityValidator,
                                                                        paddingRight: 10,
                                                                        paddingLeft: 0,
                                                                        paddingTop: 0,
                                                                        paddingBottom: 0,
                                                                        hintText: getCurrentLanguageValue(CITY)!,
                                                                        filterController: widget.filterController,
                                                                      )
                                                                    ],
                                                                  );
                                                                }
                                                              }return ErrorWidget("errore di connessione");

                                                            }),),
                                                      Expanded(
                                                          flex: 1,
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [

                                                              // PHONE NUMBER WITH LABEL
                                                              Padding(
                                                                padding: getPadding(
                                                                    bottom: 5, left: 4),
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
                                                                controller: widget.phoneController,
                                                                validator: widget.phoneValidator,
                                                                inputFormatters: <
                                                                    TextInputFormatter>[
                                                                  FilteringTextInputFormatter.digitsOnly,
                                                                ],
                                                                paddingRight: 0,
                                                                paddingLeft: 10,
                                                                borderSide: const BorderSide(
                                                                    color: greyState),
                                                                activeBorderSide: const BorderSide(
                                                                    color: background),
                                                              )
                                                            ],

                                                          )),
                                                    ],
                                                  )
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

                                                            //DROPDOWN ROLE WITH LABEL
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
                                                              padding: const EdgeInsets.only(
                                                                  right: 10),
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
                                                                  value: fromUserStatus(state.selectedUser.status ?? UserStatus.active),
                                                                 // value: widget.isAddPage ? fromUserStatus(state.selectedUser.status = UserStatus.active) : fromUserStatus(state.selectedUser.status ?? UserStatus.active),
                                                                  onChanged: (UserRoles? value) {
                                                                    _selectedUserCubit.selectUser(state.selectedUser.copyWith(status: fromUserRole(value ?? UserRoles.Utente)));
                                                                    widget.statusChange(value?.name ?? "");
                                                                  },
                                                                  items: widget.roles.map((UserRoles role) {
                                                                    return DropdownMenuItem<
                                                                        UserRoles>(
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
                                                        child: state.selectedUser.status?.name.toLowerCase() == 'agency' ?
                                                        Column(
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
                                                                child: BlocBuilder<SearchAgencyCubit, SearchAgencyState>(
                                                                    builder: (context, agencyState) {
                                                                      if (agencyState is SearchAgencyLoading) {
                                                                        return const Center(child: CircularProgressIndicator());
                                                                      } else
                                                                      if (agencyState is SearchAgencyLoaded) {
                                                                        if (agencyState.agencies.isEmpty) {
                                                                          return DropdownButton<
                                                                              String>(
                                                                            hint: const Padding(
                                                                              padding: EdgeInsets.only(left: 20),
                                                                              child: Text(
                                                                                "Seleziona agenzia",
                                                                                style: TextStyle(
                                                                                  color: black,
                                                                                  fontSize: 14,
                                                                                  fontWeight: FontWeight
                                                                                      .normal,
                                                                                ),
                                                                              ),
                                                                            ),

                                                                            isExpanded: true,
                                                                            underline: const SizedBox(),
                                                                            onChanged: (String? value) {

                                                                            },
                                                                            items: emptyList.map<
                                                                                DropdownMenuItem<String>>((String value) {
                                                                              return DropdownMenuItem<String>(
                                                                                value: value,
                                                                                child: Text(
                                                                                    value),
                                                                              );
                                                                            }).toList(),
                                                                          );
                                                                        }
                                                                        else {
                                                                          List<AgencyEntity> agencies = agencyState.agencies;
                                                                          if (state.selectedUser.agency == null && state.selectedUser.status == UserStatus.agency) {
                                                                            widget.agencyChange(agencyState.selectedAgency!);
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
                                                                            value: state.selectedUser.agency ?? agencyState.selectedAgency,
                                                                            onChanged: (AgencyEntity? value) {
                                                                              _searchAgencyCubit.changeSelectedAgency(value);
                                                                              if (value != null) {
                                                                                widget.agencyChange(value);
                                                                              }
                                                                            },
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
                                                                      else
                                                                        return ErrorWidget("errore di connessione");
                                                                      //TODO aggiungere errore
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
                                                  action: (){
                                                    widget.onTap(stateCity.selectedCity);
                                                  },
                                                  text: getCurrentLanguageValue(SAVE)!,
                                                ),
                                              )
                                            ],
                                          )),
                                    )
                                  ],
                                ),
                              )
                            ]
                        )
                    );
                  }
                  else
                    return ErrorWidget("exception2");
                });
          }
          else
            return ErrorWidget("exception");
        } );
  }
}

