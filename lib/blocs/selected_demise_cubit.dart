

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:ripapp_dashboard/models/demise_entity.dart';

@immutable
class SelectedDemiseState {
  final DemiseEntity selectedDemise;

  const SelectedDemiseState({required this.selectedDemise});
}

  class SelectedDemiseCubit extends Cubit<SelectedDemiseState>{
  SelectedDemiseCubit() : super(SelectedDemiseState(selectedDemise: DemiseEntity.emptyUser()));

  selectedDemise(DemiseEntity selectedDemise){
    print("SELEZIONA DEFUNTO");
    emit(SelectedDemiseState(selectedDemise: selectedDemise));
    print(selectedDemise);
    print("DEFUNTO SELEZIONATO");
  }


  }
