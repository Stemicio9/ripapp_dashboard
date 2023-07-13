

import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget/action.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget/action_widget.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget/table_row_element.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/utils/style_utils.dart';
import 'package:ripapp_dashboard/widgets/data_cell_image.dart';
import 'package:ripapp_dashboard/widgets/texts.dart';

class InternalTableWidget extends StatelessWidget {

  final List<String> headers;
  final List<TableRowElement> rows;
  final List<ActionDefinition> rowActions;
  final double dataRowHeight;

  const InternalTableWidget({Key? key,
    required this.headers, required this.rows, required this.rowActions, this.dataRowHeight = 48}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: getPadding(top: 20),
      width: MediaQuery.of(context).size.width,
      child: DataTable(
          columnSpacing: 30,
          dataRowHeight: dataRowHeight,
          dataRowColor: MaterialStateColor.resolveWith((states) => white),
          headingRowColor: MaterialStateColor.resolveWith((states) => background),
          border: const TableBorder(
            top: BorderSide(width: 0.5, color: greyState),
            bottom: BorderSide(width: 0.5, color: greyState),
            left: BorderSide(width: 0.5, color: greyState),
            right: BorderSide(width: 0.5, color: greyState),
            horizontalInside: BorderSide(width: 0.5, color: greyState),
          ),
          columns: headers.map((e) => composeDataColumn(e)).toList(),
          rows: rows.map((e) => composeDataRow(e)).toList()
      ),
    );
  }


  DataColumn composeDataColumn(String header){
    return DataColumn(
        label: Expanded(
            child: Texth4V2(testo: header, color: white, weight: FontWeight.bold
            )
        )
    );
  }

  DataRow composeDataRow(TableRowElement element){
    List<DataCell> elements = element.rowElements().map((e) => composeDataCell(e)).toList();
    elements.add(composeActionCell(element));
    return DataRow(
        cells: elements
    );
  }

  DataCell composeActionCell(TableRowElement element){
    List<ActionDefinition> actions = List.empty(growable: true);
    for(var currentAction in rowActions){
      ActionDefinition action = currentAction.copy();
      action.actionInputs = List.empty(growable: true)..add(element);
      actions.add(action);
    }
    List<Widget> widgets = actions.map((e) => Padding(
      padding: const EdgeInsets.only(left: 10),
      child: ActionWidget(action: e),
    )).toList();
    return DataCell(
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widgets,
      )
    );
  }

  DataCell composeDataCell(RowElement element){
    return DataCell(
        DataCellWidget(element: element)
    );
  }

}


class DataCellWidget extends StatelessWidget {

  final RowElement element;

  const DataCellWidget({Key? key, required this.element}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(element.isImage){
      return DataCellImage(
        fromFirebase: true,
        firebaseId: element.element,

      );
    } else if(element.isText){
      return Text(
        element.element,
        style: SafeGoogleFont('Montserrat',
            color: black,
            fontSize: 12,
            fontWeight: FontWeight.w700
        ),
      );
    } else if(element.isIcon){
      return Icon(element.iconData, color: element.color);
    } else {
      return Container();
    }
  }
}

