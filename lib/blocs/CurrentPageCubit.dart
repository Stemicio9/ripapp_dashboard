import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/models/ProductOffered.dart';
import 'package:ripapp_dashboard/models/product_entity.dart';
import 'package:ripapp_dashboard/repositories/agency_repository.dart';
import 'package:ripapp_dashboard/repositories/demise_repository.dart';
import 'package:ripapp_dashboard/repositories/product_repository.dart';
import 'package:ripapp_dashboard/repositories/user_repository.dart';
import 'package:ripapp_dashboard/utils/ResultSet.dart';
import 'package:ripapp_dashboard/widgets/scaffold.dart';

@immutable
class CurrentPageState {
  final String page;
  final int pageNumber;
  final List<ResultEntity> resultSet;
  final bool loading;

  CurrentPageState(this.page, this.resultSet, this.loading, this.pageNumber);

  CurrentPageState copyWith({String? page, List<ResultEntity>? resultSet, bool? loading, int? pageNumber}) {
    return CurrentPageState(
        page ?? this.page,
        resultSet ?? this.resultSet,
        loading ?? this.loading,
        pageNumber ?? this.pageNumber,
    );
  }
}


class CurrentPageCubit extends Cubit<CurrentPageState> {
  CurrentPageCubit() : super(CurrentPageState("", [], true, 0));


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
    else if (pageName == ScaffoldWidgetState.agency_products_page){
      result = await AgencyRepository().getAllAgencyProductsWithIndex(index);
      List<ProductEntity> products = result as List<ProductEntity>;
      print("eccoti solo i prodotti offerti: " + products.toString());
      result = products;
    }
    else if (pageName == ScaffoldWidgetState.agency_demises_page){
      result = await DemiseRepository().getDemisesPaginated(index);
    }
    return result;
  }

  void loadPage(String page, int index) async {
    emit(CurrentPageState(page, [], true, index));
    List<ResultEntity>? resultSet = await findResult(page, index);
    print("ecco il resultset: " + resultSet.toString());
    emit(CurrentPageState(page, resultSet!, false, index));
  }

  void changeCurrentPage(String page) {
    print("piccola chiamata 2");
    emit(state.copyWith(page: page));
  }
}