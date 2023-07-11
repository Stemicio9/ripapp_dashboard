import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/constants/images_constants.dart';
import 'package:ripapp_dashboard/models/city_from_API.dart';
import 'package:ripapp_dashboard/widgets/autocomplete.dart';
import 'package:ripapp_dashboard/widgets/utilities/empty_fields_widget.dart';
import 'package:ripapp_dashboard/widgets/utilities/network_memory_image_utility.dart';
import '../../../../blocs/city_list_cubit.dart';
import '../../../../blocs/selected_city_cubit.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/language.dart';
import '../../../../utils/size_utils.dart';
import '../../../../utils/style_utils.dart';
import '../../../../widgets/input.dart';
import '../../../../widgets/texts.dart';


class DeceasedData extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController cityController;
  final TextEditingController lastNameController;
  final TextEditingController ageController;
  final TextEditingController dateController;
  final TextEditingController citiesController;
  final TextEditingController filterController;
  bool isEdit = false;
  final Function() emptyFields;
  final dynamic nameValidator;
  final dynamic phoneValidator;
  final dynamic lastNameValidator;
  final dynamic ageValidator;
  final dynamic dateValidator;
  final dynamic citiesOfInterestValidator;
  final dynamic cityValidator;
  final iconOnTap;
  final imageOnTap;
  var imageFile;
  var memoryImage;
  final bool isNetwork;
  final Widget child;
  final List<CityFromAPI> options;
  final List<CityFromAPI> citiesOfInterestOptions;


  DeceasedData({super.key,
    required this.emptyFields,
    required this.child,
    required this.isEdit,
    this.memoryImage,
    this.isNetwork = true,
    required this.imageOnTap,
    this.nameValidator,
    this.phoneValidator,
    this.cityValidator,
    this.citiesOfInterestValidator,
    this.lastNameValidator,
    this.ageValidator,
    this.dateValidator,
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
    this.imageFile,
    required this.dateController,
  });

  @override
  State<StatefulWidget> createState() {
    return DeceasedDataState();
  }


}

class DeceasedDataState extends State<DeceasedData>{
  CityListCubit get _cityListCubit => context.read<CityListCubit>();
  List<CityFromAPI> cityList = [];


  @override
  void initState() {
    _cityListCubit.fetchCityList();
    super.initState();
  }


  @override
  Widget  build(BuildContext context) {
    return  BlocBuilder<SelectedCityCubit, SelectedCityState>(
        builder: (context, stateCity) {
          if (stateCity is SelectedCityState) {
            print("QUI SI SELEZIONA LA CITTA");
            widget.cityController.text = stateCity.selectedCity.name ?? "";
            widget.citiesController.text = stateCity.selectedCity.name ?? "";
            return
              Card(
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

                      EmptyFieldsWidget().emptyFields(widget.emptyFields),

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
                                            image: DecorationImage(
                                              image: NetworkMemoryImageUtility(
                                                  isNetwork: widget.isNetwork,
                                                  networkUrl: widget.imageFile,
                                                  memoryImage: widget.memoryImage).provide(),
                                              fit: BoxFit.cover,
                                            )
                                        ),
                                      ),
                                    )
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
                                      controller: widget.nameController,
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
                              child: BlocBuilder<CityListCubit, CityListState>(
                                  builder: (context, cityState) {
                                    if (cityState is CityListLoading) {
                                      print("DECESSED DATA CITY LOADING");
                                      return const Center(child: CircularProgressIndicator());
                                    } else if (cityState is CityListLoaded) {
                                      cityList = cityState.listCity;
                                      //print("decesssed city: $cityList");
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
                                              options: cityList,
                                              paddingRight: 0,
                                              paddingLeft: 0,
                                              paddingTop: 0,
                                              paddingBottom: 0,
                                              hintText: getCurrentLanguageValue(CITY)!,
                                              filterController: widget.filterController,
                                              validator: widget.cityValidator,
                                            )
                                          ],
                                        );
                                      }
                                    }return ErrorWidget("errore di connessione");

                                  }),
                            ),
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
                              child:  BlocBuilder<CityListCubit, CityListState>(
                                  builder: (context, cityState) {
                                    if (cityState is CityListLoading) {
                                      print("DECESSED DATA CITY LOADING");
                                      return const Center(child: CircularProgressIndicator());
                                    } else if (cityState is CityListLoaded) {
                                      cityList = cityState.listCity;
                                      //print("decesssed city: $cityList");
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
                                              paddingBottom: 0,
                                              paddingTop: 0,
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
                              child: widget.isEdit ? Container() : Column(
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

                                  Container(
                                    alignment: Alignment.center,
                                    child: widget.child,
                                  ),

                                ],
                              )
                              ,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
          }
          else
            return ErrorWidget("exception");
        } );
  }

}
