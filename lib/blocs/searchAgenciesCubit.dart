import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:ripapp_dashboard/models/agency_entity.dart';
import 'package:ripapp_dashboard/repositories/agency_repository.dart';

@immutable
class SearchAgencyState{}
class SearchAgencyLoading extends SearchAgencyState {}
class SearchAgencyError extends SearchAgencyState {}
class SearchAgencyLoaded extends SearchAgencyState {
  final List<AgencyEntity> agencies;
  final AgencyEntity? selectedAgency;
  //final bool loadingMore;
  //SearchAgencyLoaded(this.agencies, this.loadingMore);
  SearchAgencyLoaded(this.agencies, this.selectedAgency);

  //copywith si prende una lista di agenzie e una agenzia; se non vengono fornite viene tornata una copia del
  //SearchAgencyLoaded corrente con la sua lista e la sua agenzia
  SearchAgencyLoaded copyWith({List<AgencyEntity>? agencies, AgencyEntity? selectedAgency,}) {
    return SearchAgencyLoaded(
       agencies ?? this.agencies,
       selectedAgency ?? this.selectedAgency
    );
  }
}

class SearchAgencyCubit extends Cubit<SearchAgencyState> {
  SearchAgencyCubit() : super(SearchAgencyLoading());

  fetchAgencies() async {
    emit(SearchAgencyLoading());
    try {
      print("FACCIO LA FETCH DELLE AGENZIE");
      // todo manage if agencies is null or empty in response
        var result = await AgencyRepository().getAgencies().then((agencies) => emit(SearchAgencyLoaded(agencies, agencies.first))).catchError((e) => emit(SearchAgencyError()));
    }catch(e){
        // ignore
      emit(SearchAgencyError());
      }
    }

  changeSelectedAgency(AgencyEntity? selectedAgency){
    if(state is SearchAgencyLoaded && selectedAgency != null){
      var a = state as SearchAgencyLoaded;
      emit(a.copyWith(selectedAgency: selectedAgency));
    }
  }

  refreshAgencies(){
    if(state is SearchAgencyLoaded){
      var a = state as SearchAgencyLoaded;
      emit(a.copyWith());
    }
  }
}