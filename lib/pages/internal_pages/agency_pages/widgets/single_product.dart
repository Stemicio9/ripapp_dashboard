import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/blocs/SearchProductsOfferedCubit.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/entities/single_product_entity.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/utils/style_utils.dart';
import 'package:ripapp_dashboard/widgets/utilities/network_memory_image_utility.dart';

class SingleProduct extends StatefulWidget{
  final SingleProductEntity singleProductEntity;
  final SearchProductsOfferedLoaded state;
  final String firebaseId;

  SingleProduct(
      {Key? key,
        required this.firebaseId,
        required this.singleProductEntity,
        required this.state,
      })
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SingleProductState();
  }

}
class SingleProductState extends State<SingleProduct> {


  String url = "";

  @override
  initState() {
    super.initState();
    print("IL FIREBASE ID DELLO STATO");
    print(widget.firebaseId);
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

    return url.isNotEmpty ? GestureDetector(
        onTap: () {
          widget.singleProductEntity.onTap(widget.singleProductEntity, widget.state);
        },
        child: Container(
          width: 250,
          height: 350,
          child: Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(
                    color: widget.singleProductEntity.isSelected ? background : white,
                    width: 2)),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 130,
                      width: 130,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(3)),
                          color: greyDrag,
                          border: Border.all(
                            color: background,
                            width: 1,
                          ),
                          image: DecorationImage(
                            image: NetworkMemoryImageUtility(
                                isNetwork: true,
                                networkUrl: url,
                                memoryImage: null).provide(),
                            fit: BoxFit.cover,
                          )),
                    ),
                    Padding(
                      padding: getPadding(top: 25),
                      child: Text(
                        widget.singleProductEntity.name,
                        textAlign: TextAlign.center,
                        style: SafeGoogleFont(
                            'Montserrat',
                            fontSize: 14,
                            color: background,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Container(
                      width: 60,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Divider(
                        thickness: 1,
                        color: blackDivider,
                      ),
                    ),
                    Text(
                      "€ ${widget.singleProductEntity.price.replaceAll('.',',')}",
                      style: SafeGoogleFont('Montserrat',
                          fontSize: 14,
                          color: background,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )) :Container( );
  }
}
