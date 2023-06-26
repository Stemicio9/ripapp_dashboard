import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/blocs/firebase_storage/firebase_storage_service.dart';

class FirebaseStorageCubit extends Cubit<FirebaseStorageState> {
  FirebaseStorageCubit() : super(FirebaseStorageNothing());

  persistImageUrl(String imageUrl) {
    emit(FirebaseStorageLoaded(imageUrl));
  }

  Future saveImageToFirebase(String imageFile, String uid) async {
    emit(FirebaseStorageLoading());
    try{
      print("STO PER SALVARE IMMAGINE IN FIREBASE");
      String result = await firebaseStorageService.saveDataToFirebase(imageFile, uid);
      print("HO FATTO UPLOAD SU FIREBASE, ORA MI PRENDO URL");
      String finalResult = await firebaseStorageService.downloadUrlImage(uid);
      print("HO PRESO URL IMAGE : $finalResult");



      emit(FirebaseStorageLoaded(finalResult));
    }catch(e){
      emit(FirebaseStorageError());
    }
  }

  uploaded(String imageUrl){
    emit(FirebaseStorageLoaded(imageUrl));
  }

  clear(){
    emit(FirebaseStorageNothing());
  }


}


@immutable
abstract class FirebaseStorageState {}

class FirebaseStorageNothing extends FirebaseStorageState {}

class FirebaseStorageLoading extends FirebaseStorageState {}

class FirebaseStorageLoaded extends FirebaseStorageState {
  final String imageUrl;
  FirebaseStorageLoaded(this.imageUrl);
}

class FirebaseStorageError extends FirebaseStorageState {}


