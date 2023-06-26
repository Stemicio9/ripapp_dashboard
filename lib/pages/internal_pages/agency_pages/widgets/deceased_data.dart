
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/constants/images_constants.dart';
import 'package:ripapp_dashboard/models/city_from_API.dart';
import 'package:ripapp_dashboard/widgets/autocomplete.dart';

import '../../../../blocs/city_list_cubit.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/language.dart';
import '../../../../utils/size_utils.dart';
import '../../../../utils/style_utils.dart';
import '../../../../widgets/input.dart';
import '../../../../widgets/texts.dart';

class DeceasedData extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController cityController;
  final TextEditingController lastNameController;
  final TextEditingController ageController;
  final TextEditingController dateController;
  final TextEditingController citiesController;
  final TextEditingController filterController;

  final dynamic nameValidator;
  final dynamic phoneValidator;
  final dynamic lastNameValidator;
  final dynamic ageValidator;
  final dynamic dateValidator;
  final dynamic citiesOfInterestValidator;
  final dynamic cityValidator;
  final iconOnTap;
  final imageOnTap;
  final onDragDone;
  final onDragUpdated;
  final onDragEntered;
  final onDragExited;
  final Widget child;
  final String imageFile;
  final List<CityFromAPI> options;
  final List<CityFromAPI> citiesOfInterestOptions;

  const DeceasedData({super.key,
    required this.imageOnTap,
    this.nameValidator,
    this.phoneValidator,
    this.cityValidator,
    this.citiesOfInterestValidator,
    this.lastNameValidator,
    this.ageValidator,
    this.dateValidator,
    required this.child,
    required this.onDragDone,
    required this.onDragEntered,
    required this.onDragExited,
    required this.onDragUpdated,
    required this.iconOnTap,
    required this.citiesController,
    required this.nameController,
    required this.phoneController,
    required this.cityController,
    required this.filterController,
    required this.lastNameController,
    required this.ageController,
    required this.options,
    required this.citiesOfInterestOptions,
    required this.imageFile,
    required this.dateController});

  @override
  Widget build(BuildContext context) {
   return MultiBlocProvider(
       providers: [
     BlocProvider(
         create: (_)=> CityListCubit())
       ],
       child: DeceasedDataWidget(
       imageOnTap: imageOnTap,
       nameValidator: nameValidator,
       phoneValidator               :phoneValidator,
       cityValidator                 :cityValidator,
       citiesOfInterestValidator     :citiesOfInterestValidator,
       lastNameValidator       :lastNameValidator,
       ageValidator            : ageValidator,
       dateValidator           : dateValidator,
       child                   : child,
       onDragDone              : onDragDone,
       onDragEntered           : onDragEntered,
       onDragExited            : onDragExited,
       onDragUpdated           : onDragUpdated,
       iconOnTap               : iconOnTap,
       citiesController        : citiesController,
       nameController          : nameController,
       phoneController         : phoneController,
       cityController          : cityController,
       filterController        : filterController,
       lastNameController      : lastNameController,
       ageController           : ageController,
       options                 : options,
       citiesOfInterestOptions : citiesOfInterestOptions,
       imageFile               : imageFile,
       dateController          : dateController
       ));


  }

}


  class DeceasedDataWidget extends StatefulWidget {
    final TextEditingController nameController;
    final TextEditingController phoneController;
    final TextEditingController cityController;
    final TextEditingController lastNameController;
    final TextEditingController ageController;
    final TextEditingController dateController;
    final TextEditingController citiesController;
    final TextEditingController filterController;

    final dynamic nameValidator;
    final dynamic phoneValidator;
    final dynamic lastNameValidator;
    final dynamic ageValidator;
    final dynamic dateValidator;
    final dynamic citiesOfInterestValidator;
    final dynamic cityValidator;
    final iconOnTap;
    final imageOnTap;
    final onDragDone;
    final onDragUpdated;
    final onDragEntered;
    final onDragExited;
    final Widget child;
    final String imageFile;
    final List<CityFromAPI> options;
    final List<CityFromAPI> citiesOfInterestOptions;



    DeceasedDataWidget({
      super.key,
      required this.imageOnTap,
      this.nameValidator,
      this.phoneValidator,
      this.cityValidator,
      this.citiesOfInterestValidator,
      this.lastNameValidator,
      this.ageValidator,
      this.dateValidator,
      required this.child,
      required this.onDragDone,
      required this.onDragEntered,
      required this.onDragExited,
      required this.onDragUpdated,
      required this.iconOnTap,
      required this.citiesController,
      required this.nameController,
      required this.phoneController,
      required this.cityController,
      required this.filterController,
      required this.lastNameController,
      required this.ageController,
      required this.options,
      required this.citiesOfInterestOptions,
      required this.imageFile,
      required this.dateController
    });

    @override
    State<StatefulWidget> createState() {
      return DeceasedDataWidgetState();
    }
  }


  class DeceasedDataWidgetState extends State<DeceasedDataWidget> {
  CityListCubit get _cityListCubit => context.read<CityListCubit>();
  List<CityFromAPI> cityList = [];



  @override
  void initState() {
    super.initState();
    _cityListCubit.fetchCityList();

  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Texth1V2(
                testo: "Dati defunto",
                color: background,
                weight: FontWeight.w700,
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
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
                            onTap: widget.imageOnTap,
                            child: Container(
                              height: 138,
                              width: 138,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(3)),
                                color: greyDrag,
                                border: Border.all(color: background, width: 1),
                                image: widget.imageFile != "" ?
                                DecorationImage(
                                  image: NetworkImage(widget.imageFile),
                                  fit: BoxFit.contain,
                                )
                                    : DecorationImage(
                                  image: AssetImage(ImagesConstants.imgDemisePlaceholder),
                              fit: BoxFit.cover,
                                )
                              ),
                          /*    child: imageFile == null ? Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Texth4V2(
                                    testo:getCurrentLanguageValue(INSERT_PHOTO) ?? "",
                                    color: greyDisabled,
                                    weight: FontWeight.bold,
                                    textalign: TextAlign.center,

                                  ),
                                ),
                              ) : const SizedBox(), */
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                            ],
                            hinttext: getCurrentLanguageValue(NAME)!,
                            controller:widget.nameController,
                            validator: widget.nameValidator,
                            paddingLeft: 0,
                            borderSide: const BorderSide(color: greyState),
                            activeBorderSide: const BorderSide(color: background),
                          ),

                          Padding(
                            padding: getPadding(bottom: 5,top: 30),
                            child: Text(
                              'ETÀ',
                              style: SafeGoogleFont(
                                'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: background,
                              ),
                            ),
                          ),
                          InputsV2Widget(
                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly,],
                            maxLenght: 3,
                            hinttext: getCurrentLanguageValue(AGE)!,
                            controller: widget.ageController,
                            validator: widget.ageValidator,
                            paddingLeft: 0,
                            borderSide: const BorderSide(color: greyState),
                            activeBorderSide: const BorderSide(color: background),
                          )
                        ],
                      )),
                  Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: getPadding(bottom: 5),
                            child: Text(
                              'COGNOME',
                              style: SafeGoogleFont(
                                'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: background,
                              ),
                            ),
                          ),
                          InputsV2Widget(
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                            ],
                            hinttext: getCurrentLanguageValue(LAST_NAME)!,
                            controller: widget.lastNameController,
                            validator: widget.lastNameValidator,
                            paddingRight: 0,
                            paddingLeft: 0,
                            borderSide: const BorderSide(color: greyState),
                            activeBorderSide: const BorderSide(color: background),
                          ),


                          Padding(
                            padding: getPadding(bottom: 5,top: 30),
                            child: Text(
                              'TELEFONO',
                              style: SafeGoogleFont(
                                'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: background,
                              ),
                            ),
                          ),
                          InputsV2Widget(
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            hinttext: getCurrentLanguageValue(PHONE_NUMBER)!,
                            controller: widget.phoneController,
                            validator: widget.phoneValidator,
                            paddingLeft: 0,
                            paddingRight: 0,
                            borderSide: const BorderSide(color: greyState),
                            activeBorderSide:
                            const BorderSide(color: background),
                          )
                        ],
                      )),

                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Container()),
                  Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: getPadding(bottom: 5),
                            child: Text(
                              'DATA DEL DECESSO',
                              style: SafeGoogleFont(
                                'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: background,
                              ),
                            ),
                          ),
                          InputsV2Widget(
                            iconOnTap: widget.iconOnTap,
                            readOnly: true,
                            hinttext: "Data del decesso",
                            controller: widget.dateController,
                            validator: widget.dateValidator,
                            paddingLeft: 0,
                            suffixIcon: ImagesConstants.imgCalendar,
                            isSuffixIcon: true,
                            borderSide: const BorderSide(color: greyState),
                            activeBorderSide: const BorderSide(color: background),
                          )
                        ],
                      )),
                  Expanded(
                      flex: 2,
                      child:BlocBuilder<CityListCubit, CityListState>(
                          builder: (context, cityState) {
                            print("STIAMO ANDANDO IN LOADING");
                            if (cityState is CityListLoading) {
                              return const Center(
                                  child: CircularProgressIndicator()
                              );
                            } else if (cityState is CityListLoaded) {
                              print("FATTO LOADED CITYYY");
                              cityList = cityState.listCity;
                              if (cityList.isNotEmpty) {
                                return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: getPadding(bottom: 5),
                            child: Text(
                              'CITTÀ',
                              style: SafeGoogleFont(
                                'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: background,
                              ),
                            ),
                          ),
                          AutocompleteWidget(
                            options: cityList ,
                            paddingRight: 0,
                            paddingLeft: 0,
                            hintText: getCurrentLanguageValue(CITY)!,
                            filterController: widget.filterController,
                            validator: widget.cityValidator,
                          )
                        ],
                      );
  }
                   }return ErrorWidget("errore di connessione");

                }),),
                ],
              ),


            ),

            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex:1,child: Container()),
                  Expanded(
                      flex: 2,
                      child: BlocBuilder<CityListCubit, CityListState>(
                          builder: (context, cityState) {
                            print("STIAMO ANDANDO IN LOADING");
                            if (cityState is CityListLoading) {
                              return const Center(
                                  child: CircularProgressIndicator()
                              );
                            } else if (cityState is CityListLoaded) {
                              print("FATTO LOADED CITYYY");
                              cityList = cityState.listCity;
                              if (cityList.isNotEmpty) {
                                return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: getPadding(bottom: 5),
                            child: Text(
                              'COMUNI DI INTERESSE',
                              style: SafeGoogleFont(
                                'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: background,
                              ),
                            ),
                          ),
                          AutocompleteWidget(
                            options: cityList,
                            paddingRight: 20,
                            paddingLeft: 0,
                            hintText: "Comuni di interesse",
                            filterController: widget.citiesController,
                            validator: widget.citiesOfInterestValidator,
                          )
                        ],
                      );
                   }
                 }return ErrorWidget("errore di connessione");

                   }),

                  ),
                  Expanded(
                      flex: 2,
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: getPadding(bottom: 5),
                            child: Text(
                              'NECROLOGIO',
                              style: SafeGoogleFont(
                                'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: background,
                              ),
                            ),
                          ),

                         DropTarget(
                              onDragDone: widget.onDragDone,
                              onDragUpdated: widget.onDragUpdated,
                              onDragEntered: widget.onDragEntered,
                              onDragExited: widget.onDragExited,
                              child: widget.child,
                            ),

                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
