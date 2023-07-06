import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/blocs/SearchProductCubit.dart';
import 'package:ripapp_dashboard/blocs/profile_image_cubit.dart';
import 'package:ripapp_dashboard/blocs/selected_product_cubit.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/images_constants.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/constants/validators.dart';
import 'package:ripapp_dashboard/models/product_entity.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/products_manage/product_form_image.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/products_manage/product_form_inputs.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/utils/style_utils.dart';
import 'package:ripapp_dashboard/widgets/action_button.dart';
import 'package:ripapp_dashboard/widgets/dialog_card.dart';
import 'package:ripapp_dashboard/widgets/input.dart';
import 'package:ripapp_dashboard/widgets/snackbars.dart';
import 'package:ripapp_dashboard/widgets/utilities/network_memory_image_utility.dart';
import 'package:uuid/uuid.dart';

class ProductForm extends StatefulWidget {
  final String cardTitle;
  bool isEdit = false;

  ProductForm({super.key, required this.cardTitle, required this.isEdit});

  @override
  State<StatefulWidget> createState() {
    return ProductFormState();
  }
}

class ProductFormState extends State<ProductForm> {
  SearchProductCubit get _searchProductsCubit => context.read<SearchProductCubit>();
  SelectedProductCubit get _selectedProductsCubit => context.read<SelectedProductCubit>();
  var memoryImage;
  bool isNetwork = true;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late String fileName = "";
  Uint8List? fileBytes;

  manageImageChange(String productId) async {
    var path = 'profile_images/products_images/productid:$productId/';

    var fileList = await FirebaseStorage.instance.ref(path).listAll();
    if (fileList.items.isNotEmpty) {
      var fileesistente = fileList.items[0];
      fileesistente.delete();
    }
    print("stampo filename");
    print(fileName);

    if (fileName.isNotEmpty && fileBytes != null) {
        await FirebaseStorage.instance.ref("$path$fileName").putData(fileBytes!);
    }
  }

  formSubmit(imageFile, id) async {
    if (_formKey.currentState!.validate()) {
      ProductEntity productEntity = ProductEntity(
        name: nameController.text,
        price: double.tryParse(priceController.text),
        photoName: imageFile,
      );

      productEntity.id = id;
      var uuid = const Uuid();
      var productId = uuid.v4();
      productEntity.firebaseId = productId;
      if (widget.isEdit) {
        _searchProductsCubit.editProduct(productEntity);
        SuccessSnackbar(context, text: 'Prodotto modificato con successo!');
      } else {
        _searchProductsCubit.saveProduct(productEntity);
        SuccessSnackbar(context, text: 'Prodotto aggiunto con successo!');
      }

      await manageImageChange(productId);
      nameController.text = "";
      priceController.text = "";

      Navigator.pop(context);
    }
  }

  formImageOnTap() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      _selectedProductsCubit.state.imageUrl = result.files.first.name;
      setState(() {
        fileBytes = result.files.first.bytes!;
        fileName = result.files.first.name;
        isNetwork = false;
        memoryImage = fileBytes;

      });
    }
  }

  composeProductForm(imageUrl, int? id) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 600,
                    child: DialogCard(
                        cancelIcon: true,
                        paddingLeft: 10,
                        paddingRight: 10,
                        cardTitle: widget.cardTitle,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Padding(
                                      padding: const EdgeInsets.only(right: 30),
                                      child: ProductFormImage(
                                                imageUrl: imageUrl,
                                                onTap: formImageOnTap,
                                                isNetwork: isNetwork,
                                                memoryImage: memoryImage),
                                          )),
                              Expanded(
                                  flex: 2,
                                  child: ProductFormInputs(
                                            nameController: nameController,
                                            priceController: priceController,
                                            action: () {
                                              formSubmit(imageUrl, id);
                                            })
                                      )
                            ])))
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedProductCubit, SelectedProductState>(
        builder: (context, state) {
      nameController.text = "";
      priceController.text = "";
      print("SONO APPENA ENTRATO NEL BLOC");
      print(state.imageUrl);
      if (widget.isEdit) {
        nameController.text = state.selectedProduct.name ?? nameController.text;
        priceController.text = state.selectedProduct.price.toString();
        fileName = state.imageUrl;
      }
      return widget.isEdit
          ? composeProductForm(state.imageUrl, state.selectedProduct.id)
          : composeProductForm(ImagesConstants.imgDemisePlaceholder, null);
    });
  }

}
