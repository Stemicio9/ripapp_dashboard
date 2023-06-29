import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/blocs/SearchProductsOfferedCubit.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/images_constants.dart';
import 'package:ripapp_dashboard/models/product_entity.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/utils/style_utils.dart';
import 'package:ripapp_dashboard/widgets/data_cell_image.dart';
import 'package:ripapp_dashboard/widgets/texts.dart';

class AgencyProductsTable extends StatefulWidget {

  const AgencyProductsTable({super.key});

  @override
  State<StatefulWidget> createState() => AgencyProductsTableState();

}

class AgencyProductsTableState extends State<AgencyProductsTable> {
  List<String> headerTitle = ['ID', 'Foto', 'Nome', 'Prezzo',];

  SearchProductsOfferedCubit get _searchProductCubit => context.read<SearchProductsOfferedCubit>();
  List<ProductEntity> products = [];
  File? imageFile;

  @override
  void initState() {
    _searchProductCubit.fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      BlocBuilder<SearchProductsOfferedCubit, SearchProductsOfferedState>(
          builder: (context, state)
    {
      if(state is SearchProductsOfferedLoading){
        return const Center(
            child: CircularProgressIndicator()
        );
      }
      if(state is SearchProductsOfferedEmpty){
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Texth2V2(
                testo: 'Nessun prodotto selezionato',
                weight: FontWeight.bold,
                color: background
            ),
          ),
        );
      }
      if (state is SearchProductsOfferedLoaded) {
        products.clear();
        state.productsOffered.forEach((
            productOffered) {
          if (productOffered.offered)
            products.add(productOffered.productEntity);
        });

        print("products: $products");
        if (products.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Texth2V2(
                  testo: 'Nessun prodotto selezionato',
                  weight: FontWeight.bold,
                  color: background
              ),
            ),
          );
        }

        return Container(
          padding: getPadding(top: 20),
          width: MediaQuery.of(context).size.width,
          child: DataTable(
            columnSpacing: 30,
            dataRowHeight: 85,
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
            rows: createRows(),
          ),
        );
      }
      else
        return ErrorWidget("errore");
    });
  } //fine metodo build




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
    return DataRow(
      cells: <DataCell>[
        DataCell(Text(
          p.id.toString(),
          style: SafeGoogleFont(
              'Montserrat',
              color: black,
              fontSize: 14,
              fontWeight: FontWeight.w700
          ),
        )),
        DataCell(DataCellImage(firebaseId: p.firebaseId),
        ),
        DataCell(Text(
          p.name,
          style: SafeGoogleFont('Montserrat',
              color: black, fontSize: 14, fontWeight: FontWeight.w700),
        )),
        DataCell(Text(
          '€ ${p.price}',
          style: SafeGoogleFont('Montserrat',
              color: black, fontSize: 14, fontWeight: FontWeight.w700),
        )),
      ],
    );
  }

}
