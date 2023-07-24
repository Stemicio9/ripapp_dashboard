import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ripapp_dashboard/blocs/CurrentPageCubit.dart';
import 'package:ripapp_dashboard/blocs/searchAgenciesCubit.dart';
import 'package:ripapp_dashboard/blocs/selected_agency_cubit.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/constants/validators.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget/action.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget/empty_table_content.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget/table_row_element.dart';
import 'package:ripapp_dashboard/models/agency_entity.dart';
import 'package:ripapp_dashboard/models/city_from_API.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/agencies_manage/agency_detail.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/agencies_manage/agency_form.dart';
import 'package:ripapp_dashboard/pages/internal_pages/page_header.dart';
import 'package:ripapp_dashboard/repositories/agency_repository.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/widgets/circular_progress_indicator.dart';
import 'package:ripapp_dashboard/widgets/delete_message_dialog.dart';
import 'package:ripapp_dashboard/widgets/scaffold.dart';
import 'package:ripapp_dashboard/widgets/snackbars.dart';

class AgenciesManagePage extends StatefulWidget {
  const AgenciesManagePage({Key? key}) : super(key: key);

  @override
  State<AgenciesManagePage> createState() => _AgenciesManagePageState();
}

class _AgenciesManagePageState extends State<AgenciesManagePage> {

  CurrentPageCubit get _currentPageCubit => context.read<CurrentPageCubit>();
  SelectedAgencyCubit get _selectedAgencyCubit => context.read<SelectedAgencyCubit>();
  SearchAgencyCubit get _searchAgencyCubit => context.read<SearchAgencyCubit>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _editKey = GlobalKey<FormState>();
  List<CityFromAPI> cityList = [];

