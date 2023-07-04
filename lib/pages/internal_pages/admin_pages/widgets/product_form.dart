
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
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/utils/style_utils.dart';
import 'package:ripapp_dashboard/widgets/action_button.dart';
import 'package:ripapp_dashboard/widgets/dialog_card.dart';
import 'package:ripapp_dashboard/widgets/input.dart';
import 'package:ripapp_dashboard/widgets/snackbars.dart';
import 'package:ripapp_dashboard/widgets/utilities/network_memory_image_utility.dart';
import 'package:uuid/uuid.dart';

class ProductForm extends StatefulWidget{

  final String cardTitle;
  bool isEdit = false;

  ProductForm({
    super.key,
    required this.cardTitle,
    required this.isEdit
  });
  @override
  State<StatefulWidget> createState() {
    return ProductFormState();
  }

}

class ProductFormState extends State<ProductForm> {
  ProfileImageCubit get _profileImageCubit => context.read<ProfileImageCubit>();
  SearchProductCubit get _searchProductsCubit => context.read<SearchProductCubit>();

  var imageFile = ImagesConstants.imgDemisePlaceholder;
  var memoryImage;
  bool isNetwork = true;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late String fileName = "";
  late Uint8List fileBytes;


  Future<dynamic> downloadUrlImage(String? firebaseId) async {
    var fileList;
    if(widget.isEdit){
      fileList = await FirebaseStorage.instance.ref('profile_images/products_images/productid:$firebaseId/').listAll();
      for (var element in fileList.items) {
        print(element.name);
      }
    }
    if (fileList.items.isEmpty) {
      var fileList = await FirebaseStorage.instance.ref('profile_images/').listAll();
      var file = fileList.items[0];
      var result = await file.getDownloadURL();
      return result;
    }
    var file = fileList.items[0];
    var result = await file.getDownloadURL();
    return result;
  }

  void func(value){
    _profileImageCubit.changeLoaded(true);
    imageFile = value;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileImageCubit, ProfileImageState>(
        builder: (context, imageState) {
          print("il nostro link è " + imageFile.toString());


          return BlocBuilder<SelectedProductCubit, SelectedProductState>(
              builder: (context, state) {

                if(widget.isEdit){
                  downloadUrlImage(state.selectedProduct.firebaseId!).then((value) => func(value));
                  nameController.text = state.selectedProduct.name ?? nameController.text;
                  priceController.text = state.selectedProduct.price.toString();
                }else{
                  downloadUrlImage(null).then((value) => func(value));
                  nameController.text = "";
                  priceController.text = "";
                }


                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 600,
                            child: DialogCard(
                                cancelIcon: true,
                                paddingLeft: 10,
                                paddingRight: 10,
                                cardTitle: widget.cardTitle,
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 30),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: getPadding(bottom: 5),
                                                    child: Text(
                                                      'FOTO',
                                                      style: SafeGoogleFont(
                                                        'Montserrat',
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w600,
                                                        color: background,
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                      onTap: () async {
                                                        FilePickerResult? result = await FilePicker.platform.pickFiles();
                                                        if (result != null) {
                                                          fileBytes = result.files.first.bytes!;
                                                          fileName = result.files.first.name;
                                                          print('STAMPO IL FILE PICKATO');
                                                          print(fileName);

                                                          isNetwork = false;
                                                          setState(() {
                                                            memoryImage = fileBytes;
                                                          });
                                                        }
                                                      },
                                                      child: Container(
                                                        height: 130,
                                                        width: 130,
                                                        decoration: BoxDecoration(
                                                          borderRadius: const BorderRadius.all(Radius.circular(3)),
                                                          border: Border.all(color: background, width: 1),
                                                          image:  DecorationImage(
                                                            image: NetworkMemoryImageUtility(
                                                                isNetwork: isNetwork,
                                                                networkUrl: imageFile,
                                                                memoryImage: memoryImage).provide(),
                                                                fit: BoxFit.cover,

                                                          ),
                                                        ),

                                                      )

                                                  )
                                                ],
                                              ),
                                            )),

                                        Expanded(
                                            flex: 2,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: getPadding(bottom: 5),
                                                  child: Text(
                                                    'NOME',
                                                    style: SafeGoogleFont(
                                                      'Montserrat',
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w600,
                                                      color: background,
                                                    ),
                                                  ),
                                                ),
                                                InputsV2Widget(
                                                  hinttext: getCurrentLanguageValue(NAME)!,
                                                  controller: nameController,
                                                  validator: notEmptyValidate,
                                                  paddingLeft: 0,
                                                  paddingRight: 0,
                                                  borderSide: const BorderSide(color: greyState),
                                                  activeBorderSide: const BorderSide(color: background),
                                                ),

                                                Padding(
                                                  padding: getPadding(bottom: 5,top: 20),
                                                  child: Text(
                                                    'PREZZO',
                                                    style: SafeGoogleFont(
                                                      'Montserrat',
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w600,
                                                      color: background,
                                                    ),
                                                  ),
                                                ),
                                                InputsV2Widget(
                                                  hinttext: getCurrentLanguageValue(PRICE)!,
                                                  controller: priceController,
                                                  validator: notEmptyValidate,
                                                  // keyboard: TextInputType.numberWithOptions(decimal: true, signed: false),
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                                                  ],
                                                  paddingRight: 0,
                                                  paddingLeft: 0,
                                                  borderSide: const BorderSide(color: greyState),
                                                  activeBorderSide: const BorderSide(color: background),
                                                )

                                              ],
                                            )
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: getPadding(top: 40),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: ActionButtonV2(
                                          action: formSubmit,
                                          text: getCurrentLanguageValue(SAVE)!,
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                          )
                        ],

                      ),
                    ),
                  );

              });
        });
  }


  formSubmit() async{
    if (_formKey.currentState!.validate()) {
      ProductEntity productEntity = ProductEntity(
        name: nameController.text,
        price: double.tryParse(priceController.text),
        photoName: imageFile,
      );
      var uuid = const Uuid();
      var productId = uuid.v4();
      productEntity.firebaseId = productId;


      if(widget.isEdit){
        SuccessSnackbar(context, text: 'Prodotto modificato con successo!');

      }else{
        _searchProductsCubit.saveProduct(productEntity);
        /*    if (_searchProductsCubit.state is SaveProductLoaded){
         var state = _searchProductsCubit.state as SaveProductLoaded;
         state.productSaved.id;
         print("id del prodotto salvato = " + state.productSaved.id.toString());
       } */

        var path = 'profile_images/products_images/productid:$productId/';

        var fileList = await FirebaseStorage.instance.ref(path).listAll();
        if (fileList.items.isNotEmpty) {
          var fileesistente = fileList.items[0];
          fileesistente.delete();
        }
        if(fileName != "") {
          await FirebaseStorage.instance.ref("$path$fileName").putData(fileBytes);
        }
        SuccessSnackbar(context, text: 'Prodotto aggiunto con successo!');

      }

      nameController.text = "";
      priceController.text = "";

      Navigator.pop(context);
    }
  }
}
