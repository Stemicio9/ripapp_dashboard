import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:ripapp_dashboard/constants/kinships.dart';
import 'package:ripapp_dashboard/models/agency_entity.dart';
import 'package:ripapp_dashboard/repositories/agency_repository.dart';
import 'package:ripapp_dashboard/repositories/kinship_repository.dart';

@immutable
class SearchKinshipState{}
class SearchKinshipLoading extends SearchKinshipState {}
class SearchKinshipError extends SearchKinshipState {}


class SearchKinshipLoaded extends SearchKinshipState {
  final List<Kinship> kinships;
  List<Kinship> selectedValues = [];
  //final bool loadingMore;
  //SearchAgencyLoaded(this.agencies, this.loadingMore);
  SearchKinshipLoaded(this.kinships, this.selectedValues);


  SearchKinshipLoaded copyWith({List<Kinship>? kinships, List<Kinship>? selectedValues,}) {
    return SearchKinshipLoaded(
        kinships ?? this.kinships,
        selectedValues ?? this.selectedValues
    );
  }
}

class SearchKinshipCubit extends Cubit<SearchKinshipState> {
  SearchKinshipCubit() : super(SearchKinshipLoading());

  fetchKinships() async {
    emit(SearchKinshipLoading());
    try {
      print("FACCIO LA FETCH DELLE kinship");
      // todo manage if agencies is null or empty in response
      var result = await KinshipRepository().getAllKinship();
    }catch(e){
      // ignore
      emit(SearchKinshipError());
    }
  }

  changeSelectedAgency(List<Kinship>? selectedValues,){
    if(state is SearchKinshipLoaded && selectedValues != null){
      var a = state as SearchKinshipLoaded;
      emit(a.copyWith(selectedValues: selectedValues));
    }
  }

}