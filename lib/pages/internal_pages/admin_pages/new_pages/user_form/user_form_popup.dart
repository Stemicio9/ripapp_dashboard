import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/blocs/city_list_cubit.dart';
import 'package:ripapp_dashboard/blocs/searchAgenciesCubit.dart';
import 'package:ripapp_dashboard/models/UserStatusEnum.dart';
import 'package:ripapp_dashboard/models/agency_entity.dart';
import 'package:ripapp_dashboard/models/city_from_API.dart';
import 'package:ripapp_dashboard/models/user_entity.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/new_pages/user_form/user_form_widget.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/new_pages/users_manage_page.dart';
import 'package:ripapp_dashboard/widgets/circular_progress_indicator.dart';

class UserFormPopup extends StatefulWidget {

  final Future<bool> Function() onWillPop;
  UserEntity? selectedUser;
  final Function onSubmit;

  UserFormPopup({Key? key,
    required this.onWillPop,
    this.selectedUser, required this.onSubmit}) : super(key: key);

  @override
  State<UserFormPopup> createState() => _UserFormPopupState();
}

class _UserFormPopupState extends State<UserFormPopup> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  UserRoles? selectedStatus;
  AgencyEntity? selectedAgency;

  CityListCubit get _cityListCubit => context.read<CityListCubit>();
  SearchAgencyCubit get _searchAgencyCubit => context.read<SearchAgencyCubit>();

  @override
  void initState() {
    if(_cityListCubit.state is! CityListLoaded) {
      _cityListCubit.fetchCityList();
    }
    _searchAgencyCubit.fetchAgencies();
    widget.selectedUser ??= UserEntity.emptyUser();
    selectedStatus = fromUserStatus(widget.selectedUser?.status ?? UserStatus.active);
    selectedAgency = widget.selectedUser?.agency;
    assignTextEditingControllerValues();
    super.initState();
  }

  assignTextEditingControllerValues(){
    nameController.text = widget.selectedUser?.firstName ?? '';
    lastNameController.text = widget.selectedUser?.lastName ?? '';
    emailController.text = widget.selectedUser?.email ?? '';
    passwordController.text = widget.selectedUser?.password ?? '';
    phoneController.text = widget.selectedUser?.phoneNumber ?? '';
  }

  void clearFields(){
    nameController.clear();
    lastNameController.clear();
    emailController.clear();
    passwordController.clear();
    phoneController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: widget.onWillPop,
      child: BlocBuilder<CityListCubit,CityListState>(
        builder: (context, cityListState) {
          // TODO Calcolare o no il loading delle cities?
          if(cityListState is CityListLoading) {
            return const CircularProgressIndicatorWidget();
          } else if(cityListState is CityListLoaded) {
            return BlocBuilder<SearchAgencyCubit,SearchAgencyState>(
              builder: (context, state) {
                List<AgencyEntity> agencies = [];
                if(state is SearchAgencyLoaded) {
                  agencies = state.agencies;
                }
                 return UserFormWidget(
                        nameController: nameController,
                        lastNameController: lastNameController,
                        emailController: emailController,
                        passwordController: passwordController,
                        phoneController: phoneController,
                        cityController: cityController,
                        options: cityListState.listCity,
                        onSelected: citySubmitted,
                        selectedAgency: selectedAgency,
                        agencies: agencies,
                        agencyChange: agencyChange,
                        // we can infer user is not null, we fill it in initState
                        selectedUser: widget.selectedUser!,
                        statusChange: statusChange,
                        selectedStatus: selectedStatus != null ? fromUserRole(selectedStatus!) : null,
                        save: save,
                        clearFields: clearFields,
                        chips: widget.selectedUser?.city ?? [],
                        onDeleted: deleteCity

                );
              }
            );
          } else {
            // TODO POI LO FA EGG
            return const Text("Error");
          }
        }
      ),
    );
  }

  statusChange(UserRoles? value){
    setState(() {
      selectedStatus = value ?? UserRoles.Utente;
    });
  }

  agencyChange(AgencyEntity? value){
    setState(() {
      selectedAgency = value ?? AgencyEntity.emptyAgency();
    });
  }

  citySubmitted(CityFromAPI? value){
    if(value == null) return;
    setState(() {
      print("INSERISCO CITTA");
      cityController.text = value.name ?? "";
      widget.selectedUser ??= UserEntity.emptyUser();
      widget.selectedUser?.city ??= [];
      widget.selectedUser?.city?.add(value);
    });
  }

  deleteCity(CityFromAPI? value){
    if(value == null) return;
    setState(() {
      widget.selectedUser?.city?.remove(value);
    });
  }


  void save(){
    // todo    compose entire user object to submit on saving
    // todo    you should call save(userObject)
    // todo    be careful, you should compose the user object
    // todo    according to edit controllers
    if(widget.selectedUser == null) return;
    var currentStatus = fromUserRole(selectedStatus ?? UserRoles.Utente);
    UserEntity userToSave = widget.selectedUser!.copyWith(
        firstName: nameController.text,
        lastName:  lastNameController.text,
        phoneNumber: phoneController.text,
        // fixme be careful to city, is a list of city of interest by user
        city: widget.selectedUser?.city ?? [],
        agency: currentStatus == UserStatus.agency ? selectedAgency : null,
        status: currentStatus
    );
    widget.onSubmit(userToSave);
  }
}
