import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ripapp_dashboard/blocs/CurrentPageCubit.dart';
import 'package:ripapp_dashboard/blocs/SearchProductsOfferedCubit.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget/action.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget/empty_table_content.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget/table_row_element.dart';
import 'package:ripapp_dashboard/models/ProductOffered.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/products_popup.dart';
import 'package:ripapp_dashboard/pages/internal_pages/page_header.dart';
import 'package:ripapp_dashboard/repositories/agency_repository.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/widgets/circular_progress_indicator.dart';
import 'package:ripapp_dashboard/widgets/scaffold.dart';

class ProductsSelectedPage extends StatefulWidget {
  const ProductsSelectedPage({Key? key}) : super(key: key);
  @override
  State<ProductsSelectedPage> createState() => _ProductsSelectedPageState();
}

class _ProductsSelectedPageState extends State<ProductsSelectedPage> {

  CurrentPageCubit get _currentPageCubit => context.read<CurrentPageCubit>();
  SearchProductsOfferedCubit get _searchProductCubit => context.read<SearchProductsOfferedCubit>();

  void changeAgencyProducts(List<ProductOffered> productsOffered){
    AgencyRepository().setAgencyProducts(productsOffered);
     context.pop();
    _searchProductCubit.changeSelectedProducts();
  }

  @override
  void initState() {
    _currentPageCubit.loadPage(ScaffoldWidgetState.agency_products_page, 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentPageCubit, CurrentPageState>
      (builder: (_,state) {
      if(state.loading){
        return const CircularProgressIndicatorWidget();
      }
      List<TableRowElement> tableRowElements = state.resultSet as List<TableRowElement>;
      if(tableRowElements.isEmpty){
        return EmptyTableContent(
          emptyMessage: 'Nessun prodotto selezionato',
          showBackButton: false,
          actions: composeSuperiorActions(),
          pageTitle: 'I miei prodotti',
        );
      }
      return Padding(
        padding: getPadding(top: 30, bottom: 30, left: 5, right: 5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const PageHeader(
                showBackButton: false,
                pageTitle: 'I miei prodotti',
              ),
              DataTableWidget(
                  dataRowHeight: 85,
                  headers: tableRowElements[0].getHeaders(),
                  rows: tableRowElements,
                  superiorActions: composeSuperiorActions(),
                  rowActions: []
              ),
            ],
          ),
        ),
      );
    });
  }

  List<ActionDefinition> composeSuperiorActions(){
    var actions = <ActionDefinition>[];
    actions.add(ActionDefinition(
      text: "Seleziona prodotti",
      isButton: true,
      action: () {
        showDialog(context: context,
            builder: (ctx)=> ProductsPopup(
                onTap: changeAgencyProducts
            )
        );
      },
    ));
    return actions;
  }
}
