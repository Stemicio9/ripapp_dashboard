import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/blocs/CurrentPageCubit.dart';
import 'package:ripapp_dashboard/blocs/search_demises_cubit.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/models/CityEntity.dart';
import 'package:ripapp_dashboard/models/DemisesSearchEntity.dart';
import 'package:ripapp_dashboard/models/demise_entity.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/utils/style_utils.dart';
import 'package:ripapp_dashboard/widgets/scaffold.dart';
import 'package:ripapp_dashboard/widgets/texts.dart';
import 'package:ripapp_dashboard/widgets/tooltip_widget.dart';

class DemiseTable extends StatefulWidget {
  const DemiseTable({required this.delete, required this.edit, required this.showDetail, required this.detailMessage, required this.editMessage,required this.deleteMessage});
  final edit;
  final delete;
  final showDetail;
  final String detailMessage;
  final String editMessage;
  final String deleteMessage;

  @override
  State<StatefulWidget> createState() => DemiseTableState(
    edit: this.edit,
    delete: this.delete,
    showDetail: this.showDetail,
    detailMessage: this.detailMessage,
    editMessage: this.editMessage,
    deleteMessage: this.deleteMessage,
  );

}


class DemiseTableState extends State<DemiseTable>{
  //DemiseCubit get _searchDemiseCubit => context.read<DemiseCubit>();
  CurrentPageCubit  get _currentPageCubit => context.read<CurrentPageCubit>();

  @override
  void initState() {
    //_searchDemiseCubit.fetchDemises(cities: [], sorting: SearchSorting.name, offset: 0);
    _currentPageCubit.loadPage(ScaffoldWidgetState.agency_demises_page, _currentPageCubit.state.pageNumber);
    super.initState();
  }

  List<String> headerTitle = [
    'ID',
    'Nome',
    'Cognome',
    'Città',
    'Telefono',
    'Indirizzo Chiesa',
    'Indirizzo Veglia',
    ''
  ];

  List<DemiseEntity> demises = [];


  final edit;
  final delete;
  final showDetail;
  final String detailMessage;
  final String editMessage;
  final String deleteMessage;


  DemiseTableState({required this.delete, required this.edit, required this.showDetail, required this.detailMessage, required this.editMessage,required this.deleteMessage});


  @override
  Widget build(BuildContext context) {
    return
      BlocBuilder<CurrentPageCubit, CurrentPageState>(
          builder: (context, state) {
            print("COSTRUISCO LO STATO");
            print(state.runtimeType.toString());
            if (state.loading) {
              return const Center(
                  child: CircularProgressIndicator()
              );
            }
            else {
              demises = state.resultSet as List<DemiseEntity>;

              if(demises.isEmpty){
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Texth2V2(
                        testo: 'Nessun decesso inserito',
                        weight: FontWeight.bold,
                        color: background
                    ),
                  ),
                );
              }else{
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
            }
  });
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
            )
        ),
      ));
    }
    return res;
  }

  List<DataRow> createRows() {
    List<DataRow> res = [];
    for (var i = 0; i < demises.length; i++) {
      var p = demises[i];
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
          p.city.name,
          style: SafeGoogleFont('Montserrat',
              color: black, fontSize: 12, fontWeight: FontWeight.w700),
        )),
        DataCell(Text(
          p.phoneNumber,
          style: SafeGoogleFont('Montserrat',
              color: black, fontSize: 12, fontWeight: FontWeight.w700),
        )),
        DataCell(Text(
          p.wakeAddress,
          style: SafeGoogleFont('Montserrat',
              color: black, fontSize: 12, fontWeight: FontWeight.w700),
        )),
        DataCell(Text(
          p.funeralAddress,
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
                  onTap:  (){showDetail(p);},
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
                    onTap: (){edit(p);},
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
                    onTap: (){delete(p);},
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