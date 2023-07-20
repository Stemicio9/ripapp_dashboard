import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/constants/images_constants.dart';

class ProfileImageCubit extends Cubit<ProfileImageState> {
  ProfileImageCubit() : super(ProfileImageState(false, "", ImagesConstants.imgDemisePlaceholder));

  fetchProfileImage(String uid,String demiseId){
    downloadUrlImage(uid, demiseId)
        .then((value) => emit(state.copyWith(newImageUrl: value, newLoaded: true)))
        .onError((error, stackTrace) => emit(state.copyWith(newImageUrl: ImagesConstants.imgDemisePlaceholder, newLoaded: false)
       ));
  }

  fetchObituary(String uid,String demiseId){
    downloadObituary(uid, demiseId)
        .then((value) => emit(state.copyWith(newObituaryUrl: value, newLoaded: true)))
        .onError((error, stackTrace) => emit(state.copyWith(newObituaryUrl: ImagesConstants.imgDemisePlaceholder, newLoaded: false)
    ));
  }

  changeLoaded(bool loaded) {
    print("sto cambiando il loaded");
    emit(ProfileImageState(loaded, "", ImagesConstants.imgDemisePlaceholder));
  }

  Future<dynamic> downloadUrlImage(String uid,String demiseId) async {
    var fileList = await FirebaseStorage.instance.ref('profile_images/deceased_images/UID:$uid/demiseId:$demiseId/').listAll();
    for (var element in fileList.items) {
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

  Future<dynamic> downloadObituary(String uid, String demiseId) async {
    ListResult  fileList = await FirebaseStorage.instance.ref('obituaries/UID:$uid/demiseId:$demiseId/').listAll();
    var file = fileList.items[0];
    var result = await file.getDownloadURL();
    return result;
  }

}

@immutable
class ProfileImageState {
  String obituaryUrl;
  String imageUrl;
  bool loaded;

  ProfileImageState(this.loaded, this.obituaryUrl, this.imageUrl);

  ProfileImageState copyWith({String? newObituaryUrl, String? newImageUrl, bool? newLoaded}) {
    return ProfileImageState(
      newLoaded ?? loaded,
      newObituaryUrl ?? obituaryUrl,
      newImageUrl ?? imageUrl,
    );
  }
}
