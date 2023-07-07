

import 'package:firebase_storage/firebase_storage.dart';

class ImageUtils {


  Future<dynamic> downloadUrlImageUser(String uid) async {
    var fileList = await FirebaseStorage.instance.ref('profile_images/users_images/UID:$uid/').listAll();
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

