

import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/entities/single_product_entity.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/products_row.dart';
import 'package:ripapp_dashboard/widgets/dialog_card.dart';

class ProductsPopup extends StatefulWidget {
  const ProductsPopup({Key? key}) : super(key: key);

  @override
  State<ProductsPopup> createState() => _ProductsPopupState();
}

class _ProductsPopupState extends State<ProductsPopup> {


  // fixme change with real data from backend
  // fixme make a bloc and a cubit to manage this situation
  late List<SingleProductEntity> products = List.empty(growable: true);

  @override
  void initState() {
    // fixme here we use initState only to initialize product list, but is dummy
    // fixme delete this method when bloc will be done
    for(int i = 0; i<10; i++){
      products.add(SingleProductEntity(name: "Prodotto $i", onTap: onProductTapped));
    }
    super.initState();
  }

  // fixme when a product is tapped, this is the function called
  // fixme change this function when bloc is implemented
  void onProductTapped(SingleProductEntity productEntity){
    var index = products.indexOf(productEntity);
    print("TAPPATO PRODOTTO IN POSIZIONE $index");
    products[index].isSelected = !products[index].isSelected;
    List<SingleProductEntity> copy = List.from(products);
    setState(() {
      products = copy;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 750,
          child: DialogCard(
              cardTitle: 'Seleziona i tuoi prodotti',
              child: ProductsRow(products: products,)
          ),
        ),
      ],
    );
  }
}
