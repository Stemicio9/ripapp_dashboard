

import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/kinships.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/add_demise/relative_row.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/add_demise/add_relative_button.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/add_demise/relative_list.dart';

class RelativesWidget extends StatelessWidget {

  final List<RelativeRowNew> relatives;
  final Function() addDemisePress;
  final Function(int index, Kinship kinship) onKinshipChange;
  final Function(int index, String value) inputValueChange;
  final Function(int index) deleteRow;
  final bool isDetail;

  const RelativesWidget({Key? key,
    required this.relatives, required this.addDemisePress,
    required this.onKinshipChange, required this.inputValueChange, required this.deleteRow,
    required this.isDetail
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(top: 30, right: 30,left: 30,bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AddRelativeButton(onPress: addDemisePress, isDetail: isDetail,),
            Center(child: RelativeList(relatives: relatives, kinshipChange: onKinshipChange, valueChange: inputValueChange, deleteRow: deleteRow,))
          ],
        ),
      ),
    );
  }
}
