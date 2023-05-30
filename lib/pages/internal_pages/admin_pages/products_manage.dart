import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/widgets/product_detail.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/widgets/product_form.dart';
import 'package:ripapp_dashboard/pages/internal_pages/header.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/widgets/delete_message_dialog.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/widgets/products_table.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';

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
  final String name = 'Nome del prodotto';
  final String id = '1';
  final String price = '50';
  final String productPhoto = 'Foto del prodotto';
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getPadding(top: 60, bottom: 60, left: 5, right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(
            deleteProfileOnTap: (){},
            onTap: (){
              showDialog(context: context, builder: (ctx)=>ProductForm(
                  imageOnTap: (){},

                  onTap: (){
                    Navigator.pop(context);
                  },
                  cardTitle: getCurrentLanguageValue(ADD_PRODUCT)!,
                  nameController: nameController,
                  descriptionController: descriptionController,
                  priceController: priceController
              ));
            },
            pageTitle: getCurrentLanguageValue(PRODUCTS_MANAGE)!,
            buttonText: getCurrentLanguageValue(ADD_PRODUCT)!,
          ),

          ProductsTable(
            delete: (){
              showDialog(
                  context: context,
                  builder: (ctx) => DeleteMessageDialog(
                      onConfirm: (){
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
                  descriptionController: descriptionController,
                  priceController: priceController
              ));
            },


            showDetail: (){
              showDialog(context: context, builder: (ctx)=>ProductDetail(
                  cardTitle: getCurrentLanguageValue(PRODUCT_DETAIL)!,
                  name: name,
                  id: id,
                  price: price,
                  productPhoto: productPhoto)
              );
            },
            detailMessage: detailMessage,
            editMessage: editMessage,
            deleteMessage: deleteMessage,
          )

        ],
      ),
    );
  }

}