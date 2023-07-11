

import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget/action.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget/action_widget_list.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget/internal_table_widget.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget/table_row_element.dart';

class DataTableWidget extends StatelessWidget {


  final List<String> headers;
  final List<TableRowElement> rows;
  final List<ActionDefinition> superiorActions;
  final List<ActionDefinition> rowActions;
  final double dataRowHeight;



  const DataTableWidget({Key? key, required this.headers,
    required this.rows, required this.superiorActions,
    required this.rowActions, this.dataRowHeight = 48}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ActionWidgetList(actions: superiorActions),
        InternalTableWidget(headers: headers, rows: rows, rowActions: rowActions,dataRowHeight: dataRowHeight,)
      ],
    );
  }
}

