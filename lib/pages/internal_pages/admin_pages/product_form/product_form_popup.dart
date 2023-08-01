import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/blocs/selected_product_cubit.dart';
import 'package:ripapp_dashboard/models/product_entity.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/product_form/product_form_widget.dart';
import 'package:uuid/uuid.dart';

class ProductFormPopup extends StatefulWidget {

  final Future<bool> Function() onWillPop;
  ProductEntity? selectedProduct;

  final Function onSubmit;

  ProductFormPopup({Key? key,
    required this.onWillPop,
    this.selectedProduct,
    required this.onSubmit
  }) : super(key: key);

  @override
  State<ProductFormPopup> createState() => _ProductFormPopupState();
}

class _ProductFormPopupState extends State<ProductFormPopup> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var memoryImage;
  bool isNetwork = true;
  late String fileName = "";
  Uint8List? fileBytes;
  SelectedProductCubit get _selectedProductCubit => context.read<SelectedProductCubit>();


  @override
  void initState() {
    widget.selectedProduct ??= ProductEntity.emptyProduct();
    _selectedProductCubit.selectProduct(widget.selectedProduct!);
    assignTextEditingControllerValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedProductCubit, SelectedProductState>(
        builder: (context, state) {
          return WillPopScope(
              onWillPop: widget.onWillPop,
              child: Form(
                key: _formKey,
                child: ProductFormWidget(
                  isAddPopup: widget.selectedProduct?.id != null ? false : true,
                  nameController: nameController,
                  priceController: priceController,
                  save: (){
                    save(state.imageUrl);
                  },
                  clearFields: clearFields,
                  imageUrl: state.imageUrl,
                  onTap: formImageOnTap,
                  isNetwork: isNetwork,
                  memoryImage: memoryImage,
                ),
              )

          );
        });
  }

  assignTextEditingControllerValues(){
    nameController.text = widget.selectedProduct?.name ?? '';
    if(widget.selectedProduct?.price != null) {
      priceController.text = widget.selectedProduct?.price.toString() ?? '';
    }
  }

  void clearFields(){
    nameController.clear();
    priceController.clear();
  }

   save(String imageUrl)async{
    if (widget.selectedProduct == null) return;
    if(_formKey.currentState!.validate()) {
      ProductEntity productToSave = widget.selectedProduct!.copyWith(
        name: nameController.text,
        price: double.tryParse(priceController.text),
        photoName: imageUrl,

      );
      var uuid = const Uuid();
      var productId = uuid.v4();

      if (widget.selectedProduct!.id != null) {
        productToSave.id = widget.selectedProduct?.id;
        productToSave.firebaseId =  widget.selectedProduct?.firebaseId;
      } else {
        productToSave.firebaseId = productId;
      }

      await manageImageChange(widget.selectedProduct!.id != null ? widget.selectedProduct?.firebaseId ?? "" : productId);
      widget.onSubmit(productToSave);

    }
  }

  manageImageChange(String productId) async {
    var path = 'profile_images/products_images/productid:$productId/';

    var fileList = await FirebaseStorage.instance.ref(path).listAll();

    if (fileList.items.isNotEmpty && fileName != "") {
      var fileesistente = fileList.items[0];
      fileesistente.delete();
    }
    if (fileName != "") {
      await FirebaseStorage.instance.ref("$path$fileName").putData(fileBytes!);
    }
  }

  formImageOnTap() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      widget.selectedProduct!.photoName = result.files.first.name;
      setState(() {
        fileBytes = result.files.first.bytes!;
        fileName = result.files.first.name;
        isNetwork = false;
        memoryImage = fileBytes;

      });
    }
  }
}
