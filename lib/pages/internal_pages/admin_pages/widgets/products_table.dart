import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/blocs/CurrentPageCubit.dart';
import 'package:ripapp_dashboard/blocs/profile_image_cubit.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/models/product_entity.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/utils/style_utils.dart';
import 'package:ripapp_dashboard/widgets/data_cell_image.dart';
import 'package:ripapp_dashboard/widgets/scaffold.dart';
import 'package:ripapp_dashboard/widgets/texts.dart';
import 'package:ripapp_dashboard/widgets/tooltip_widget.dart';
import 'package:ripapp_dashboard/widgets/utilities/network_memory_image_utility.dart';

import '../../../../constants/images_constants.dart';

class ProductsTable extends StatefulWidget {
  final edit;
  final delete;
  final showDetail;
  final String detailMessage;
  final String editMessage;
  final String deleteMessage;

  ProductsTable(
      {required this.delete,
        required this.edit,
        required this.showDetail,
        required this.detailMessage,
        required this.editMessage,
        required this.deleteMessage});

  @override
  State<StatefulWidget> createState() => ProductsTableState(
    delete: delete,
    edit: edit,
    showDetail: showDetail,
    detailMessage: detailMessage,
    editMessage: editMessage,
    deleteMessage: deleteMessage,
  );
}

class ProductsTableState extends State<ProductsTable> {
  final edit;
  final delete;
  final showDetail;
  final String detailMessage;
  final String editMessage;
  final String deleteMessage;

  ProductsTableState({
    required this.delete,
    required this.edit,
    required this.showDetail,
    required this.detailMessage,
    required this.editMessage,
    required this.deleteMessage
  });


  List<String> headerTitle = ['ID', 'Foto', 'Nome', 'Prezzo', ''];
  List<ProductEntity> products = [];
  CurrentPageCubit get _currentPageCubit => context.read<CurrentPageCubit>();


  @override
  void initState() {
    _currentPageCubit.loadPage(ScaffoldWidgetState.products_page, _currentPageCubit.state.pageNumber);
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
          }
          else {
            products = state.resultSet as List<ProductEntity>;

            if (products.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Texth2V2(
                      testo: 'Nessun prodotto inserito',
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
                  dataRowHeight: 85,
                  dataRowColor: MaterialStateColor.resolveWith((states) => white),
                  headingRowColor:
                  MaterialStateColor.resolveWith((states) => background),
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
              );}
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
            )),
      ));
    }
    return res;
  }

  List<DataRow> createRows() {
    List<DataRow> res = [];
    for (var i = 0; i < products.length; i++) {
      var p = products[i];
      res.add(composeSingleRow(p));
    }
    return res;
  }

  DataRow composeSingleRow(dynamic p) {
    print("LA SINGOLA ROW");
    print(p);
    return DataRow(
      cells: <DataCell>[
        DataCell(Text(
          p.id.toString(),
          style: SafeGoogleFont('Montserrat',
              color: black, fontSize: 12, fontWeight: FontWeight.w700),
        )),

        DataCell(
            DataCellImage(firebaseId: p.firebaseId)
        ),

        DataCell(Text(
          p.name,
          style: SafeGoogleFont('Montserrat',
              color: black, fontSize: 12, fontWeight: FontWeight.w700),
        )),
        DataCell(Text(
          '€ ${p.price}',
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
                  onTap: (){showDetail(p);},
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
              child: TooltipWidget(
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
                        )
                    )
                ),
              ),
            ),
          ],
        )),
      ],
    );
  }
}
