import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/blocs/city_list_cubit.dart';
import 'package:ripapp_dashboard/blocs/searchAgenciesCubit.dart';
import 'package:ripapp_dashboard/blocs/selected_agency_cubit.dart';
import 'package:ripapp_dashboard/blocs/selected_user_cubit.dart';
import 'package:ripapp_dashboard/constants/images_constants.dart';
import 'package:ripapp_dashboard/models/UserStatusEnum.dart';
import 'package:ripapp_dashboard/models/agency_entity.dart';
import 'package:ripapp_dashboard/models/user_entity.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/users_manage.dart';
import 'package:ripapp_dashboard/models/city_from_API.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/users_manage/user_form_inputs.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/widgets/dialog_card.dart';
import '../../../../blocs/selected_city_cubit.dart';

class UsersForm extends StatelessWidget {
  final String cardTitle;
  late TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController lastNameController;
  final TextEditingController filterController;
  final TextEditingController passwordController;
  final List<CityFromAPI> options;
  final onTap;
  Function(String selectedValue) statusChange;
  final Function(AgencyEntity selectedAgency) agencyChange;
  late List<UserRoles> roles;
  final bool isAddPage;

  UsersForm(
      {super.key,
        required this.onTap,
        required this.cardTitle,
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
        this.isAddPage = true});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => SelectedAgencyCubit(),
        child: UsersFormWidget(
            onTap: onTap,
            isAddPage: isAddPage,
            cardTitle: cardTitle,
            nameController: nameController,
            emailController: emailController,
            filterController: filterController,
            phoneController: phoneController,
            passwordController: passwordController,
            lastNameController: lastNameController,
            statusChange: statusChange,
            agencyChange: agencyChange,
            roles: roles,
            options: options)
    );
  }
}

class UsersFormWidget extends StatefulWidget {
  final String cardTitle;
  late TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController lastNameController;
  final TextEditingController filterController;
  final TextEditingController passwordController;
  final List<CityFromAPI> options;
  final onTap;
  late final Function(String selectedValue) statusChange;
  final Function(AgencyEntity selectedAgency) agencyChange;
  late List<UserRoles> roles;
  final bool isAddPage;

  UsersFormWidget(
      {super.key,
      required this.onTap,
      required this.cardTitle,
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
      this.isAddPage = true});

  @override
  State<StatefulWidget> createState() {
    return UsersFormState();
  }
}

class UsersFormState extends State<UsersFormWidget> {
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
            if (widget.isAddPage) {
              widget.nameController.text = "";
              widget.phoneController.text = "";
              widget.lastNameController.text = "";
            } else {
              widget.nameController.text = state.selectedUser.firstName ?? widget.nameController.text;
              widget.lastNameController.text = state.selectedUser.lastName ?? widget.lastNameController.text;
              widget.phoneController.text = state.selectedUser.phoneNumber ?? widget.phoneController.text;
            }
            if (state.selectedUser.status == null) {
              widget.statusChange(UserRoles.Utente.name);
            }
            return BlocBuilder<SearchAgencyCubit, SearchAgencyState>(
                builder: (context, agencyState) {
              if (agencyState is SearchAgencyLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (agencyState is SearchAgencyLoaded) {
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
                                        child: BlocBuilder<CityListCubit, CityListState>(
                                            builder: (context, cityState) {
                                          if (cityState is CityListLoading) {
                                            return const Center(child: CircularProgressIndicator());
                                          } else if (cityState
                                              is CityListLoaded) {
                                            cityList = cityState.listCity;
                                            return UserFormInputs(
                                              emptyFields: (){
                                                widget.nameController.text = "";
                                                widget.lastNameController.text = "";
                                                widget.phoneController.text = "";
                                                widget.emailController.text = "";
                                                widget.passwordController.text = "";

                                              },
                                              nameController: widget.nameController,
                                              lastNameController: widget.lastNameController,
                                              emailController: widget.emailController,
                                              passwordController: widget.passwordController,
                                              cityController: widget.filterController,
                                              phoneController: widget.phoneController,
                                              action: () {
                                                widget.onTap(stateCity.selectedCity);
                                              },
                                              isAddPage: widget.isAddPage,
                                              iconOnTap: () {
                                                setState(() {
                                                  _passwordVisible = !_passwordVisible;
                                                });
                                              },
                                              isPassword: !_passwordVisible,
                                              suffixIcon: _passwordVisible ? ImagesConstants.imgPassSee : ImagesConstants.imgPassUnsee,
                                              cityList: cityList,
                                              roles: widget.roles,
                                              selectedAgency: agencyState.selectedAgency,
                                              statusChange: (UserRoles? value) {
                                                _selectedUserCubit.selectUser(state.selectedUser.copyWith(status: fromUserRole(value ?? UserRoles.Utente)));
                                                widget.statusChange(value?.name ?? "");
                                              },
                                              agencyChange: (AgencyEntity? value) {
                                                _searchAgencyCubit.changeSelectedAgency(value);
                                                if (value != null) {
                                                  widget.agencyChange(value);
                                                }
                                              },
                                              selectedUser: state.selectedUser,
                                              agencies: agencyState.agencies,
                                            );
                                          } else {
                                            return ErrorWidget("exception");
                                          }
                                        })))
                              ],
                            ),
                          )
                        ]));
              } else {
                return ErrorWidget("exception");
              }
            });
          } else {
            return ErrorWidget("exception");
          }
        });
      } else {
        return ErrorWidget("exception2");
      }
    });
  }
}
