import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/models/CityEntity.dart';
import 'package:ripapp_dashboard/models/UserStatusEnum.dart';
import 'package:ripapp_dashboard/models/user_entity.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/utils/style_utils.dart';
import 'package:ripapp_dashboard/widgets/texts.dart';
import 'package:ripapp_dashboard/widgets/tooltip_widget.dart';

class UsersTable extends StatelessWidget{

  List<String> headerTitle = [
    'ID',
    'Nome',
    'Cognome',
    'Email',
    'Città',
    'Telefono',
    'Ruolo',
    ''
  ];

  List<UserEntity> users = [
    UserEntity(
      id: '1',
      firstName: 'Davide',
      lastName: 'Rossi',
      email: 'daviderossi@gmail.com',
        city: [CityEntity.defaultCity()],
      phoneNumber: '+39 0987654321',
        idtoken: '',
        status: UserStatus.disabled,
        role: 'Amministratore'
    ),
    UserEntity(
      id: '2',
        firstName: 'Davide',
        lastName: 'Rossi',
        email: 'daviderossi@gmail.com',
        city: [CityEntity.defaultCity()],
        phoneNumber: '+39 0987654321',
        idtoken: '',
        status: UserStatus.disabled,
        role: 'Agenzia'

    ),
    UserEntity(
      id: '3',
        firstName: 'Davide',
        lastName: 'Rossi',
        email: 'daviderossi@gmail.com',
        city: [CityEntity.defaultCity()],
        phoneNumber: '+39 0987654321',
        idtoken: '',
        status: UserStatus.disabled,
        role: 'Utente'

    ),
    UserEntity(
      id: '4',
        firstName: 'Davide',
        lastName: 'Rossi',
        email: 'daviderossi@gmail.com',
        city: [CityEntity.defaultCity()],
        phoneNumber: '+39 0987654321',
        idtoken: '',
        status: UserStatus.disabled,
        role: 'Amministratore'

    ),
    UserEntity(
      id: '5',
        firstName: 'Davide',
        lastName: 'Rossi',
        email: 'daviderossi@gmail.com',
        city: [CityEntity.defaultCity()],
        phoneNumber: '+39 0987654321',
        idtoken: '',
        status: UserStatus.disabled,
        role: 'Amministratore'

    ),
  ];

  final edit;
  final delete;
  final showDetail;
 // final onSort;
 // final sortColumnIndex;
  final String detailMessage;
  final String editMessage;
  final String deleteMessage;


  UsersTable({
    required this.delete,
    required this.edit,
    required this.showDetail,
    required this.detailMessage,
    required this.editMessage,
    required this.deleteMessage,
   // required this.onSort,
   // required this.sortColumnIndex
  });


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
          bottom:BorderSide(width: 0.5, color: greyState),
          left:BorderSide(width: 0.5, color: greyState),
          right:BorderSide(width: 0.5, color: greyState),
          horizontalInside:BorderSide(width: 0.5, color: greyState),
        ),
        columns: createHeaderTable(),
        rows: createRows(),
     //   sortColumnIndex: sortColumnIndex,
      ),
    );
  }




  List<DataColumn> createHeaderTable() {
    List<DataColumn> res = [];
    for (var i = 0; i < headerTitle.length; i++) {
      res.add(DataColumn(
      //  onSort: onSort,
        label: Expanded(
            child: Texth4V2(
                testo: headerTitle[i],
                color: white,
                 weight: FontWeight.bold,
            )
        ),
      ));
    }
    return res;
  }

  List<DataRow> createRows() {
    List<DataRow> res = [];
    for (var i = 0; i < users.length; i++) {
      var p = users[i];
      res.add(composeSingleRow(p));
    }
    return res;
  }

  DataRow composeSingleRow(dynamic p) {
    return DataRow(
      cells: <DataCell>[
        DataCell(Text(p.id,
          style: SafeGoogleFont('Montserrat',
              color: black, fontSize: 12, fontWeight: FontWeight.w700),
        )),
        DataCell(Text(
          p.firstName,
          style: SafeGoogleFont('Montserrat',
              color: black, fontSize: 12, fontWeight: FontWeight.w700),
        )),
        DataCell(Text(
          p.lastName,
          style: SafeGoogleFont('Montserrat',
              color: black, fontSize: 12, fontWeight: FontWeight.w700),
        )),
        DataCell(Text(
          p.email,
          style: SafeGoogleFont('Montserrat',
              color: black, fontSize: 12, fontWeight: FontWeight.w700),
        )),
        DataCell(Text(
          p.city.toString(),
          style: SafeGoogleFont('Montserrat',
              color: black, fontSize: 12, fontWeight: FontWeight.w700),
        )),
        DataCell(Text(
          p.phoneNumber,
          style: SafeGoogleFont('Montserrat',
              color: black, fontSize: 12, fontWeight: FontWeight.w700),
        )),
        DataCell(Text(
          p.role,
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
              child:TooltipWidget(
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