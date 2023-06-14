import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';

class BottomNavigationBarExample extends StatefulWidget {
  final Function(int index) changePageHandle;
  const BottomNavigationBarExample({super.key, required this.changePageHandle});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  final int _numPages = 10;
  int _currentPage = 0;



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
            _currentPage = index;
            //passare l'indice
            widget.changePageHandle(_currentPage);
          });
        },
      ),
    );
  }
}