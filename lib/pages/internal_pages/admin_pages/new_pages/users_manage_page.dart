import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ripapp_dashboard/blocs/CurrentPageCubit.dart';
import 'package:ripapp_dashboard/blocs/selected_city_cubit.dart';
import 'package:ripapp_dashboard/blocs/selected_user_cubit.dart';
import 'package:ripapp_dashboard/blocs/users_list_cubit.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/data_table/data_table_paginator/data_table_paginator_data.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget/action.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget/empty_table_content.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget/table_row_element.dart';
import 'package:ripapp_dashboard/models/agency_entity.dart';
import 'package:ripapp_dashboard/models/city_from_API.dart';
import 'package:ripapp_dashboard/models/user_entity.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/new_pages/user_form/user_form_popup.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/users_manage/users_detail.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/users_manage/users_form.dart';
import 'package:ripapp_dashboard/pages/internal_pages/page_header.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/widgets/circular_progress_indicator.dart';
import 'package:ripapp_dashboard/widgets/delete_message_dialog.dart';
import 'package:ripapp_dashboard/widgets/dialog_card.dart';
import 'package:ripapp_dashboard/widgets/scaffold.dart';
import 'package:ripapp_dashboard/models/UserStatusEnum.dart';
import 'package:ripapp_dashboard/widgets/snackbars.dart';

enum UserRoles { Amministratore, Agenzia, Utente }

class UsersManagePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return UsersManagePageState();
  }
}

class UsersManagePageState extends State<UsersManagePage>{

  CurrentPageCubit get _currentPageCubit => context.read<CurrentPageCubit>();
  SelectedUserCubit get _selectedUserCubit => context.read<SelectedUserCubit>();
  UsersListCubit get _userListCubit => context.read<UsersListCubit>();
  SelectedCityCubit get _selectedCityCubit => context.read<SelectedCityCubit>();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController filterController = TextEditingController();

  List<CityFromAPI> cityOptions = [];
  UserEntity userEntity = UserEntity(
      id: 1,
      firstName: '',
      lastName: '',
      email: '',
      city: [CityFromAPI.defaultCity()],
      phoneNumber: '',
      role: '');

  setStatusFromDropdown(String userRole) {
    UserRoles role = UserRoles.values.firstWhere((e) => e.toString() == 'UserRoles.' + userRole);
    userEntity.role = role.toString();
    UserStatus status = fromUserRole(role);
    userEntity.status = status;
  }

  setAgencyFromDropdown(AgencyEntity agencyEntity) {
    userEntity.agency = agencyEntity;
  }

