import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/models/user_entity.dart';

@immutable
class SelectedUserState {
  final UserEntity selectedUser;

  const SelectedUserState({required this.selectedUser});
}



class SelectedUserCubit extends Cubit<SelectedUserState> {
  SelectedUserCubit() : super(SelectedUserState(selectedUser: UserEntity.emptyUser()));

  selectUser(UserEntity selectedUser)async{
    print("cia, ho cambiato l'utente selezionato, che è " + selectedUser.toString());
    emit(SelectedUserState(selectedUser: selectedUser));
    print(selectedUser);
    print("CIAO5555");
  }
}