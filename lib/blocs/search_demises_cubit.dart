


import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/models/DemisesSearchEntity.dart';
import 'package:ripapp_dashboard/models/demise_entity.dart';
import 'package:ripapp_dashboard/repositories/demise_repository.dart';

class SearchDemiseCubit extends Cubit<SearchDemiseState> {
  SearchDemiseCubit() : super(SearchDemiseState());

  Future fetchDemises({ List<String> cities = const [], SearchSorting sorting = SearchSorting.date, int offset = 0}) async {
    if(offset == 0) {
      emit(SearchDemiseLoading());
    }else{
      try {
        var currentState = state as SearchDemiseLoaded;
        emit(SearchDemiseLoaded(currentState.demises, false));
      }catch(e){
        // ignore
      }
    }
    print("esatto");
    try{
      /*
      DemiseRepository().getDemisesByCities(DemisesSearchEntity(cities: cities, sorting: sorting, offset: offset))
          .then((demises) => emit(SearchDemiseLoaded(demises, false))).catchError((e) => emit(SearchDemiseLoaded(List.empty(growable: false), false)));
      */
      var demises = await DemiseRepository().getDemisesByCities(DemisesSearchEntity(cities: cities, sorting: sorting, offset: offset));
      print(demises);
      emit(SearchDemiseLoaded(demises, false));
    }catch(e){
      print("ERRORE DI FETCH");
      print(e);
      emit(SearchDemiseError());
    }
  }


  delete(idDemise)async{
    emit(SearchDemiseLoading());
    try{
      var result = await DemiseRepository().deleteDemise(idDemise);
      fetchDemises();
    }catch(e){
      print("ERRORE");
      print(e);
      emit(SearchDemiseError());
    }
  }

  saveProduct(DemiseEntity demiseEntity) async{
    emit(SearchDemiseLoading());
    try{
      var result = await DemiseRepository().saveDemise(demiseEntity);
      fetchDemises();
    }catch(e){
      print("ERRORE DI FETCH");
      print(e);
      emit(SearchDemiseError());
    }
  }

}


@immutable
class SearchDemiseState{}

class SearchDemiseLoading extends SearchDemiseState {}

class SearchDemiseError extends SearchDemiseState {}

class SearchDemiseLoaded extends SearchDemiseState {
  final List<DemiseEntity> demises;
  final bool loadingMore;
  SearchDemiseLoaded(this.demises, this.loadingMore);
}