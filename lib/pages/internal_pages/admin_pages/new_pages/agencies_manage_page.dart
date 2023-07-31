import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ripapp_dashboard/blocs/CurrentPageCubit.dart';
import 'package:ripapp_dashboard/blocs/searchAgenciesCubit.dart';
import 'package:ripapp_dashboard/blocs/selected_agency_cubit.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/data_table/data_table_paginator/data_table_paginator_data.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget/action.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget/empty_table_content.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget/table_row_element.dart';
import 'package:ripapp_dashboard/models/agency_entity.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/agencies_manage/agency_detail.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/new_pages/agency_form/agency_form_popup.dart';
import 'package:ripapp_dashboard/pages/internal_pages/page_header.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/widgets/circular_progress_indicator.dart';
import 'package:ripapp_dashboard/widgets/delete_message_dialog.dart';
import 'package:ripapp_dashboard/widgets/dialog_card.dart';
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
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

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
                  rowActions: composeRowActions(),
                  data: DataTablePaginatorData(
                      changePageHandle: (index, page) {_currentPageCubit.loadPage(page, index);},
                      pageNumber: state.pageNumber,
                      numPages: state.totalPages,
                      currentPageType: ScaffoldWidgetState.agencies_page)
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget composeDialog(AgencyEntity agencyEntity){
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: getPadding(left: 20, right: 20),
            width: 1000,
            child: DialogCard(
                cardTitle: agencyEntity.id == null ? getCurrentLanguageValue(ADD_AGENCY) ?? "" :
                getCurrentLanguageValue(EDIT_AGENCY) ?? "",
                cancelIcon: true,
                paddingLeft: 10,
                paddingRight: 10,
                child: AgencyFormPopup(
                  onWillPop: () {
                    return Future.value(true);
                  },
                  selectedAgency: agencyEntity,
                  onSubmit: (AgencyEntity internalAgencyEntity){
                    agencyEntity.id == null ? _currentPageCubit.addAgency(internalAgencyEntity) :
                    _currentPageCubit.editAgency(internalAgencyEntity);
                    context.pop();
                  },
                )
            ),

          ),
        ],
      ),
    );
  }

  List<ActionDefinition> composeSuperiorActions(){
    var actions = <ActionDefinition>[];
    actions.add(ActionDefinition(
        text: "Aggiungi agenzia",
        isButton: true,
        action:  () {
          showDialog(
              context: context,
              builder: (ctx) => composeDialog(AgencyEntity.emptyAgency())
          );
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

  ActionDefinition editAction(){
    ActionDefinition result = ActionDefinition(
        action: (AgencyEntity agencyEntity){
          showDialog(
              context: context,
              barrierColor: blackTransparent,
              builder: (ctx) => composeDialog(agencyEntity)
          );
        },
        icon: Icons.edit_rounded,
        tooltip: "Modifica",
        actionInputs: List.empty(growable: true)
    );
    return result;
  }

  extractCity(u) {
    var agencyEntity = u as AgencyEntity;
    if (u.city != null && u.city!.isNotEmpty) {
      return u.city![0];
    } else {
      return null;
    }
  }

  ActionDefinition deleteAction(){
    ActionDefinition result = ActionDefinition(
        action: (AgencyEntity agencyEntity){
          showDialog(
              context: context,
              builder: (ctx) => DeleteMessageDialog(
                  onConfirm: () {
                    _currentPageCubit.deleteAgency(agencyEntity.id);
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
