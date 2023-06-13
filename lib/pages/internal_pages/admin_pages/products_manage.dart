import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:ripapp_dashboard/blocs/SearchProductCubit.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/models/product_entity.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/widgets/product_detail.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/widgets/product_form.dart';
import 'package:ripapp_dashboard/pages/internal_pages/header.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/widgets/delete_message_dialog.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/widgets/products_table.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import '../../../constants/colors.dart';

class ProductsManage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProductsManageState();
  }
}

class ProductsManageState extends State<ProductsManage>{
  final String detailMessage = 'Dettagli';
  final String editMessage = 'Modifica';
  final String deleteMessage = 'Elimina';
  final String message = 'Le informazioni riguardanti questo prodotto verranno definitivamente eliminate. Sei sicuro di volerle eliminare?';
  final String productPhoto = 'Foto del prodotto';
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  late String imageFile;

  SearchProductCubit get _searchProductsCubit => context.read<SearchProductCubit>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: getPadding(top: 60, bottom: 60, left: 5, right: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(
              deleteProfileOnTap: (){},
              onTap: (){
                showDialog(
                    context: context,
                    builder: (ctx)=>ProductForm(
                        imageOnTap: () async {
                          Image? pickedImage = await ImagePickerWeb.getImageAsWidget();
                          var photoName = pickedImage!.semanticLabel;
                          print('STAMPO NOME FILE PICKATO');
                          print(photoName);

                          setState(() {
                            imageFile = photoName!;
                          });

                          //TODO SALVARE IMMAGINE SU FIRESTORAGE
                           final storageRef = FirebaseStorage.instance.ref();
                           final path = "profile_images/products_images/$imageFile";
                           final imageRef = storageRef.child(path);
                         //  imageRef.putFile(pickedImage);

                        },
                    onTap: (){formSubmit();},
                    cardTitle: getCurrentLanguageValue(ADD_PRODUCT)!,
                    nameController: nameController,
                    priceController: priceController
                ));
              },
              pageTitle: getCurrentLanguageValue(PRODUCTS_MANAGE)!,
              buttonText: getCurrentLanguageValue(ADD_PRODUCT)!,
            ),

            ProductsTable(
              delete: (dynamic p){
                showDialog(
                    context: context,
                    builder: (ctx) => DeleteMessageDialog(
                        onConfirm: (){
                          _searchProductsCubit.delete(p.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: green,
                              content: const Text('Prodotto eliminato con successo!'),
                              duration: const Duration(milliseconds: 3000),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          );
                          Navigator.pop(context);
                        },
                        onCancel: (){
                          Navigator.pop(context);
                        },
                        message: message
                    )
                );
              },
              edit: (){
                showDialog(context: context, builder: (ctx)=>ProductForm(
                    imageOnTap: (){},

                    onTap: (){
                      Navigator.pop(context);
                    },
                    cardTitle: getCurrentLanguageValue(EDIT_PRODUCT)!,
                    nameController: nameController,
                    priceController: priceController
                ));
              },


              showDetail: (dynamic p){
                showDialog(context: context, builder: (ctx)=>ProductDetail(
                    cardTitle: getCurrentLanguageValue(PRODUCT_DETAIL)!,
                    name: p.name,
                    id: p.id,
                    price: p.price,
                    productPhoto: productPhoto
                )
                );
              },
              detailMessage: detailMessage,
              editMessage: editMessage,
              deleteMessage: deleteMessage,
            )
          ],
        ),
      ),
    );
  }

  formSubmit(){
    ProductEntity productEntity = ProductEntity();
    productEntity.name = nameController.text;
    productEntity.price = double.tryParse(priceController.text);
    productEntity.photoName = nameController.text;
    _searchProductsCubit.saveProduct(productEntity);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: green,
        content: const Text('Prodotto aggiunto con successo!'),
        duration: const Duration(milliseconds: 3000),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
    Navigator.pop(context);
  }

}