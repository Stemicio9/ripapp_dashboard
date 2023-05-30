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
  //final bool loadingMore;
  //SearchAgencyLoaded(this.agencies, this.loadingMore);
  SearchAgencyLoaded(this.agencies);
}







class SearchAgencyCubit extends Cubit<SearchAgencyState> {
  SearchAgencyCubit() : super(SearchAgencyState());

  fetchAgencies() async {
    emit(SearchAgencyLoading());
    try {
        var currentState = state as SearchAgencyLoaded;
        var result = await AgencyRepository().getAgencies().then((agencies) => emit(SearchAgencyLoaded(agencies))).catchError((e) => emit(SearchAgencyError()));
    }catch(e){
        // ignore
      emit(SearchAgencyError());
      }
    }
  }





/* FATTO
MultiBlocProvider(
  providers: [
    BlocProvider<SearchAgencyCubit>(create: (_) => SearchAgencyCubit()),
],
 */


/* implementare i vari sottocasi
Widget agencyDropdown(){
  return BlocBuilder<SearchAgencyCubit, SearchAgencyState>(
      builder: (context, state){
    if (state is SearchAgencyLoading)
      //rotellina
      return CircularProgressIndicator();
    else if (state is loaded)
      if (state.lista == vuota)
        return Error("non ci sono agenzie");
      else return dropdownFilled;
    else
      return Error("errore di connessione");
  }
}
   Widget buildFunction(BuildContext context, state){
       if (state is SearchAgencyLoading)
      //rotellina
      return null;
    else if (state is loaded)
      if (state.lista == vuota)
        return Error("non ci sono agenzie");
      else return dropdownFilled;
    else
      return Error("errore di connessione");
   }
 */