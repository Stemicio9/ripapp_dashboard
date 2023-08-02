import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/blocs/SearchProductsOfferedCubit.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/models/ProductOffered.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/agency_products_table.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/products_popup.dart';
import 'package:ripapp_dashboard/pages/internal_pages/header.dart';
import 'package:ripapp_dashboard/repositories/agency_repository.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';





class MyProducts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyProductsState();
  }
}


class MyProductsState extends State<MyProducts>{
  SearchProductsOfferedCubit get _searchProductCubit => context.read<SearchProductsOfferedCubit>();
  final String detailMessage = 'Dettagli';
  final String editMessage = 'Modifica';
  final String deleteMessage = 'Elimina';
  final String message = 'Le informazioni riguardanti questo prodotto verranno definitivamente eliminate. Sei sicuro di volerle eliminare?';
  final String productPhoto = 'Foto del prodotto';

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  late Image imageFile;



  void changeAgencyProducts(List<ProductOffered> productsOffered){
    AgencyRepository().setAgencyProducts(productsOffered);
    Navigator.pop(context);
    _searchProductCubit.changeSelectedProducts();
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
                showDialog(context: context,
                    builder: (ctx)=> ProductsPopup(
                        onTap: changeAgencyProducts
                    )
                );
              },
              pageTitle: getCurrentLanguageValue(MY_PRODUCTS) ?? "",
              buttonText: getCurrentLanguageValue(SELECT_PRODUCTS) ?? "",
            ),
            /*Builder(builder: (context) {
               return AgencyProductsTable();
            }*/
            AgencyProductsTable()

          ],
        ),
      ),
    );
  }

}