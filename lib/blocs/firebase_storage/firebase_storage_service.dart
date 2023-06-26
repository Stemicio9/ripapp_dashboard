
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

FirebaseStorageService firebaseStorageService = FirebaseStorageService();

class FirebaseStorageService {


  Future downloadUrlImage(String uid) async {

    var fileList = await FirebaseStorage.instance.ref('profile_images/users_images/$uid/').listAll();

    print("LA LISTA INTERA DEI FILE DI $uid");
     for (var element in fileList.items) {
       print(element.name);
     }

    if (fileList.items.isEmpty) {
      print("NON CI SONO FILE NELLA LISTA");
      var fileList = await FirebaseStorage.instance.ref('demise_placeholder.jpeg').listAll();
      var file = fileList.items[0];
      var result = await file.getDownloadURL();
      return result;
    }

    print("CI SONO FILE NELLA LISTA");

    var file = fileList.items[0];
    var result = await file.getDownloadURL();

    print("HO APPENA PESCATO IMMAGINE DI UTENTE $uid");
    print("URL IMMAGINE = $result");

    return result;
  }

  Future saveDataToFirebase(String imageFile, String uid) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      Uint8List fileBytes = result.files.first.bytes!;
      String fileName = result.files.first.name;

      print('STAMPO IL FILE PICKATO');
      print(fileName);

      var path = 'profile_images/users_images/$uid/';


      var fileList = await FirebaseStorage.instance.ref(path).listAll();
      if (fileList.items.isNotEmpty) {
        var fileesistente = fileList.items[0];
        fileesistente.delete();
      }

      await FirebaseStorage.instance.ref("$path$fileName").putData(fileBytes);
    }
  }
}