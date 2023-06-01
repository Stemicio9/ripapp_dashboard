
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/blocs/SearchProductCubit.dart';
import 'package:ripapp_dashboard/entities/single_product_entity.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/products_row.dart';
import 'package:ripapp_dashboard/widgets/dialog_card.dart';

import '../../../../constants/language.dart';
import '../../../../widgets/action_button.dart';

//ProductsPopup
//_ProductsPopupState
class ProductsPopup extends StatelessWidget {

  final Function() onTap;

  const ProductsPopup({Key? key,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchProductCubit(),
      child: ProductsPopupWrapped(
        onTap: onTap
      ),
    );
  }
}



class ProductsPopupWrapped extends StatefulWidget {
  final Function() onTap;

  const ProductsPopupWrapped({Key? key,required this.onTap}) : super(key: key);

  @override
  State<ProductsPopupWrapped> createState() => _ProductsPopupWrappedState();
}

class _ProductsPopupWrappedState extends State<ProductsPopupWrapped> {


  // fixme change with real data from backend
  // fixme make a bloc and a cubit to manage this situation
  late List<SingleProductEntity> products = List.empty(growable: true);

  SearchProductCubit get _searchProductCubit => context.read<SearchProductCubit>();


  @override
  void initState() {
    // fixme here we use initState only to initialize product list, but is dummy
    // fixme delete this method when bloc will be done
    _searchProductCubit.fetchProducts();

    for(int i = 0; i<10; i++){
      products.add(SingleProductEntity(name: "Prodotto $i", onTap: onProductTapped,price: "100,00"));
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
          width: 1200,
          child: DialogCard(
              cancelIcon: true,
              cardTitle: 'Seleziona i tuoi prodotti',
              child: Column(
                children: [
                Container(
                      height: 450,
                        child: SingleChildScrollView(
                            child:
                              BlocBuilder<SearchProductCubit, SearchProductState>(
                                  builder: (context, state){
                                if (state is SearchProductLoaded){
                                  products.clear();
                                  state.availableProducts.forEach((product) {
                                    products.add(SingleProductEntity(name: product.name ?? "", price: product.price.toString(),
                                        urlImage: "url", isSelected: state.agencyProducts.contains(product), onTap: onProductTapped));
                                  });
                                  return ProductsRow(products: products,);
                                }
                                else
                                  return ErrorWidget("errore");
                              }
                        )
                    ),),
                  Padding(
                    padding: const EdgeInsets.only(right: 30,top: 20),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ActionButtonV2(
                        action: widget.onTap,
                        text: getCurrentLanguageValue(SAVE) ?? "",
                      ),
                    ),
                  )
                ],
              ),

          ),
        ),
      ],
    );
  }
}
