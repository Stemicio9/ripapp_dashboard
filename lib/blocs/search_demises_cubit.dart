


import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/models/DemisesSearchEntity.dart';
import 'package:ripapp_dashboard/models/demise_entity.dart';
import 'package:ripapp_dashboard/repositories/demise_repository.dart';

class DemiseCubit extends Cubit<DemiseState> {
  DemiseCubit() : super(DemiseState());

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
    try{
      /*
      DemiseRepository().getDemisesByCities(DemisesSearchEntity(cities: cities, sorting: sorting, offset: offset))
          .then((demises) => emit(SearchDemiseLoaded(demises, false))).catchError((e) => emit(SearchDemiseLoaded(List.empty(growable: false), false)));
      */
      //var demises = await DemiseRepository().getDemisesByCities(DemisesSearchEntity(cities: cities, sorting: sorting, offset: offset));
      var demises = await DemiseRepository().getDemisesByCities(DemisesSearchEntity(cities: cities, sorting: sorting, offset: offset, pageElements: 10, pageNumber: 0));
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

  saveDemise(DemiseEntity demiseEntity) async{
    print("qui ci entro??");
    emit(SaveDemiseLoading());
    try{
      var result= await DemiseRepository().saveDemise(demiseEntity);
      print("qui ci entrai??");
      print(result);
      List<DemiseEntity> currentDemises = (result as List).map((e) => DemiseEntity.fromJson(e)).toList();
      print("eccoti i demises castati : " + currentDemises.toString());
      emit(SaveDemiseLoaded(currentDemises));
      print("HO SALVATO LA DEMISE, FACCIO LA FETCH");

      fetchDemises();
    }catch(e){
      print("ERRORE DI FETCH");
      print(e);
      emit(SaveDemiseError());
    }
  }

}


@immutable
class DemiseState{}

class SearchDemiseLoading extends DemiseState {}

class SearchDemiseError extends DemiseState {}

class SearchDemiseLoaded extends DemiseState {
  final List<DemiseEntity> demises;
  final bool loadingMore;
  SearchDemiseLoaded(this.demises, this.loadingMore);
}

class SaveDemiseLoading extends DemiseState {}
class SaveDemiseLoaded extends DemiseState {
  final List<DemiseEntity> demiseSaved;
  SaveDemiseLoaded(this.demiseSaved);
}
class SaveDemiseError extends DemiseState {}