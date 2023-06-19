import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/models/agency_entity.dart';

@immutable
class SelectedAgencyState {
  final AgencyEntity selectedAgency;


  const SelectedAgencyState({required this.selectedAgency});
}

class SelectedAgencyCubit extends Cubit<SelectedAgencyState> {
  SelectedAgencyCubit() : super(SelectedAgencyState(selectedAgency: AgencyEntity.emptyAgency()));

  selectUser(AgencyEntity selectedAgency)async{
    print("cambio l'agenzia selezionata, che è $selectedAgency");
    emit(SelectedAgencyState(selectedAgency: selectedAgency));
    print(selectedAgency);
  }

}