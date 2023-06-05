import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/models/ProductOffered.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/widgets/product_detail.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/widgets/product_form.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/agency_products_table.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/products_popup.dart';
import 'package:ripapp_dashboard/pages/internal_pages/header.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/widgets/delete_message_dialog.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/widgets/products_table.dart';
import 'package:ripapp_dashboard/repositories/agency_repository.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';

class MyProducts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyProductsState();
  }
}


class MyProductsState extends State<MyProducts>{
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
  late Image imageFile;

  void changeAgencyProducts(List<ProductOffered> productsOffered){
    print("chiamata senza evento");
    AgencyRepository().setAgencyProducts(productsOffered);
    //Navigator.pop(context);
  }

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
                showDialog(context: context, builder: (ctx)=>
                     ProductsPopup(
                      onTap: (List<ProductOffered> list) => changeAgencyProducts
                      )
                );
              },
              pageTitle: getCurrentLanguageValue(MY_PRODUCTS) ?? "",
              buttonText: getCurrentLanguageValue(SELECT_PRODUCTS) ?? "",
            ),

            AgencyProductsTable()

          ],
        ),
      ),
    );
  }

}