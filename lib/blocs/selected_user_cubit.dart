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
}