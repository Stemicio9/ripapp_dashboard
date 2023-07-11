
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ripapp_dashboard/blocs/CurrentPageCubit.dart';
import 'package:ripapp_dashboard/constants/app_pages.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget/action.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget/empty_table_content.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget/table_row_element.dart';
import 'package:ripapp_dashboard/pages/internal_pages/page_header.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/widgets/circular_progress_indicator.dart';
import 'package:ripapp_dashboard/widgets/scaffold.dart';

class DemiseManagePage extends StatefulWidget {
  const DemiseManagePage({Key? key}) : super(key: key);

  @override
  State<DemiseManagePage> createState() => _DemiseManagePageState();
}

class _DemiseManagePageState extends State<DemiseManagePage> {

  CurrentPageCubit get _searchDemiseCubit => context.read<CurrentPageCubit>();

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
          return const EmptyTableContent(text: 'Nessun decesso inserito');
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
                  rowActions: []),
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
      }
    ));
    return actions;
  }
}
