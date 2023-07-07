
import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/kinships.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/add_demise/RelativeRow.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/add_demise/relative_row_widget.dart';

class RelativeList extends StatelessWidget {

  final List<RelativeRowNew> relatives;
  final Function(int index, Kinship kinship) kinshipChange;
  final Function(int index, String value) valueChange;
  final Function(int index) deleteRow;

  const RelativeList({Key? key, required this.relatives,
    required this.kinshipChange, required this.valueChange, required this.deleteRow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...relatives.map((e) => RelativeRowWidget(relative: e, kinshipChange: kinshipChange, valueChange: valueChange, deleteRow: deleteRow,)).toList()
      ],
    );
  }
}
