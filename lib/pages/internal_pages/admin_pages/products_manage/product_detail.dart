import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/blocs/profile_image_cubit.dart';
import 'package:ripapp_dashboard/blocs/selected_product_cubit.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/utils/style_utils.dart';
import 'package:ripapp_dashboard/widgets/dialog_card.dart';
import 'package:ripapp_dashboard/widgets/utilities/network_memory_image_utility.dart';
import '../../../../constants/images_constants.dart';
import '../../../../widgets/texts.dart';

class ProductDetail extends StatefulWidget{

  final String cardTitle;



  ProductDetail({
    super.key,
    required this.cardTitle
  });

  @override
  State<StatefulWidget> createState() {
    return ProductDetailState();
  }

}



class ProductDetailState extends State<ProductDetail> {
  ProfileImageCubit get _profileImageCubit => context.read<ProfileImageCubit>();
  var imageFile = ImagesConstants.imgDemisePlaceholder;
  var memoryImage;
  bool isNetwork = true;

  Future<dynamic> downloadUrlImage(String? firebaseId) async {
     var  fileList = await FirebaseStorage.instance.ref('profile_images/products_images/productid:$firebaseId/').listAll();
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

  void func(value){
    _profileImageCubit.changeLoaded(true);
    imageFile = value;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileImageCubit, ProfileImageState>(
        builder: (context, imageState) {
      print("il nostro link è " + imageFile.toString());
    return BlocBuilder<SelectedProductCubit, SelectedProductState>(
        builder: (context, state) {

      if (state is SelectedProductState) {
      //  downloadUrlImage(state.selectedProduct.firebaseId!).then((value) => func(value));

        return Container(
      padding: getPadding(left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 550,
            child: DialogCard(
                paddingLeft: 10,
                paddingRight: 10,
                cancelIcon: true,
                cardTitle: widget.cardTitle,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                          color: greyDrag,
                          border: Border.all(color: background, width: 1),
                          image: DecorationImage(
                            image:NetworkMemoryImageUtility(
                                isNetwork: isNetwork,
                                networkUrl: state.imageUrl,
                                memoryImage: memoryImage).provide(),
                            fit: BoxFit.cover,

                          )
                      ),
                    ),


                    Padding(
                      padding: getPadding(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                          Padding(
                            padding: getPadding(bottom: 5),
                            child: Text(
                              'ID',
                              style: SafeGoogleFont(
                                'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: background,
                              ),
                            ),
                          ),
                          Texth3V2(testo: state.selectedProduct.id.toString(), color: black),

                          Padding(
                            padding: getPadding(bottom: 5,top: 20),
                            child: Text(
                              'NOME',
                              style: SafeGoogleFont(
                                'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: background,
                              ),
                            ),
                          ),
                          Texth3V2(testo: state.selectedProduct.name ?? "", color: black),

                          Padding(
                            padding: getPadding(bottom: 5,top:20),
                            child: Text(
                              'PREZZO',
                              style: SafeGoogleFont(
                                'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: background,
                              ),
                            ),
                          ),
                          Texth3V2(
                              testo: '€ ${state.selectedProduct.price}',
                              color: black
                          ),

                        ],
                      ),
                    ),

                  ],
                )

            ),
          )
        ],
      ),
    );
      }
      else return ErrorWidget("exception");
        });});
  }
}
