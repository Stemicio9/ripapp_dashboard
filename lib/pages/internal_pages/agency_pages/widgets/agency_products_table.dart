import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/images_constants.dart';
import 'package:ripapp_dashboard/models/product_entity.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/utils/style_utils.dart';
import 'package:ripapp_dashboard/widgets/texts.dart';

class AgencyProductsTable extends StatelessWidget {
  List<String> headerTitle = ['ID', 'Foto', 'Nome', 'Prezzo',];


  File? imageFile;

  List<ProductEntity> products = [
    ProductEntity(
      id: 1,
      name: 'Prodotto 1',
      price: 100.00,
      photoName: ImagesConstants.imgProductPlaceholder,
    ),
    ProductEntity(
      id: 2,
      name: 'Prodotto 1',
      price: 100.00,
      photoName: ImagesConstants.imgProductPlaceholder,
    ),
    ProductEntity(
      id: 3,
      name: 'Prodotto 1',
      price: 100.00,
      photoName: ImagesConstants.imgProductPlaceholder,
    ),
    ProductEntity(
      id: 4,
      name: 'Prodotto 1',
      price: 100.00,
      photoName: ImagesConstants.imgProductPlaceholder,
    ),
    ProductEntity(
      id: 5,
      name: 'Prodotto 1',
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
          style: SafeGoogleFont('Montserrat',
              color: black, fontSize: 12, fontWeight: FontWeight.w700),
        )),
        DataCell(Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(3)),
            color: greyDrag,
            border: Border.all(color: background, width: 1),
            image: imageFile != null ?
            DecorationImage(
              image: FileImage(imageFile!),
              fit: BoxFit.contain,
            ) : DecorationImage(
              image: AssetImage(ImagesConstants.imgProductPlaceholder),
              fit: BoxFit.cover,

            ),
          ),
        )


        ),
        DataCell(Text(
          p.name,
          style: SafeGoogleFont('Montserrat',
              color: black, fontSize: 12, fontWeight: FontWeight.w700),
        )),
        DataCell(Text(
          '${p.price} €',
          style: SafeGoogleFont('Montserrat',
              color: black, fontSize: 12, fontWeight: FontWeight.w700),
        )),


      ],
    );
  }
}
