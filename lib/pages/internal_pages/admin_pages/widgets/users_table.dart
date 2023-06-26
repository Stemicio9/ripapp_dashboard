import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/blocs/CurrentPageCubit.dart';
import 'package:ripapp_dashboard/blocs/current_user_cubit.dart';
import 'package:ripapp_dashboard/blocs/users_list_cubit.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/models/user_entity.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/utils/style_utils.dart';
import 'package:ripapp_dashboard/widgets/scaffold.dart';
import 'package:ripapp_dashboard/widgets/texts.dart';
import 'package:ripapp_dashboard/widgets/tooltip_widget.dart';

class UsersTable extends StatefulWidget{
  List<String> headerTitle = [
    'ID',
    'Nome',
    'Cognome',
    'Email',
    'Città',
    'Telefono',
    'Ruolo',
    'Nome Agenzia',
    ''
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
  State<StatefulWidget> createState() {
    return UsersTableState();
  }
}



class UsersTableState extends State<UsersTable>{
  UsersListCubit get _userListCubit => context.read<UsersListCubit>();
  CurrentPageCubit get _currentPageCubit => context.read<CurrentPageCubit>();

  List<UserEntity> usersList = [];
  @override
  void initState() {
    //_userListCubit.fetchUsersListWithIndex(0);
    //_currentPageCubit.loadPage(ScaffoldWidgetState.users_page, 0);
    _currentPageCubit.loadPage(ScaffoldWidgetState.users_page, _currentPageCubit.state.pageNumber);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentPageCubit, CurrentPageState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(
                child: CircularProgressIndicator()
            );
          } else {
            usersList = state.resultSet as List<UserEntity>;
            if (usersList.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Texth2V2(
                      testo: 'Nessun utente inserito',
                      weight: FontWeight.bold,
                      color: background
                  ),
                ),
              );
            }
            else {
              return Container(
                padding: getPadding(top: 20),
                width: MediaQuery.of(context).size.width,
                child: DataTable(
                  columnSpacing: 30,
                  dataRowColor: MaterialStateColor.resolveWith((states) => white),
                  headingRowColor: MaterialStateColor.resolveWith((
                      states) => background),
                  border: const TableBorder(
                    top: BorderSide(width: 0.5, color: greyState),
                    bottom: BorderSide(width: 0.5, color: greyState),
                    left: BorderSide(width: 0.5, color: greyState),
                    right: BorderSide(width: 0.5, color: greyState),
                    horizontalInside: BorderSide(width: 0.5, color: greyState),
                  ),
                  columns: createHeaderTable(),
                  rows: createRows(usersList),
                  //   sortColumnIndex: sortColumnIndex,
                ),
              );
            }
          }
        });
  }




  List<DataColumn> createHeaderTable() {
    List<DataColumn> res = [];
    for (var i = 0; i <widget.headerTitle.length; i++) {
      res.add(DataColumn(
      //  onSort: onSort,
        label: Expanded(
            child: Texth4V2(
              testo: widget.headerTitle[i],
              color: white,
              weight: FontWeight.bold,
            )
        ),
      ));
    }
    return res;
  }

  List<DataRow> createRows(usersList) {
    List<DataRow> res = [];
    for (var i = 0; i < usersList.length; i++) {
      var p = usersList[i];
      res.add(composeSingleRow(p));
    }
    return res;
  }

  DataRow composeSingleRow(dynamic p) {
    return DataRow(
      cells: <DataCell>[
        DataCell(Text(p.id.toString(),
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
          p.status.toString() == 'UserStatus.active' ? 'Utente' :
          p.status.toString() == 'UserStatus.agency' ? 'Agenzia' :
          'Amministratore',
          style: SafeGoogleFont('Montserrat',
              color: black, fontSize: 12, fontWeight: FontWeight.w700),
        )),

        DataCell(Row(
          children: [
            Visibility(
              visible:  p.status.toString() == 'UserStatus.agency',
              child: Text(
                p.status.toString() == 'UserStatus.agency' ? p.agency.agencyName : '',
                style: SafeGoogleFont('Montserrat',
                    color: black, fontSize: 12, fontWeight: FontWeight.w700),
              ),
            ),

            Visibility(
              visible: p.status.toString() != 'UserStatus.agency',
                child: Icon(Icons.cancel_rounded, color: rossoopaco,)
            )
          ],
        )),

        DataCell(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TooltipWidget(
              message: widget.detailMessage,
              direction: AxisDirection.down,
              child: GestureDetector(
                  onTap:  (){widget.showDetail(p);},
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
                message: widget.editMessage,
                direction: AxisDirection.down,
                child: GestureDetector(
                    onTap: (){
                      widget.edit(p);
                      },
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
                message: widget.deleteMessage,
                direction: AxisDirection.down,
                child: GestureDetector(
                    onTap: (){
                      widget.delete(p);
                      },
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