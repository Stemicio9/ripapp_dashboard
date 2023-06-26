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

  CurrentPageCubit get _currentPageCubit  => context.read<CurrentPageCubit>();


  NumberPaginatorController _controller = NumberPaginatorController();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 4,
      child: BlocBuilder<CurrentPageCubit,CurrentPageState> (
        builder: (context, state) {
         // _controller.navigateToPage(state.pageNumber);
          return NumberPaginator(
            // by default, the paginator shows numbers as center content
          initialPage: state.pageNumber,
            numberPages: _numPages,
            onPageChange: (int index) {
              widget.changePageHandle(_currentPageCubit.state.page, index); //todo: in realtà qui si può chiamare un metodo del cubit che
              //  ne cambi solo il numero, dato che la pagina rimane la stessa
            },
          );
        }
      ),
    );
  }
}