import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/images_constants.dart';
import 'package:ripapp_dashboard/models/ProductOffered.dart';
import 'package:ripapp_dashboard/models/product_entity.dart';
import 'package:ripapp_dashboard/repositories/agency_repository.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/utils/style_utils.dart';
import 'package:ripapp_dashboard/widgets/texts.dart';

class AgencyProductsTable extends StatelessWidget {
  List<String> headerTitle = ['ID', 'Foto', 'Nome', 'Prezzo',];


  File? imageFile;

  /*fetchProducts() async {
    List<ProductOffered> agencyProductsRetrieved = await AgencyRepository().getAllAgencyProducts();
    if (agencyProductsRetrieved.length == 0){print("non ci sono prodotti da mostrare");}
    else{
      try {
        emit(SearchProductLoaded(agencyProductsRetrieved));
      }
      catch (e){
        print("error");
      }
    }
  }*/
  List<ProductEntity> products = [
    ProductEntity(
      id: 1,
      name: 'Prodotto 1',
      price: 100.00,
      photoName: ImagesConstants.imgProductPlaceholder,
    ),
    ProductEntity(
      id: 2,
      name: 'Prodotto 2',
      price: 100.00,
      photoName: ImagesConstants.imgProductPlaceholder,
    ),
    ProductEntity(
      id: 3,
      name: 'Prodotto 3',
      price: 100.00,
      photoName: ImagesConstants.imgProductPlaceholder,
    ),
    ProductEntity(
      id: 4,
      name: 'Prodotto 4',
      price: 100.00,
      photoName: ImagesConstants.imgProductPlaceholder,
    ),
    ProductEntity(
      id: 5,
      name: 'Prodotto 5',
      price: 100.00,
      photoName: ImagesConstants.imgProductPlaceholder,
    ),
    ProductEntity(
      id: 6,
      name: 'Prodotto 6',
      price: 100.00,
      photoName: ImagesConstants.imgProductPlaceholder,
    ),
    ProductEntity(
      id: 7,
      name: 'Prodotto 7',
      price: 100.00,
      photoName: ImagesConstants.imgProductPlaceholder,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: getPadding(top: 20),
      width: MediaQuery.of(context).size.width,
      child: DataTable(
        columnSpacing: 30,
        dataRowHeight: 85,
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
        DataCell(Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(3)),
            color: greyDrag,
            border: Border.all(color: background, width: 0.5),
            image: imageFile != null ?
            DecorationImage(
              image: FileImage(imageFile!),
              fit: BoxFit.contain,
            ) : const DecorationImage(
              image: AssetImage(ImagesConstants.imgProductPlaceholder),
              fit: BoxFit.cover,

            ),
          ),
        )),
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
