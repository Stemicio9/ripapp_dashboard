import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/models/user_entity.dart';
import 'package:ripapp_dashboard/repositories/user_repository.dart';

@immutable
class UsersListState{}
class UsersListLoading extends UsersListState{}
class UsersListError extends UsersListState{}
class UsersListLoaded extends UsersListState{
  final List<UserEntity> accountList;
   UsersListLoaded(this.accountList);

  UsersListLoaded copyWith({List<UserEntity>? account, required UserEntity userEntity}) {
    return UsersListLoaded(
        account ?? this.accountList,
    );
  }
}

class UsersListCubit extends Cubit<UsersListState> {
  UsersListCubit() : super(UsersListLoading());

  fetchUsersList() async {
    emit(UsersListLoading());
    try {
      print("FACCIO LA FETCH DEGLI ACCOUNT");
      // todo manage if agencies is null or empty in response
      print("Step 1");
      var result = await UserRepository().getList();
      print("Step 2");
      emit(UsersListLoaded(result));
      print("Step 3");
    }catch(e){
      print("ERRORE");
      print(e);
      emit(UsersListError());
    }
  }

  changeSelectedAgency(UserEntity? userEntity){
    if(state is UsersListLoaded && userEntity != null){
      var a = state as UsersListLoaded;
      emit(a.copyWith(userEntity: userEntity));
    }
  }
}

