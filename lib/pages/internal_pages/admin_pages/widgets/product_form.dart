
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/blocs/selected_product_cubit.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/images_constants.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/utils/style_utils.dart';
import 'package:ripapp_dashboard/widgets/action_button.dart';
import 'package:ripapp_dashboard/widgets/dialog_card.dart';
import 'package:ripapp_dashboard/widgets/input.dart';

class ProductForm extends StatelessWidget {
  final String cardTitle;
  final TextEditingController nameController;
  final TextEditingController priceController;
  final dynamic nameValidator;
  final dynamic priceValidator;
  final dynamic descriptionValidator;
  final onTap;
  final imageOnTap;
  final String imageFile;


  const ProductForm({
    super.key,
    required this.imageFile,
    required this.imageOnTap,
    required this.onTap,
    required this.cardTitle,
    this.nameValidator,
    this.descriptionValidator,
    this.priceValidator,
    required this.nameController,
    required this.priceController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedProductCubit, SelectedProductState>(
        builder: (context, state) {
      if (state is SelectedProductState) {
        nameController.text = state.selectedProduct.name ?? "";
        if(state.selectedProduct.price != null){
          priceController.text = state.selectedProduct.price.toString();
        }
        return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 600,
            child: DialogCard(
                cancelIcon: true,
                paddingLeft: 10,
                paddingRight: 10,
                cardTitle: cardTitle,
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
                                      onTap: imageOnTap,
                                      child: Container(
                                        height: 130,
                                        width: 130,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(Radius.circular(3)),
                                          border: Border.all(color: background, width: 1),
                                          image: imageFile != "" ? DecorationImage(
                                            image: NetworkImage(imageFile),
                                            fit: BoxFit.contain,
                                          ) : const DecorationImage(
                                            image: AssetImage(ImagesConstants.imgProductPlaceholder),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                       /* child:  CustomImageView(
                                          url: imageFile,
                                          height: getSize(
                                            190,
                                          ),
                                          width: getSize(
                                            190,
                                          ),
                                          alignment: Alignment.center,
                                          fit: BoxFit.cover,
                                          placeHolder: ImagesConstants.placeholderUserUrl,
                                        ), */
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
                                  validator: nameValidator,
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
                                /*  prefixIconHeight: 18,
                                  prefixIconWidth: 18,
                                  prefixIcon: ImagesConstants.imgEuro,
                                  isPrefixIcon: true, */
                                  hinttext: getCurrentLanguageValue(PRICE)!,
                                  controller: priceController,
                                  validator: priceValidator,
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
                          action: onTap,
                          text: getCurrentLanguageValue(SAVE)!,
                        ),
                      ),
                    )
                  ],
                )),
          )
        ],

      ),
    );
      }
      else return ErrorWidget("exception");
        });
  }
}
