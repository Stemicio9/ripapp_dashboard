
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/widgets/utilities/network_memory_image_utility.dart';

class DataCellImage extends StatefulWidget {

  final String firebaseId;

  const DataCellImage({Key? key, required this.firebaseId}) : super(key: key);

  @override
  State<DataCellImage> createState() => _DataCellImageState();
}

class _DataCellImageState extends State<DataCellImage> {

  String url = "";

  @override
  initState() {
    super.initState();
    downloadUrlImage(widget.firebaseId).then((value) => changeFunction(value));
  }

  Future<dynamic> downloadUrlImage( String productId) async {
    var fileList = await FirebaseStorage.instance.ref('profile_images/products_images/productid:$productId/').listAll();
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


  changeFunction(String value){
    setState(() {
      url = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return url.isNotEmpty ? Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(3)),
        color: greyDrag,
        border: Border.all(color: background, width: 0.5),
        image: DecorationImage(
          image: NetworkMemoryImageUtility(
              isNetwork: true,
              networkUrl: url,
              memoryImage: null).provide(),
          fit: BoxFit.cover,
        ),
      ),
    ) : Container();
  }
}