  void initState() {
    _currentPageCubit.loadPage(ScaffoldWidgetState.users_page, 0);
    super.initState();
  }






  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentPageCubit, CurrentPageState>
      (builder: (_,state) {
        print("APPENA EMESSO UNO STATO DI CURRENT PAGE, COSTRUISCO IL WIDGET");
        print(state.resultSet.length);
      if(state.loading){
        return const CircularProgressIndicatorWidget();
      }
      List<TableRowElement> tableRowElements = state.resultSet as List<TableRowElement>;
      if(tableRowElements.isEmpty){
        return EmptyTableContent(
          emptyMessage: 'Nessun utente inserito',
          showBackButton: false,
          actions: composeSuperiorActions(),
          pageTitle: 'Gestisci utenti',
        );
      }
      return Padding(
        padding: getPadding(top: 30, bottom: 30, left: 5, right: 5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const PageHeader(
                showBackButton: false,
                pageTitle: 'Gestisci utenti',
              ),
              DataTableWidget(
                  headers: tableRowElements[0].getHeaders(),
                  rows: tableRowElements,
                  superiorActions: composeSuperiorActions(),
                  rowActions: composeRowActions(),
                  data: DataTablePaginatorData(
                    changePageHandle: (index, page) {_currentPageCubit.loadPage(page, index);},
                    pageNumber: state.pageNumber,
                    numPages: state.totalPages,
                    currentPageType: ScaffoldWidgetState.users_page)
              ),
            ],
          ),
        ),
      );
    });
  }


  formSubmit(CityFromAPI? nome) {
    print("SONO NEL VERO METODO FORM SUBMIT");
    if (_formKey.currentState!.validate()) {
      userEntity.firstName = nameController.text;
      userEntity.lastName = lastNameController.text;
      userEntity.email = emailController.text;
      userEntity.phoneNumber = phoneController.text;
      userEntity.password = passwordController.text;
      userEntity.city = [nome!];

      if (userEntity.email != "" && userEntity.password != "") {
        FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: userEntity.email ?? "",
            password: userEntity.password ?? "")
            .then((value) async {
          if (value.user == null) {
            print("Utente nullo");
            return; //TODO: Handle error
          } else {
            userEntity.idtoken = value.user!.uid;
          }

          print("SALVO SU DB LOCALE");
          _currentPageCubit.signup(userEntity);
          nameController.text = "";
          lastNameController.text = "";
          passwordController.text = "";
          emailController.text = "";
          phoneController.text = "";

          SuccessSnackbar(context, text: 'Utente aggiunto con successo!');
          Navigator.pop(context);
        }, onError: (e) {
          print(e);
          ErrorSnackbar(context, text: 'L\'email inserita è già usata da un altro utente!');
        });
      }
    }
  }

  List<ActionDefinition> composeSuperiorActions(){
    var actions = <ActionDefinition>[];
    actions.add(ActionDefinition(
        text: "Aggiungi utente",
        isButton: true,
        action: () {
          showDialog(
              context: context,
              builder: (ctx) => composeDialog(UserEntity.emptyUser())
          );

               /*   Form(
                key: _formKey,
                child: UsersForm(
                  cardTitle: getCurrentLanguageValue(ADD_USER)!,
                  nameController: nameController,
                  emailController: emailController,
                  phoneController: phoneController,
                  filterController: filterController,
                  options: cityOptions,
                  lastNameController: lastNameController,
                  passwordController: passwordController,
                  statusChange: setStatusFromDropdown,
                  agencyChange: setAgencyFromDropdown,
                  onTap: formSubmit,
                  roles: UserRoles.values,
                ),
              )); */




        },
        actionInputs: List.empty(growable: true)
    ));
    return actions;
  }

  List<ActionDefinition> composeRowActions(){
    List<ActionDefinition> result = [];
    result.add(viewAction());
    result.add(editAction());
    result.add(deleteAction());
    return result;
  }

  extractCity(u) {
    var userEntity = u as UserEntity;
    if (u.city != null && u.city!.isNotEmpty) {
      return u.city![0];
    } else {
      return null;
    }
  }

  ActionDefinition editAction(){
    ActionDefinition result = ActionDefinition(
        action: (UserEntity userEntity){
          _selectedUserCubit.selectUser(userEntity);
          _selectedCityCubit.selectCity(extractCity(userEntity));
          showDialog(
              context: context,
              barrierColor: blackTransparent,
              builder: (ctx) => composeDialog(userEntity)
          );
        },
        icon: Icons.edit_rounded,
        tooltip: "Modifica",
        actionInputs: List.empty(growable: true)
    );
    return result;
  }

  // todo add here choice of function called (save or update)
  // todo add here something to notice that: password should be saved, email should be saved
  // todo add something to manage title into popup
  // todo popup style (change from popup various widgets)
  Widget composeDialog(UserEntity userEntity){
    return Form(
      child: Column(
        children: [
          SizedBox(
            width: 900,
            height: MediaQuery.of(context).size.height * 0.8,
            child: DialogCard(
                cardTitle: 'Modifica utente',
                cancelIcon: true,
                child:  UserFormPopup(
                  onWillPop: () { return Future.value(true); },
                  selectedUser: userEntity,
                  onSubmit: (UserEntity internalUserEntity){
                    _currentPageCubit.editUser(internalUserEntity);
                    context.pop();
                  },
                )
            ),

          ),
        ],
      ),
    );
  }

  ActionDefinition deleteAction(){
    ActionDefinition result = ActionDefinition(
        action: (UserEntity userEntity){
          showDialog(
              context: context,
              builder: (_) => DeleteMessageDialog(
                onConfirm: (){
                  _userListCubit.delete(userEntity.id);
                  SuccessSnackbar(context, text: 'Utente eliminato con successo!');
                  context.pop();
                },
                onCancel: () {context.pop();},
                message: 'Le informazioni riguardanti questo utente verranno eliminate. Sei sicuro di volerle eliminare?',
              )
          );
        },
        icon: Icons.delete_rounded,
        tooltip: "Elimina",
        actionInputs: List.empty(growable: true)
    );
    return result;
  }

  ActionDefinition viewAction(){
    ActionDefinition result = ActionDefinition(
        action: (UserEntity userEntity){
          _selectedUserCubit.selectUser(userEntity);
          showDialog(
              context: context,
              builder: (ctx) => UsersDetail(
                isAgency: userEntity.status.toString() == 'UserStatus.agency'
                    ? true
                    : false,
                cardTitle: getCurrentLanguageValue(USER_DETAIL)!,
              )
          );
        },
        icon: Icons.remove_red_eye_rounded,
        tooltip: "Dettaglio",
        actionInputs: List.empty(growable: true)
    );
    return result;
  }
}