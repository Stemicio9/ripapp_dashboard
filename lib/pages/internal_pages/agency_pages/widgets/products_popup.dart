
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/blocs/SearchProductsOfferedCubit.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/images_constants.dart';
import 'package:ripapp_dashboard/entities/single_product_entity.dart';
import 'package:ripapp_dashboard/models/ProductOffered.dart';
import 'package:ripapp_dashboard/models/product_entity.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/products_row.dart';
import 'package:ripapp_dashboard/widgets/dialog_card.dart';
import 'package:ripapp_dashboard/widgets/texts.dart';

import '../../../../constants/language.dart';
import '../../../../widgets/action_button.dart';

/*
class ProductsPopup extends StatelessWidget {
  final Function(List<ProductOffered>) onTap;
  ProductsPopup({Key? key,required this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchProductCubit(),
      child: ProductsPopupWrapped(onTap: onTap,),
    );
  }
}
*/

class ProductsPopup extends StatefulWidget {
  final Function(List<ProductOffered>) onTap;

  ProductsPopup({Key? key,required this.onTap}) : super(key: key);

  @override
  State<ProductsPopup> createState() => _ProductsPopupState();
}

class _ProductsPopupState extends State<ProductsPopup> {


  // fixme change with real data from backend
  // fixme make a bloc and a cubit to manage this situation
  late List<SingleProductEntity> products = List.empty(growable: true);

  SearchProductsOfferedCubit get _searchProductCubit => context.read<SearchProductsOfferedCubit>();


  @override
  void initState() {
    // fixme here we use initState only to initialize product list, but is dummy
    // fixme delete this method when bloc will be done
    _searchProductCubit.fetchProducts();

    /*
    state.productsOffered.forEach((productOffered) {
      products.add(SingleProductEntity(id: productOffered.productEntity.id!,
          name: productOffered.productEntity.name ?? "",
          price: productOffered.productEntity.price.toString(),
          urlImage: /*productOffered.productEntity.photoName ??*/ ImagesConstants.imgProductPlaceholder,
          isSelected: productOffered.offered,
          onTap: onProductTapped));
    });*/

    /*for(int i = 0; i<10; i++){
      products.add(SingleProductEntity(name: "Prodotto $i", onTap: onProductTapped,price: "100,00"));
    }*/
    super.initState();
  }

  // fixme when a product is tapped, this is the function called
  // fixme change this function when bloc is implemented
  void onProductTapped(SingleProductEntity productEntity, SearchProductsOfferedLoaded state){
    var index = products.indexOf(productEntity);
    print("TAPPATO PRODOTTO IN POSIZIONE $index");
    print("prima il PRODOTTO IN POSIZIONE $index è " + products[index].isSelected.toString());
    products[index].isSelected = !products[index].isSelected;
    print("dopo il PRODOTTO IN POSIZIONE $index è " + products[index].isSelected.toString());

    if (state is SearchProductsOfferedLoaded)
      state.productsOffered[index].offered = products[index].isSelected;
    print(state.productsOffered);
    List<SingleProductEntity> copy = List.from(products);
    setState(() {
      products = copy;
    });
  }


  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
           SingleChildScrollView(
            child:   Container(
                  width: 1200,
                  child: DialogCard(
                    cancelIcon: true,
                    cardTitle: 'Seleziona i tuoi prodotti',
                    child:
                    BlocBuilder<SearchProductsOfferedCubit, SearchProductsOfferedState>(
                        builder: (context, state) {
                          if(state is SearchProductsOfferedLoading){
                            return const Center(child: CircularProgressIndicator());
                          }
                          else if (state is SearchProductsOfferedLoaded) {
                            products.clear();
                            state.productsOffered.forEach((
                                productOffered) {
                              products.add(SingleProductEntity(
                                  id: productOffered.productEntity.id!,
                                  name: productOffered.productEntity.name ?? "",
                                  price: productOffered.productEntity.price.toString(),
                                  urlImage: /*productOffered.productEntity.photoName ??*/ ImagesConstants.imgProductPlaceholder,
                                  isSelected: productOffered.offered,
                                  onTap: onProductTapped));
                            });
                            return
                              Column(
                                children: [
                                  Container(
                                      height: 450,
                                      child: SingleChildScrollView(
                                          child:
                                          ProductsRow(
                                              products: products,
                                              state: state)
                                      )
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 30, top: 20),
                                    child: Align(
                                      alignment: Alignment
                                          .centerRight,
                                      child: ActionButtonV2(
                                        action: () {widget.onTap(
                                            state.productsOffered);
                                        },
                                        text: getCurrentLanguageValue(
                                            SAVE) ?? "",
                                      ),
                                    ),
                                  )
                                ],
                              );
                          }
                          else if(state is SearchProductsOfferedEmpty) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 40),
                                child: Texth2V2(
                                    testo: 'Non ci sono prodotti da mostrare',
                                    weight: FontWeight.bold,
                                    color: background
                                ),
                              ),
                            );
                          }
                          else {
                            return ErrorWidget("errore");
                          }
                        }),
                  )),
                )],
            )
      );
  }
}
