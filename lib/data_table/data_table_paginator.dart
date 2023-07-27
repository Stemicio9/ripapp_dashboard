import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:ripapp_dashboard/data_table/data_table_paginator/data_table_paginator_data.dart';

class DataTablePaginator extends StatelessWidget {
  final DataTablePaginatorData data;

  const DataTablePaginator({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bottomPagesBar();
  }

  Widget bottomPagesBar() {
    return NumberPaginator(
        initialPage: data.pageNumber,
        numberPages: data.numPages,
        config: const NumberPaginatorUIConfig(

           ),
        onPageChange: (int index) {
          data.changePageHandle(index, data.currentPageType);
        });
  }
}
