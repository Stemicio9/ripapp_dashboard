import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/blocs/selected_agency_cubit.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/models/city_from_API.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/utils/style_utils.dart';
import 'package:ripapp_dashboard/widgets/action_button.dart';
import 'package:ripapp_dashboard/widgets/dialog_card.dart';
import 'package:ripapp_dashboard/widgets/input.dart';
import '../../../../blocs/city_list_cubit.dart';
import '../../../../blocs/selected_city_cubit.dart';
import '../../../../widgets/autocomplete.dart';


class AgencyForm extends StatelessWidget {


final String cardTitle;
final TextEditingController nameController;
final TextEditingController phoneController;
final TextEditingController emailController;
final TextEditingController cityController;
final dynamic nameValidator;
final dynamic cityValidator;
final dynamic emailValidator;
final dynamic phoneValidator;
final Function() onSubmit;
final List<CityFromAPI> cityOptions;
final bool isAddPage;


const AgencyForm({
super.key,
required this.cityOptions,
required this.cardTitle,
this.nameValidator,
this.emailValidator,
this.phoneValidator,
this.cityValidator,
required this.nameController,
required this.emailController,
required this.phoneController,
required this.cityController,
required this.onSubmit,
this.isAddPage = true,
});
@override
Widget build(BuildContext context) {
  return MultiBlocProvider(
    providers: [

      BlocProvider(create: (_) => CityListCubit()),
    ],
    child: AgencyFormWidget(
    cardTitle      : cardTitle,
    nameController : nameController,
    phoneController: phoneController,
    emailController: emailController,
    cityController : cityController,
    cityOptions    : cityOptions,
    isAddPage      : isAddPage,
    onSubmit: onSubmit,
  ),
  );
}
}
class AgencyFormWidget extends StatefulWidget {
  final String cardTitle;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController cityController;
  final dynamic nameValidator;
  final dynamic cityValidator;
  final dynamic emailValidator;
  final dynamic phoneValidator;
  final Function() onSubmit;
  final List<CityFromAPI> cityOptions;
  final bool isAddPage;


  AgencyFormWidget({
 super.key,
  required this.cardTitle,
  required this.nameController,
  required this.phoneController,
  required this.emailController,
  required this.cityController,
  this.nameValidator,
  this.cityValidator,
  this.emailValidator,
  this.phoneValidator,
  required this.onSubmit,
  required this.cityOptions,
  required this.isAddPage
  });

  @override
  State<StatefulWidget> createState() {
    return AgencyFormWidgetState();
  }
}

class AgencyFormWidgetState extends State<AgencyFormWidget> {
  CityListCubit get _cityListCubit => context.read<CityListCubit>();
  List<CityFromAPI> cityList = [];
  String? city;

