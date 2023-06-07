import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/models/agency_entity.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/utils/style_utils.dart';
import 'package:ripapp_dashboard/widgets/texts.dart';
import 'package:ripapp_dashboard/widgets/tooltip_widget.dart';

class AgenciesTable extends StatelessWidget {
  List<String> headerTitle = [
    'ID',
    'Nome',
    'Email',
    'Città',
    'Telefono',
    ''
  ];

  List<AgencyEntity> agencies = [
    AgencyEntity(
        id: 1,
        agencyName: 'Agenzia srl',
        email: 'agenzia@gmail.com',
        city: 'Roma',
        phoneNumber: '+39 0987654321'),
    AgencyEntity(
        id: 2,
        agencyName: 'Agenzia srl',
        email: 'agenzia@gmail.com',
        city: 'Roma',
        phoneNumber: '+39 0987654321'),
    AgencyEntity(
        id: 3,
        agencyName: 'Agenzia srl',
        email: 'agenzia@gmail.com',
        city: 'Roma',
        phoneNumber: '+39 0987654321'),
    AgencyEntity(
        id: 4,
        agencyName: 'Agenzia srl',
        email: 'agenzia@gmail.com',
        city: 'Roma',
        phoneNumber: '+39 0987654321'),
    AgencyEntity(
        id: 5,
        agencyName: 'Agenzia srl',
        email: 'agenzia@gmail.com',
        city: 'Roma',
        phoneNumber: '+39 0987654321'),
  ];

  final edit;
  final delete;
  final showDetail;
  final String detailMessage;
  final String editMessage;
  final String deleteMessage;

  AgenciesTable(
      {required this.delete,
      required this.edit,
      required this.showDetail,
      required this.detailMessage,
      required this.editMessage,
      required this.deleteMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: getPadding(top: 20),
      width: MediaQuery.of(context).size.width,
      child: DataTable(
        columnSpacing: 30,
        dataRowColor: MaterialStateColor.resolveWith((states) => white),
        headingRowColor: MaterialStateColor.resolveWith((states) => background),
        border: const TableBorder(
          top: BorderSide(width: 0.5, color: greyState),
          bottom: BorderSide(width: 0.5, color: greyState),
          left: BorderSide(width: 0.5, color: greyState),
          right: BorderSide(width: 0.5, color: greyState),
          horizontalInside: BorderSide(width: 0.5, color: greyState),
        ),
        columns: createHeaderTable(),
        rows: createRows(),
      ),
    );
  }

  List<DataColumn> createHeaderTable() {
    List<DataColumn> res = [];
    for (var i = 0; i < headerTitle.length; i++) {
      res.add(DataColumn(
        label: Expanded(
            child: Texth4V2(
          testo: headerTitle[i],
          color: white,
          weight: FontWeight.bold,
        )),
      ));
    }
    return res;
  }

  List<DataRow> createRows() {
    List<DataRow> res = [];
    for (var i = 0; i < agencies.length; i++) {
      var p = agencies[i];
      res.add(composeSingleRow(p));
    }
    return res;
  }

  DataRow composeSingleRow(dynamic p) {
    return DataRow(
      cells: <DataCell>[
        DataCell(Text(
          p.id.toString(),
          style: SafeGoogleFont('Montserrat',
              color: black, fontSize: 12, fontWeight: FontWeight.w700),
        )),
        DataCell(Text(
          p.agencyName,
          style: SafeGoogleFont('Montserrat',
              color: black, fontSize: 12, fontWeight: FontWeight.w700),
        )),
        DataCell(Text(
          p.email,
          style: SafeGoogleFont('Montserrat',
              color: black, fontSize: 12, fontWeight: FontWeight.w700),
        )),
        DataCell(Text(
          p.city,
          style: SafeGoogleFont('Montserrat',
              color: black, fontSize: 12, fontWeight: FontWeight.w700),
        )),
        DataCell(Text(
          p.phoneNumber,
          style: SafeGoogleFont('Montserrat',
              color: black, fontSize: 12, fontWeight: FontWeight.w700),
        )),
        DataCell(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TooltipWidget(
              message: detailMessage,
              direction: AxisDirection.down,
              child: GestureDetector(
                  onTap: showDetail,
                  child: const MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Icon(
                        Icons.remove_red_eye_rounded,
                        color: background,
                        size: 24,
                      ))),
            ),
            Padding(
              padding: getPadding(left: 4),
              child: TooltipWidget(
                message: editMessage,
                direction: AxisDirection.down,
                child: GestureDetector(
                    onTap: edit,
                    child: const MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Icon(
                          Icons.edit_rounded,
                          color: background,
                          size: 22,
                        ))),
              ),
            ),
            Padding(
              padding: getPadding(left: 4),
              child: TooltipWidget(
                message: deleteMessage,
                direction: AxisDirection.down,
                child: GestureDetector(
                    onTap: delete,
                    child: const MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Icon(
                          Icons.delete_rounded,
                          color: background,
                          size: 22,
                        ))),
              ),
            ),
          ],
        )),
      ],
    );
  }
}