  @override
  void initState() {
    _currentPageCubit.loadPage(ScaffoldWidgetState.agencies_page, 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentPageCubit, CurrentPageState>
      (builder: (_,state) {
      if(state.loading){
        return const CircularProgressIndicatorWidget();
      }
      List<TableRowElement> tableRowElements = state.resultSet as List<TableRowElement>;
      if(tableRowElements.isEmpty){
        return EmptyTableContent(
          emptyMessage: 'Nessuna agenzia inserita',
          showBackButton: false,
          actions: composeSuperiorActions(),
          pageTitle: 'Gestisci agenzie',
        );
      }
      return Padding(
        padding: getPadding(top: 30, bottom: 30, left: 5, right: 5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const PageHeader(
                showBackButton: false,
                pageTitle: "Gestisci agenzie",
              ),
              DataTableWidget(
                  headers: tableRowElements[0].getHeaders(),
                  rows: tableRowElements,
                  superiorActions: composeSuperiorActions(),
                  rowActions: composeRowActions()),
            ],
          ),
        ),
      );
    });
  }

  List<ActionDefinition> composeSuperiorActions(){
    var actions = <ActionDefinition>[];
    actions.add(ActionDefinition(
        text: "Aggiungi agenzia",
        isButton: true,
        action: () async {
          showDialog(
              context: context,
              builder: (ctx) => Form(
                key: _formKey,
                child: AgencyForm(
                  emptyFields: (){
                    nameController.clear();
                    emailController.clear();
                    phoneController.clear();
                    cityController.clear();
                  },
                  cityOptions: cityList,
                  cardTitle: getCurrentLanguageValue(ADD_AGENCY)!,
                  nameController: nameController,
                  emailController: emailController,
                  phoneController: phoneController,
                  cityController: cityController,
                  nameValidator: notEmptyValidate,
                  emailValidator: validateEmail,
                  cityValidator: notEmptyValidate,
                  phoneValidator: notEmptyValidate,
                  onSubmit: () {
                    formSubmit();
                  },
                  isAddPage: true,
                ),
              ));
        },
        actionInputs: List.empty(growable: true)
    ));
    return actions;
  }

  formSubmit() {
    if (_formKey.currentState!.validate()) {
      AgencyEntity agencyEntity = AgencyEntity(
        agencyName: nameController.text,
        city: cityController.text,
        email: emailController.text,
        phoneNumber: phoneController.text,
      );
      saveOrEditAgency(agencyEntity, false);
      context.pop();
    }
  }

  saveOrEditAgency(AgencyEntity agencyEntity, bool isEdit) {
    if (isEdit) {
      AgencyRepository().editAgency(agencyEntity).then((savedAgency) {
        clearControllers();
        SuccessSnackbar(context, text: "Agenzia modificata con successo");
      }, onError: (e) {
        ErrorSnackbar(context,
            text: "Errore generico durante la modifica dell\'agenzia");
      });
    } else {
      AgencyRepository().saveAgency(agencyEntity).then((savedAgency) {
        clearControllers();
        SuccessSnackbar(context, text: "Agenzia salvata con successo");
      }, onError: (e) {
        if (e.toString().contains("Duplicate entry")) {
          ErrorSnackbar(context, text: 'Questa email è già in uso da un\'altra agenzia');
        }
      });
    }
  }

  clearControllers() {
    nameController.text = "";
    emailController.text = "";
    phoneController.text = "";
    cityController.text = "";
  }

  List<ActionDefinition> composeRowActions(){
    List<ActionDefinition> result = [];
    result.add(viewAction());
    result.add(editAction());
    result.add(deleteAction());
    return result;
  }

  ActionDefinition editAction(){
    ActionDefinition result = ActionDefinition(
        action: (AgencyEntity ae){
          _selectedAgencyCubit.selecAgency(ae);
          showDialog(
              context: context,
              builder: (ctx) => Form(
                key: _editKey,
                child: AgencyForm(
                  emptyFields: (){
                    nameController.text = "";
                    cityController.text = "";
                    phoneController.text = "";
                  },
                  onSubmit: () {
                    if (_editKey.currentState!.validate()) {
                      AgencyEntity agencyEntity = AgencyEntity(
                          id: ae.id,
                          agencyName: nameController.text,
                          city: cityController.text,
                          phoneNumber: phoneController.text
                      );
                      saveOrEditAgency(agencyEntity, true);
                      context.pop();
                    }
                  },
                  isAddPage: false,
                  cityOptions: cityList,
                  cardTitle: getCurrentLanguageValue(EDIT_AGENCY)!,
                  nameController: nameController,
                  emailController: emailController,
                  phoneController: phoneController,
                  cityController: cityController,
                  nameValidator: notEmptyValidate,
                  cityValidator: notEmptyValidate,
                  phoneValidator: notEmptyValidate,
                ),
              ));
          },
        icon: Icons.edit_rounded,
        tooltip: "Modifica",
        actionInputs: List.empty(growable: true)
    );
    return result;
  }

  ActionDefinition deleteAction(){
    ActionDefinition result = ActionDefinition(
        action: (AgencyEntity agencyEntity){
          showDialog(
              context: context,
              builder: (ctx) => DeleteMessageDialog(
                  onConfirm: () {
                    _searchAgencyCubit.remove(agencyEntity.id);
                    SuccessSnackbar(context, text: 'Agenzia eliminata con successo!');
                    context.pop();
                  },
                  onCancel: () {
                    context.pop();
                  },
                  message: 'Le informazioni riguardanti questa agenzia verranno eliminate. Verranno eliminati anche tutti gli utenti associati a questa agenzia. Sei sicuro di volerle eliminare?'));
        },
        icon: Icons.delete_rounded,
        tooltip: "Elimina",
        actionInputs: List.empty(growable: true)
    );
    return result;
  }

  ActionDefinition viewAction(){
    ActionDefinition result = ActionDefinition(
        action: (AgencyEntity agencyEntity){
          _selectedAgencyCubit.selecAgency(agencyEntity);
          showDialog(
              context: context,
              builder: (ctx) => AgencyDetail(
                cardTitle: getCurrentLanguageValue(AGENCY_DETAIL)!,
              ));
        },
        icon: Icons.remove_red_eye_rounded,
        tooltip: "Dettaglio",
        actionInputs: List.empty(growable: true)
    );
    return result;
  }
}
