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


  SearchAgencyLoaded copyWith({
    List<AgencyEntity>? agencies,
    AgencyEntity? selectedAgency,
  }) {
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