  @override
  void initState() {
    super.initState();
    _cityListCubit.fetchCityList();
  }


  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<SelectedCityCubit, SelectedCityState>(
        builder: (context, stateCity) {
          if (stateCity is SelectedCityState) {
            print("QUI SI SELEZIONA LA CITTA");
            widget.cityController.text = stateCity.selectedCity.name ?? "";
            print("LA CITTA DELL'AGENZIA é $city");
            return
              BlocBuilder<SelectedAgencyCubit, SelectedAgencyState>(
                  builder: (context, state) {
                    if (state is SelectedAgencyState) {
                      widget.nameController.text =
                          state.selectedAgency.agencyName ?? "";
                      widget.phoneController.text =
                          state.selectedAgency.phoneNumber ?? "";
                      return Container(
                        padding: getPadding(left: 20, right: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: 700,
                                child: DialogCard(
                                    cancelIcon: true,
                                    paddingLeft: 10,
                                    paddingRight: 10,
                                    cardTitle: widget.cardTitle,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: getPadding(bottom: 30),
                                          child:
                                          Row(
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Padding(
                                                        padding: getPadding(
                                                            bottom: 5),
                                                        child: Text(
                                                          'NOME',
                                                          style: SafeGoogleFont(
                                                            'Montserrat',
                                                            fontSize: 14,
                                                            fontWeight: FontWeight
                                                                .w600,
                                                            color: background,
                                                          ),
                                                        ),
                                                      ),
                                                      InputsV2Widget(
                                                        hinttext: getCurrentLanguageValue(
                                                            NAME)!,
                                                        controller: widget
                                                            .nameController,
                                                        validator: widget
                                                            .nameValidator,
                                                        paddingLeft: 0,
                                                        paddingRight: 10,
                                                        borderSide: const BorderSide(
                                                            color: greyState),
                                                        activeBorderSide: const BorderSide(
                                                            color: background),
                                                      )
                                                    ],
                                                  )),
                                              Expanded(
                                                flex: 1,
                                                child: BlocBuilder<
                                                    CityListCubit,
                                                    CityListState>(
                                                    builder: (context,
                                                        cityState) {
                                                      if (cityState is CityListLoading) {
                                                        return const Center(
                                                            child: CircularProgressIndicator()
                                                        );
                                                      } else
                                                      if (cityState is CityListLoaded) {
                                                        cityList =
                                                            cityState.listCity;
                                                        if (cityList
                                                            .isNotEmpty) {
                                                          return Column(
                                                            crossAxisAlignment: CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Padding(
                                                                padding: getPadding(
                                                                    bottom: 5,
                                                                    left: 3),
                                                                child: Text(
                                                                  'CITTÀ',
                                                                  style: SafeGoogleFont(
                                                                    'Montserrat',
                                                                    fontSize: 14,
                                                                    fontWeight: FontWeight
                                                                        .w600,
                                                                    color: background,
                                                                  ),
                                                                ),
                                                              ),
                                                              AutocompleteWidget(
                                                                options: cityList,
                                                                paddingRight: 0,
                                                                paddingLeft: 10,
                                                                hintText: "Città",
                                                                filterController: widget
                                                                    .cityController,
                                                                validator: widget
                                                                    .cityValidator,
                                                                paddingTop: 10,
                                                                paddingBottom: 10,
                                                              )
                                                            ],
                                                          );
                                                        }
                                                      }
                                                      return ErrorWidget(
                                                          "errore di connessione");
                                                    }),),
                                            ],

                                          ),

                                        ),
                                        Padding(
                                          padding: getPadding(bottom: 40),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Padding(
                                                        padding: getPadding(
                                                            bottom: 5),
                                                        child: Text(
                                                          'TELEFONO',
                                                          style: SafeGoogleFont(
                                                            'Montserrat',
                                                            fontSize: 14,
                                                            fontWeight: FontWeight
                                                                .w600,
                                                            color: background,
                                                          ),
                                                        ),
                                                      ),
                                                      InputsV2Widget(
                                                        hinttext: getCurrentLanguageValue(
                                                            PHONE_NUMBER)!,
                                                        controller: widget
                                                            .phoneController,
                                                        validator: widget
                                                            .phoneValidator,
                                                        paddingLeft: 0,
                                                        paddingRight: 10,
                                                        inputFormatters: <
                                                            TextInputFormatter>[
                                                          FilteringTextInputFormatter
                                                              .digitsOnly,
                                                        ],
                                                        borderSide: const BorderSide(
                                                            color: greyState),
                                                        activeBorderSide: const BorderSide(
                                                            color: background),
                                                      )
                                                    ],
                                                  )),
                                              Expanded(
                                                  flex: 1,
                                                  child: widget.isAddPage
                                                      ? Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Padding(
                                                        padding: getPadding(
                                                            bottom: 5, left: 3),
                                                        child: Text(
                                                          'EMAIL',
                                                          style: SafeGoogleFont(
                                                            'Montserrat',
                                                            fontSize: 14,
                                                            fontWeight: FontWeight
                                                                .w600,
                                                            color: background,
                                                          ),
                                                        ),
                                                      ),
                                                      InputsV2Widget(
                                                        hinttext: getCurrentLanguageValue(
                                                            EMAIL)!,
                                                        controller: widget
                                                            .emailController,
                                                        validator: widget
                                                            .emailValidator,
                                                        paddingRight: 0,
                                                        paddingLeft: 10,
                                                        borderSide: const BorderSide(
                                                            color: greyState),
                                                        activeBorderSide: const BorderSide(
                                                            color: background),
                                                      )
                                                    ],
                                                  )
                                                      : Container()
                                              ),
                                            ],
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: ActionButtonV2(
                                            action: widget.onSubmit,
                                            text: getCurrentLanguageValue(
                                                SAVE)!,
                                          ),
                                        )
                                      ],
                                    )
                                )
                            )
                          ],
                        ),
                      );
                    }
                    else
                      return ErrorWidget("exception");
                  });
          }
          else
            return ErrorWidget("exception");
        } );
  }
}