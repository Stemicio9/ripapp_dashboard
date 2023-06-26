import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:ripapp_dashboard/models/user_entity.dart';

import '../repositories/user_repository.dart';

@immutable
class SelectedUserState {
  final UserEntity selectedUser;

  const SelectedUserState({required this.selectedUser});
}



class SelectedUserCubit extends Cubit<SelectedUserState> {
  SelectedUserCubit() : super(SelectedUserState(selectedUser: UserEntity.emptyUser()));

  selectUser(UserEntity selectedUser)async{
    print("ciao4");
    emit(SelectedUserState(selectedUser: selectedUser));
    print(selectedUser);
    print("CIAO5555");
  }

  /*fetchSelectedUser(int userId, UserEntity userEntity) async {
    emit(SelectedUserLoaded());
    try {
      print("RIEMPIO LA MODIFICA UTENTE");
      // todo manage if agencies is null or empty in response
      print("Step 1");
      var result = await UserRepository().updateUser(userId, userEntity);
      print("Step 2");
    } catch (e) {
      print("ERRORE1");
      print(e);
      emit(SelectedUserError());
    }
  }*/
}