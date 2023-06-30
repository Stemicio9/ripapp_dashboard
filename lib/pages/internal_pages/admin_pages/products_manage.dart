import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/blocs/SearchProductCubit.dart';
import 'package:ripapp_dashboard/blocs/selected_product_cubit.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/widgets/product_detail.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/widgets/product_form.dart';
import 'package:ripapp_dashboard/pages/internal_pages/header.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/widgets/delete_message_dialog.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/widgets/products_table.dart';
import 'package:ripapp_dashboard/repositories/product_repository.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
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
  SelectedProductCubit get _selectedProductCubit => context.read<SelectedProductCubit>();
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
                    builder: (ctx)=>  ProductForm(
                      isEdit: false,
                      cardTitle: getCurrentLanguageValue(ADD_PRODUCT)!,
                ),
                    );
              },
              pageTitle: getCurrentLanguageValue(PRODUCTS_MANAGE)!,
              buttonText: getCurrentLanguageValue(ADD_PRODUCT)!,
            ),

            ProductsTable(
              delete: (dynamic p){
                showDialog(
                    context: context,
                    builder: (ctx) => DeleteMessageDialog(
                        onConfirm: () async {
                          ProductRepository().deleteProduct(p.id).then((deleteProductMessage) {
                            SuccessSnackbar(context, text: "Prodotto eliminato con successo");
                          }, onError: (e) {
                            if (e.toString().contains("il prodotto è già in uso da parte di"))
                              ErrorSnackbar(context, text: 'Prodotto usato da agenzie');
                              }
                          );

                          final User user = FirebaseAuth.instance.currentUser!;
                          final uid = user.uid;
                          var path = 'profile_images/products_images/productid:${p.firebaseId}/';

                          var fileList = await FirebaseStorage.instance.ref(path).listAll();
                          if (fileList.items.isNotEmpty) {
                            var fileesistente = fileList.items[0];
                            fileesistente.delete();
                          }

                          Navigator.pop(context);
                          BlocBuilder<SearchProductCubit, SearchProductState>(
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
                          });

                        },
                        onCancel: (){
                          Navigator.pop(context);
                        },
                        message: message
                    )
                );
              },


              edit: (dynamic p){
                _selectedProductCubit.selectProduct(p);
                showDialog(
                    context: context,
                    builder: (ctx)=>
               ProductForm(
                 cardTitle: getCurrentLanguageValue(EDIT_PRODUCT)!,
                 isEdit: true,
               ));
              },


              showDetail: (dynamic p){
                _selectedProductCubit.selectProduct(p);
                showDialog(
                    context: context,
                    builder: (ctx)=> ProductDetail(
                    cardTitle: getCurrentLanguageValue(PRODUCT_DETAIL)!,
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


}