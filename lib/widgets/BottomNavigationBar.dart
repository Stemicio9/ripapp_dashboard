import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:ripapp_dashboard/blocs/CurrentPageCubit.dart';

class BottomNavigationBarExample extends StatefulWidget {
  final Function(String page, int index) changePageHandle;
  const BottomNavigationBarExample({super.key, required this.changePageHandle, });

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  final int _numPages = 10;
  int _currentPageNumber = 0;
  CurrentPageCubit get _currentPageCubit  => context.read<CurrentPageCubit>();



  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 4,
      child: NumberPaginator(
        // by default, the paginator shows numbers as center content
        numberPages: _numPages,
        onPageChange: (int index) {
          setState(() {
            _currentPageNumber = index;
            //passare l'indice
            widget.changePageHandle(_currentPageCubit.state.page, _currentPageNumber);
          });
        },
      ),
    );
  }
}