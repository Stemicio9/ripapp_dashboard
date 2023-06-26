import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/models/UserStatusEnum.dart';
import 'package:ripapp_dashboard/models/user_entity.dart';

@immutable
class SelectedUserState {
  final UserEntity selectedUser;


  const SelectedUserState({required this.selectedUser});
}



class SelectedUserCubit extends Cubit<SelectedUserState> {
  SelectedUserCubit() : super(SelectedUserState(selectedUser: UserEntity.emptyUser()));

  selectUser(UserEntity selectedUser)async{
    print("cambio l'utente selezionato, che è $selectedUser");
    emit(SelectedUserState(selectedUser: selectedUser));
    print(selectedUser);
  }

}