

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseImageUtility {

  static void deleteAllImages(String? firebaseid) async {
    if(firebaseid == null) return;
    final User user = FirebaseAuth.instance.currentUser!;
    final uid = user.uid;
    await deleteObituary(uid, firebaseid);
    await deleteDemiseImage(uid, firebaseid);
  }

  static Future<void> deleteObituary(String uid, String firebaseid) async {
    var obituaryPath = 'obituaries/UID:$uid/demiseId:$firebaseid/';
    var obituaryList = await FirebaseStorage.instance.ref(obituaryPath).listAll();
    if (obituaryList.items.isNotEmpty) {
      var fileesistente = obituaryList.items[0];
      fileesistente.delete();
    }
  }


  static Future<void> deleteDemiseImage(String uid, String firebaseid) async {
    var path = 'profile_images/deceased_images/UID:$uid/demiseId:${firebaseid}/';
    var fileList = await FirebaseStorage.instance.ref(path).listAll();
    if (fileList.items.isNotEmpty) {
      var fileesistente = fileList.items[0];
      fileesistente.delete();
    }
  }



}