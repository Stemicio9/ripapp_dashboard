import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileImageCubit extends Cubit<ProfileImageState> {
  ProfileImageCubit() : super(ProfileImageState(false));

  changeLoaded(bool loaded) {
    print("sto cambiando il loaded");
    emit(ProfileImageState(loaded));
  }
}

@immutable
class ProfileImageState {
   bool loaded;

  ProfileImageState(this.loaded);
}





