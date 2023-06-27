import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:ripapp_dashboard/models/demise_entity.dart';
import 'package:ripapp_dashboard/models/user_entity.dart';

import '../repositories/user_repository.dart';

@immutable
class SelectedDemiseState {
  final DemiseEntity selectedDemise;

  const SelectedDemiseState({required this.selectedDemise});
}



class SelectedDemiseCubit extends Cubit<SelectedDemiseState> {
  SelectedDemiseCubit() : super(SelectedDemiseState(selectedDemise: DemiseEntity.emptyDemise()));

  selectDemise(DemiseEntity selectedDemise)async{
    print("cambio l'utente selezionato in " + selectedDemise.toString());
    emit(SelectedDemiseState(selectedDemise: selectedDemise));
    print(selectedDemise);
  }
}