import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:ripapp_dashboard/constants/kinships.dart';
import 'package:ripapp_dashboard/models/agency_entity.dart';
import 'package:ripapp_dashboard/repositories/agency_repository.dart';
import 'package:ripapp_dashboard/repositories/kinship_repository.dart';

@immutable
class SearchKinshipState{
  bool? loaded = false;
  List<Kinship>? retrievedKinships;
  List<Kinship>? selectedKinships;
  List<String>? phoneNumbersInserted;
  //final bool loadingMore;
  //SearchAgencyLoaded(this.agencies, this.loadingMore);
  SearchKinshipState(this.loaded, this.retrievedKinships, this.selectedKinships, this.phoneNumbersInserted);


  SearchKinshipState copyWith({bool? isLoaded, List<Kinship>? retrieved, List<Kinship>? selected, List<String>? phoneNumbers}) {
    return SearchKinshipState(
        isLoaded ?? this.loaded,
        retrieved ?? this.retrievedKinships,
        selected ?? this.selectedKinships,
        phoneNumbers ?? this.phoneNumbersInserted
    );
  }
}

class SearchKinshipError extends SearchKinshipState{
  SearchKinshipError(super.loaded, super.retrievedKinships, super.selectedKinships, super.phoneNumbersInserted);
}


class SearchKinshipCubit extends Cubit<SearchKinshipState> {
  SearchKinshipCubit() : super(SearchKinshipState(false, [], [], []));

  fetchKinships() async {
    emit(state.copyWith(isLoaded: false));
    try {
      print("FACCIO LA FETCH DELLE kinship");
      // todo manage if agencies is null or empty in response
      var result = await KinshipRepository().getAllKinship();
      if(result.isNotEmpty) {
        emit(state.copyWith(isLoaded: true, retrieved: result));
      }else{
        emit(state.copyWith(isLoaded: true, retrieved: []));
      }
    }catch(e){
      print(e);
      // todo gestire l'errore
    }
  }

  changeSelectedKinships(List<Kinship>? selectedValues,){
    if(state is SearchKinshipState && selectedValues != null){
      var a = state as SearchKinshipState;
      emit(a.copyWith(selected: selectedValues));
    }
  }

  void changeSelectedKinshipOf(int index, Kinship kinshipFromString) {
    if(state is SearchKinshipState){
      var a = state as SearchKinshipState;
      if (a.selectedKinships!.isNotEmpty){
        a.selectedKinships![index] = kinshipFromString;
        emit(a.copyWith());
      }
    }
  }

  void changeTelephoneNumberOf(int index, String? phoneNumber) {
    if(state is SearchKinshipState){
      var a = state as SearchKinshipState;
      if (a.phoneNumbersInserted!.isNotEmpty){
        a.phoneNumbersInserted![index] = phoneNumber!;
        emit(a.copyWith());
      }
    }
  }

}