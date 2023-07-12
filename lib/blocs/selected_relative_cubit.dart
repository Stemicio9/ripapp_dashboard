

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:ripapp_dashboard/models/relative_entity.dart';

@immutable
class SelectedRelativeState {
  final RelativeEntity selectedRelative;


  const SelectedRelativeState({required this.selectedRelative});
}



class SelectedRelativeCubit extends Cubit<SelectedRelativeState> {
  SelectedRelativeCubit() : super(SelectedRelativeState(selectedRelative: RelativeEntity.emptyRelative()));

  selectRelative(RelativeEntity selectedRelative)async{
    print("cambio il parente selezionato, che è $selectedRelative");
    emit(SelectedRelativeState(selectedRelative: selectedRelative));
    print(selectedRelative);
  }

}