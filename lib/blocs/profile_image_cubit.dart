import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileImageCubit extends Cubit<ProfileImageState> {
  ProfileImageCubit() : super(ProfileImageState(false));

  fetchProfileImage(String uid,String demiseId){
    downloadUrlImage(uid, demiseId).then((value) => emit(ProfileImageState(true))).onError((error, stackTrace) => emit(ProfileImageState(false)));
  }

  changeLoaded(bool loaded) {
    print("sto cambiando il loaded");
    emit(ProfileImageState(loaded));
  }

  Future<dynamic> downloadUrlImage(String uid,String demiseId) async {
    var fileList = await FirebaseStorage.instance.ref('profile_images/deceased_images/UID:$uid/demiseId:$demiseId/').listAll();
    for (var element in fileList.items) {
      print(element.name);
    }
    if (fileList.items.isEmpty) {
      var fileList = await FirebaseStorage.instance.ref('profile_images/').listAll();
      var file = fileList.items[0];
      var result = await file.getDownloadURL();
      return result;
    }
    var file = fileList.items[0];
    var result = await file.getDownloadURL();
    return result;
  }
}

@immutable
class ProfileImageState {
  bool loaded;

  ProfileImageState(this.loaded);
}
