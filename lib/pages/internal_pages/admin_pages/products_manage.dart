import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:ripapp_dashboard/blocs/SearchProductCubit.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/constants/validators.dart';
import 'package:ripapp_dashboard/models/product_entity.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/widgets/product_detail.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/widgets/product_form.dart';
import 'package:ripapp_dashboard/pages/internal_pages/header.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/widgets/delete_message_dialog.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/widgets/products_table.dart';
import 'package:ripapp_dashboard/repositories/product_repository.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/widgets/scaffold.dart';
import '../../../constants/colors.dart';
import '../../../widgets/snackbars.dart';

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
  final _formKey = GlobalKey<FormState>();
  final _editKey = GlobalKey<FormState>();


  SearchProductCubit get _searchProductsCubit => context.read<SearchProductCubit>();

  @override
  Widget build(BuildContext context) {
    return

      //BlocBuilder<SearchProductCubit, SearchProductState>(
      //    builder: (context, state) {

      SingleChildScrollView(
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
                    builder: (ctx)=> Form(
                      key: _formKey,
                      child: ProductForm(
                          imageOnTap: () async {
                            Image? pickedImage = await ImagePickerWeb.getImageAsWidget();
                            var photoName = pickedImage!.semanticLabel;
                            print('STAMPO NOME FILE PICKATO');
                            print(photoName);

                            setState(() {
                              imageFile = photoName!;
                            });

                            //TODO SALVARE IMMAGINE SU FIRESTORAGE
                           //  final storageRef = FirebaseStorage.instance.ref();
                            // final path = "profile_images/products_images/$imageFile";
                            // final imageRef = storageRef.child(path);
                           //  imageRef.putFile(pickedImage);

                          },
                      onTap: (){formSubmit();},
                      cardTitle: getCurrentLanguageValue(ADD_PRODUCT)!,
                      nameController: nameController,
                      priceController: priceController,
                        nameValidator: notEmptyValidate,
                        priceValidator: notEmptyValidate,
                ),
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
                          //_searchProductsCubit.delete(p.id);
                          ProductRepository().deleteProduct(p.id).then((deleteProductMessage) {
                            SuccessSnackbar(context, text: "Prodotto eliminato con successo");
                          }, onError: (e) {
                            if (e.toString().contains("il prodotto è già in uso da parte di"))
                              ErrorSnackbar(context, text: 'Prodotto usato da agenzie');
                              }
                          );

                          Navigator.pop(context);
                          /*BlocBuilder<SearchProductCubit, SearchProductState>(
                             builder: (context, state) {
                            if (state is SearchProductError) {
                               return SnackBar(
                                backgroundColor: rossoopaco,
                                content:  Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Icon(Icons.warning_amber_rounded, color: white),
                                    ),
                                    Text('Prodotto non eliminato perchè ' + state.errorMessage),
                                  ],
                                ),
                                duration: const Duration(milliseconds: 4000),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              );

                              //ErrorSnackbar(context,
                              //    text: 'Prodotto non eliminato perchè ' +
                              //        state.errorMessage);
                            }
                            else {
                              return SnackBar(
                                backgroundColor: green,
                                content: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Icon(Icons.check_circle_outline_rounded, color: white),
                                    ),
                                    Text('Prodotto eliminato con successo!'),
                                  ],
                                ),
                                duration: const Duration(milliseconds: 4000),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              );
                            }
                            return Container();
                          });*/




                        },
                        onCancel: (){
                          Navigator.pop(context);
                        },
                        message: message
                    )
                );
              },
              edit: (){
                showDialog(context: context, builder: (ctx)=>
                    Form(
                      key: _editKey,
                      child: ProductForm(
                      imageOnTap: (){},
                      onTap: (){
                      if (_editKey.currentState!.validate()) {
                        nameController.text = "";
                        priceController.text = "";
                        SuccessSnackbar(context, text: 'Prodotto modificato con successo!');

                        Navigator.pop(context);
                        }
                      },
                      cardTitle: getCurrentLanguageValue(EDIT_PRODUCT)!,
                      nameController: nameController,
                      priceController: priceController,
                        nameValidator: notEmptyValidate,
                        priceValidator: notEmptyValidate,
                ),
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

         // });

  }

  formSubmit() {
    if (_formKey.currentState!.validate()) {
      ProductEntity productEntity = ProductEntity(
        name: nameController.text,
        price: double.tryParse(priceController.text),
        //TODO SALVARE CORRETTAMENTE LA FOTO
        photoName:  nameController.text,
      );
      _searchProductsCubit.saveProduct(productEntity);

      nameController.text = "";
      priceController.text = "";

      SuccessSnackbar(context, text: 'Prodotto aggiunto con successo!');

      Navigator.pop(context);
    }
  }
}