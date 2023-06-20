import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/blocs/searchAgenciesCubit.dart';
import 'package:ripapp_dashboard/blocs/selected_user_cubit.dart';
import 'package:ripapp_dashboard/repositories/agency_repository.dart';
import 'package:ripapp_dashboard/repositories/product_repository.dart';
import 'package:ripapp_dashboard/repositories/user_repository.dart';
import 'package:ripapp_dashboard/utils/ResultSet.dart';
import 'package:ripapp_dashboard/widgets/scaffold.dart';

@immutable
class CurrentPageState {
  final String page;
  final List<ResultEntity> resultSet;
  final bool loading;
  CurrentPageState(this.page, this.resultSet, this.loading);

  CurrentPageState copyWith({String? page, List<ResultEntity>? resultSet, bool? loading}) {
    return CurrentPageState(
        page ?? this.page,
        resultSet ?? this.resultSet,
        loading ?? true
    );
  }
}


class CurrentPageCubit extends Cubit<CurrentPageState> {
  CurrentPageCubit() : super(CurrentPageState(ScaffoldWidgetState.users_page, [], true));


  Future<List<ResultEntity>?> findResult(String pageName, int index) async {
    List<ResultEntity>? result;
    if (pageName == ScaffoldWidgetState.users_page){
      result = await UserRepository().getListWithIndex(index);
    }
    else if (pageName == ScaffoldWidgetState.agencies_page){
      result = await AgencyRepository().getAgenciesWithIndex(index);
    }
    else if (pageName == ScaffoldWidgetState.products_page){
      result = await ProductRepository().getAllProductsWithIndex(index);
    }
    return result;
  }

  void loadPage(String page, int index) async {
    emit(CurrentPageState(page, [], true));
      List<ResultEntity>? resultSet = await findResult(page, index);
      emit(CurrentPageState(page, resultSet!, false));
  }

  void changeCurrentPage(String agencies_page) {
    emit(state.copyWith(page: agencies_page));
  }
}