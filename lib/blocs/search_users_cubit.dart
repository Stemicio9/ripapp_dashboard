import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/models/user_entity.dart';
import 'package:ripapp_dashboard/repositories/user_repository.dart';

@immutable
class SearchUsersState{}
class SearchUsersLoading extends SearchUsersState {}
class SearchUsersError extends SearchUsersState {}
class SearchUsersLoaded extends SearchUsersState {
  final List<UserEntity> users;
  SearchUsersLoaded(this.users);
}


class SearchUsersCubit extends Cubit<SearchUsersState>{
  SearchUsersCubit():  super(SearchUsersLoading());

  fetchUsers() async {
    emit(SearchUsersLoading());

    try {
      List<UserEntity> usersRetrieved = await UserRepository().getAllUsers();
    }catch(e){
      emit(SearchUsersError());
    }
  }
}