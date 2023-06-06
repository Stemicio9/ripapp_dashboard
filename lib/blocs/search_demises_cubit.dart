


import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/models/DemisesSearchEntity.dart';
import 'package:ripapp_dashboard/models/demise_entity.dart';
import 'package:ripapp_dashboard/repositories/demise_repository.dart';

class SearchDemiseCubit extends Cubit<SearchDemiseState> {
  SearchDemiseCubit() : super(SearchDemiseState());

  fetchDemises({required List<String> cities,required SearchSorting sorting,required int offset}){
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
      DemiseRepository().getDemisesByCities(DemisesSearchEntity(cities: cities, sorting: sorting, offset: offset))
          .then((demises) => emit(SearchDemiseLoaded(demises, false))).catchError((e) => emit(SearchDemiseLoaded(List.empty(growable: false), false)));
    }catch(e){
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