import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/blocs/searchKinshipCubit.dart';
import 'package:ripapp_dashboard/constants/kinships.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/language.dart';
import '../../../../utils/size_utils.dart';
import '../../../../utils/style_utils.dart';
import '../../../../widgets/input.dart';



  class RelativeRow extends StatefulWidget{
    final onChanged;
  final deleteRelative;
  final TextEditingController relativeController;
  final dynamic relativeValidator;
  final Function (Kinship selectedKinship) changeKinship;
  final Function(String selectedValue) statusChange;
  final bool isDetail;
   final Kinship selectedKinship;
   final List<String> listKinship;

  RelativeRow({
  super.key,
    this.onChanged,
    this.deleteRelative,
    required this.relativeController,
    this.relativeValidator,
    required this.statusChange,
    required this.isDetail,
    required this.changeKinship,
    required this.selectedKinship,
    required this.listKinship,


  });
    @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return RelativeRowState();
    }

  }
  class RelativeRowState extends State<RelativeRow> {
  late String selectedValue;
  late Kinship selectedKinship;
  bool first = true;


  SearchKinshipCubit get _searchKinshipCubit => context.read<SearchKinshipCubit>();


  @override
  void initState() {
  super.initState();
  _searchKinshipCubit.fetchKinships();
  if(first) {
    selectedValue = widget.listKinship.first;
    widget.statusChange(selectedValue);
    first = false;
  }
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: getPadding(bottom: 5),
                    child: Text(
                      'IL PARENTE È:',
                      style: SafeGoogleFont(
                        'Montserrat',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: background,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(color: greyState)
                      ),
                      child: BlocBuilder<SearchKinshipCubit, SearchKinshipState>(
                          builder: (context, state) {
                            print("LE KINSHIP");
                            if (state is SearchKinshipLoading){
                              print("FA IL LOADING");
                              return const Center(child: CircularProgressIndicator());
                            }
                            else if (state is SearchKinshipLoaded){
                              List<Kinship> kinships = state.kinships;
                              print(state.selectedKinship);
                              return DropdownButton<String>(
                                hint: const Text(
                                  "Seleziona parentela",
                                  style: TextStyle(
                                    color: black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),

                                isExpanded: true,
                                underline:  const SizedBox(),
                                value: state.selectedKinship?.name,
                                onChanged: (String? value) {
                                  _searchKinshipCubit.changeSelectedKinship(kinshipFromString(value ?? ""));

                                //onChanged: (value){
                                  //print("element");
                                  //print(value);
                                 // onChanged(this, value);
                                },
                                items: kinships.map<DropdownMenuItem<String>>((Kinship kinship) {
                                  return  DropdownMenuItem<String>(
                                    value: kinship.name,
                                    child:  Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        kinship.name,
                                        style: const TextStyle(
                                          color: black,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              );
                            }   else{
                              return ErrorWidget("errore di connessione"); //TODO aggiungere errore
                            }}
                      ),
                    ),
                  )
                ],
              )),
          Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: getPadding(bottom: 5),
                    child: Text(
                      'NUMERO PARENTE',
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
                    hinttext: getCurrentLanguageValue(RELATIVE_NUMBER) ?? "",
                    controller: widget.relativeController,
                    validator: widget.relativeValidator,
                    paddingLeft: 0,
                    paddingRight: 0,
                    borderSide: const BorderSide(color: greyState),
                    activeBorderSide:
                    const BorderSide(color: background),
                  ),

                ],
              )),

          Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5,bottom: 10),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                          onTap: (){widget.deleteRelative(this);},
                          child: Icon(
                            Icons.delete_rounded,
                            color: rossoopaco,
                            size: 40,
                          )
                      ),
                    ),
                  ),
                ],
              )
          )
        ],
      ),
    );
  }
}

