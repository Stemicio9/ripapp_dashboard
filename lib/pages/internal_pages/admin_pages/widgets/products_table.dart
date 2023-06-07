import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/blocs/SearchProductCubit.dart';
import 'package:ripapp_dashboard/blocs/SearchProductsOfferedCubit.dart';
import 'package:ripapp_dashboard/blocs/search_users_cubit.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/models/product_entity.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/utils/style_utils.dart';
import 'package:ripapp_dashboard/widgets/texts.dart';
import 'package:ripapp_dashboard/widgets/tooltip_widget.dart';

class ProductsTable extends StatefulWidget{

  final edit;
  final delete;
  final showDetail;
  final String detailMessage;
  final String editMessage;
  final String deleteMessage;


  ProductsTable({required this.delete, required this.edit, required this.showDetail, required this.detailMessage, required this.editMessage,required this.deleteMessage});

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

class ProductsTableState extends State<ProductsTable>{

  List<String> headerTitle = [
    'ID',
    'Nome',
    'Prezzo',
    'Foto',
    ''
  ];

  List<ProductEntity> products = [];
  /*
    ProductEntity(
      id: 1,
      name: 'Nome prodotto',
      price: 50,
      photoName: 'nome_prodotto.png',
    ),
    ProductEntity(
      id: 2,
      name: 'Nome prodotto',
      price:  50,
      photoName:  'nome_prodotto.png',
    ),
    ProductEntity(
      id: 3,
      name: 'Nome prodotto',
      price:  50,
      photoName:  'nome_prodotto.png',
    ),
    ProductEntity(
      id: 4,
      name: 'Nome prodotto',
      price:  50,
      photoName:  'nome_prodotto.png',
    ),
    ProductEntity(
      id: 5,
      name: 'Nome prodotto',
      price:  50,
      photoName:  'nome_prodotto.png',
    ),
  ];*/

  SearchProductCubit get _searchProductsCubit => context.read<SearchProductCubit>();
  @override
  void initState() {
    _searchProductsCubit.fetchProducts();
    super.initState();
  }

  final edit;
  final delete;
  final showDetail;
  final String detailMessage;
  final String editMessage;
  final String deleteMessage;


  ProductsTableState({required this.delete, required this.edit, required this.showDetail, required this.detailMessage, required this.editMessage,required this.deleteMessage});


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchProductCubit, SearchProductState>(
        builder: (context, state)
            {
              if (state is SearchProductLoaded){
                products = state.products;
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
                  ),
                );
              }
              else {
                return ErrorWidget("exception");
              }
            }
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
            )
        ),
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
    return DataRow(
      cells: <DataCell>[
        DataCell(Text(p.id.toString(),
          style: SafeGoogleFont('Montserrat',
              color: black, fontSize: 12, fontWeight: FontWeight.w700),
        )),
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
        DataCell(Text(
          p.photoName,
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