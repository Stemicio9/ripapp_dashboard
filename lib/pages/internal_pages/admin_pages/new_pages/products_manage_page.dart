import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ripapp_dashboard/blocs/CurrentPageCubit.dart';
import 'package:ripapp_dashboard/blocs/SearchProductCubit.dart';
import 'package:ripapp_dashboard/blocs/selected_product_cubit.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/data_table/data_table_paginator/data_table_paginator_data.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget/action.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget/empty_table_content.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget/table_row_element.dart';
import 'package:ripapp_dashboard/models/product_entity.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/product_form/product_detail.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/product_form/product_form_popup.dart';
import 'package:ripapp_dashboard/pages/internal_pages/page_header.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/widgets/circular_progress_indicator.dart';
import 'package:ripapp_dashboard/widgets/delete_message_dialog.dart';
import 'package:ripapp_dashboard/widgets/dialog_card.dart';
import 'package:ripapp_dashboard/widgets/scaffold.dart';
import 'package:ripapp_dashboard/widgets/snackbars.dart';
import 'package:ripapp_dashboard/widgets/utilities/firebase_image_utility.dart';

class ProductsManagePage extends StatefulWidget {
  const ProductsManagePage({Key? key}) : super(key: key);

  @override
  State<ProductsManagePage> createState() => ProductsManagePageState();
}

class ProductsManagePageState extends State<ProductsManagePage> {

  CurrentPageCubit get _currentPageCubit => context.read<CurrentPageCubit>();
  SelectedProductCubit get _selectedProductCubit => context.read<SelectedProductCubit>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    _currentPageCubit.loadPage(ScaffoldWidgetState.products_page, 0);
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
          emptyMessage: 'Nessun prodotto inserito',
          showBackButton: false,
          actions: composeSuperiorActions(),
          pageTitle: 'Gestisci prodotti',
        );
      }
      return SingleChildScrollView(
        padding: getPadding(top: 30, bottom: 30, left: 5, right: 5),
        child: Column(
          children: [
            const PageHeader(
              showBackButton: false,
              pageTitle: "Gestisci prodotti",
            ),
            DataTableWidget(
                dataRowHeight: 85,
                headers: tableRowElements[0].getHeaders(),
                rows: tableRowElements,
                superiorActions: composeSuperiorActions(),
                rowActions: composeRowActions(),
                data: DataTablePaginatorData(
                    changePageHandle: (index, page) {_currentPageCubit.loadPage(page, index);},
                    pageNumber: state.pageNumber,
                    numPages: state.totalPages,
                    currentPageType: ScaffoldWidgetState.products_page)
            ),
          ],
        ),
      );
    });
  }

  List<ActionDefinition> composeSuperiorActions(){
    var actions = <ActionDefinition>[];
    actions.add(ActionDefinition(
        text: "Aggiungi prodotto",
        isButton: true,
        action: () {
          showDialog(
              context: context,
              builder: (ctx) => composeDialog(ProductEntity.emptyProduct())
          );
        },
        actionInputs: List.empty(growable: true)
    ));
    return actions;
  }

  List<ActionDefinition> composeRowActions(){
    List<ActionDefinition> result = [];
    result.add(viewAction());
    result.add(editAction());
    result.add(deleteAction());
    return result;
  }

  ActionDefinition editAction(){
    ActionDefinition result = ActionDefinition(
        action: (ProductEntity productEntity) async {
          await _selectedProductCubit.selectProduct(productEntity);
          showDialog(
              context: context,
              barrierColor: blackTransparent,
              builder: (ctx) => composeDialog(productEntity)
          );
        },
        icon: Icons.edit_rounded,
        tooltip: "Modifica",
        actionInputs: List.empty(growable: true)
    );
    return result;
  }


  Widget composeDialog(ProductEntity productEntity){
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: getPadding(left: 20, right: 20),
            width: 1000,
            child: DialogCard(
                cardTitle: productEntity.id == null ? getCurrentLanguageValue(ADD_PRODUCT) ?? "" :
                getCurrentLanguageValue(EDIT_PRODUCT) ?? "",
                cancelIcon: true,
                paddingLeft: 10,
                paddingRight: 10,
                child: ProductFormPopup(
                  onWillPop: () {
                    return Future.value(true);
                  },
                  selectedProduct: productEntity,
                  onSubmit: (ProductEntity internalProductEntity){
                    productEntity.id == null ? _currentPageCubit.addProduct(internalProductEntity) :
                    _currentPageCubit.editProduct(internalProductEntity);
                    context.pop();
                  },
                )
            ),

          ),
        ],
      ),
    );
  }

  ActionDefinition deleteAction(){
    ActionDefinition result = ActionDefinition(
        action: (ProductEntity productEntity){
          showDialog(
              context: context,
              builder: (ctx) => DeleteMessageDialog(
                  onConfirm: () async {
                    _currentPageCubit.deleteProduct(productEntity.id!).then((deleteProductMessage) async {
                      FirebaseImageUtility.deleteProductImage(productEntity.firebaseId);
                      SuccessSnackbar(context, text: "Prodotto eliminato con successo");
                    }, onError: (e) {
                      if (e.toString().contains("il prodotto è già in uso da parte di")) {
                        ErrorSnackbar(context, text: 'Prodotto usato da agenzie');
                      }
                    }
                    );
                    context.pop();

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
                                  Text('Prodotto non eliminato perchè ${state.errorMessage}'),
                                ],
                              ),
                              duration: const Duration(milliseconds: 4000),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3),
                              ),
                            );
                          }
                          else {
                            return SnackBar(
                              backgroundColor: green,
                              content: const Row(
                                children: [
                                  Padding(
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
                        });

                  },
                  onCancel: (){
                    context.pop();
                  },
                  message: 'Le informazioni riguardanti questo prodotto verranno definitivamente eliminate. Sei sicuro di volerle eliminare?'
              )
          );
        },
        icon: Icons.delete_rounded,
        tooltip: "Elimina",
        actionInputs: List.empty(growable: true)
    );
    return result;
  }

  ActionDefinition viewAction(){
    ActionDefinition result = ActionDefinition(
        action: (ProductEntity productEntity) {
          _selectedProductCubit.selectProduct(productEntity);
          showDialog(
              context: context,
              builder: (ctx)=> ProductDetail(
                cardTitle: getCurrentLanguageValue(PRODUCT_DETAIL)!,
              ));
        },
        icon: Icons.remove_red_eye_rounded,
        tooltip: "Dettaglio",
        actionInputs: List.empty(growable: true)
    );
    return result;
  }
}
