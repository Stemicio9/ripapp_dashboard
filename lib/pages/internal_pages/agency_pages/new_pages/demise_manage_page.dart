import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ripapp_dashboard/blocs/CurrentPageCubit.dart';
import 'package:ripapp_dashboard/blocs/search_demises_cubit.dart';
import 'package:ripapp_dashboard/blocs/selected_demise_cubit.dart';
import 'package:ripapp_dashboard/constants/app_pages.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget/action.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget/empty_table_content.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget/table_row_element.dart';
import 'package:ripapp_dashboard/models/demise_entity.dart';
import 'package:ripapp_dashboard/pages/internal_pages/page_header.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/widgets/circular_progress_indicator.dart';
import 'package:ripapp_dashboard/widgets/delete_message_dialog.dart';
import 'package:ripapp_dashboard/widgets/scaffold.dart';
import 'package:ripapp_dashboard/widgets/snackbars.dart';
import 'package:ripapp_dashboard/widgets/utilities/firebase_image_utility.dart';

class DemiseManagePage extends StatefulWidget {
  const DemiseManagePage({Key? key}) : super(key: key);

  @override
  State<DemiseManagePage> createState() => _DemiseManagePageState();
}

class _DemiseManagePageState extends State<DemiseManagePage> {

  CurrentPageCubit get _searchDemiseCubit => context.read<CurrentPageCubit>();
  SelectedDemiseCubit get _selectedDemiseCubit => context.read<SelectedDemiseCubit>();
  DemiseCubit get _demiseCubit => context.read<DemiseCubit>();

  @override
  void initState() {
    _searchDemiseCubit.loadPage(ScaffoldWidgetState.agency_demises_page, 0);
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
            emptyMessage: 'Nessun decesso inserito',
            showBackButton: false,
            actions: composeSuperiorActions(),
            pageTitle: 'Decessi inseriti',
        );
      }
      return Padding(
        padding: getPadding(top: 30, bottom: 30, left: 5, right: 5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const PageHeader(
                showBackButton: false,
                pageTitle: "Decessi inseriti",
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
      text: "Aggiungi decesso",
      isButton: true,
      action: () {
        context.push(AppPage.addDemise.path);
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
        action: (DemiseEntity demiseEntity){
          print("ecco il demise selezionato" + demiseEntity.toString());
          _selectedDemiseCubit.selectDemise(demiseEntity);
          context.push(AppPage.editDemise.path);
        },
        icon: Icons.edit_rounded,
        tooltip: "Modifica",
        actionInputs: List.empty(growable: true)
    );
    return result;
  }

  ActionDefinition deleteAction(){
    ActionDefinition result = ActionDefinition(
        action: (DemiseEntity demiseEntity){
          showDialog(
              context: context,
              builder: (_) => DeleteMessageDialog(
                onConfirm: (){
                  _demiseCubit.delete(demiseEntity.id);
                  FirebaseImageUtility.deleteAllImages(demiseEntity.firebaseid);
                  SuccessSnackbar(context, text: 'Defunto eliminato con successo!');
                  context.pop();
                },
                onCancel: () {context.pop();},
                message: 'Le informazioni riguardanti questo decesso '
                    'verranno eliminate. Sei sicuro di volerle eliminare?',
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
        action: (DemiseEntity demiseEntity){
          print("HO PREMUTO SU VIEWACTION");
          print(demiseEntity.firstName);
          _selectedDemiseCubit.selectDemise(demiseEntity);
          context.push(AppPage.demiseDetail.path);
        },
        icon: Icons.remove_red_eye_rounded,
        tooltip: "Dettaglio",
        actionInputs: List.empty(growable: true)
    );
    return result;
  }
}
