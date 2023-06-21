import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/authentication/firebase_authentication_listener.dart';
import 'package:ripapp_dashboard/models/user_entity.dart';

class CurrentUserCubit extends Cubit<CurrentUserState> with ChangeNotifier {
  CurrentUserCubit() :
        super(CurrentUserState(CustomFirebaseAuthenticationListener().userEntity ?? UserEntity.defaultUser()))
  {
    CustomFirebaseAuthenticationListener().addListener(listenToNotifier);
  }

  void setUser(UserEntity user) => emit(CurrentUserState(user));

  void deleteUser() => emit(CurrentUserState(UserEntity.defaultUser()));

  listenToNotifier(){
    print("cambiamento nello stato");
    setUser(CustomFirebaseAuthenticationListener().userEntity ?? UserEntity.defaultUser());
  }
}

class CurrentUserState {
  final UserEntity user;

  CurrentUserState(this.user);
}
