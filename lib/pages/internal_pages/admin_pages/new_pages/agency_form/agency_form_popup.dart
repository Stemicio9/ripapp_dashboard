import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/blocs/city_list_cubit.dart';
import 'package:ripapp_dashboard/blocs/selected_city_cubit.dart';
import 'package:ripapp_dashboard/models/agency_entity.dart';
import 'package:ripapp_dashboard/models/city_from_API.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/new_pages/agency_form/agency_form_widget.dart';
import 'package:ripapp_dashboard/widgets/circular_progress_indicator.dart';

class AgencyFormPopup extends StatefulWidget{

  final Future<bool> Function() onWillPop;
  AgencyEntity? selectedAgency;
  final Function onSubmit;

   AgencyFormPopup({Key? key,
    required this.onWillPop,
    this.selectedAgency,
    required this.onSubmit
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AgencyFormPopupState();
  }
}

class AgencyFormPopupState extends State<AgencyFormPopup>{
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  CityListCubit get _cityListCubit => context.read<CityListCubit>();

  @override
  void initState() {
    if(_cityListCubit.state is! CityListLoaded) {
      _cityListCubit.fetchCityList();
    }
    widget.selectedAgency ??= AgencyEntity.emptyAgency();
    assignTextEditingControllerValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: widget.onWillPop,
      child: BlocBuilder<CityListCubit,CityListState>(
          builder: (context, cityListState) {
            if(cityListState is CityListLoading) {
              return const CircularProgressIndicatorWidget();
            } else if(cityListState is CityListLoaded) {
                    return Form(
                      key: _formKey,
                      child: AgencyFormWidget(
                          city: cityController.text,
                          nameController: nameController,
                          emailController: emailController,
                          phoneController: phoneController,
                          cityController: cityController,
                          isAddPopup: widget.selectedAgency?.id != null ? false : true,
                          options: cityListState.listCity,
                          onSelected: (CityFromAPI city){
                            cityController.text = city.name!;
                          },
                          clearFields: clearFields,
                          save: save,
                      )
                    );

            } else {
              return ErrorWidget("exception");
            }
          }
      ),
    );
  }

  assignTextEditingControllerValues(){
    nameController.text = widget.selectedAgency?.agencyName ?? '';
    emailController.text = widget.selectedAgency?.email ?? '';
    cityController.text = widget.selectedAgency?.city ?? '';
    phoneController.text = widget.selectedAgency?.phoneNumber ?? '';
  }

  void clearFields(){
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    setState(() {
      cityController.clear();
    });
  }

  void save(){
    if (widget.selectedAgency == null) return;
    if(_formKey.currentState!.validate()) {
        AgencyEntity agencyToSave = widget.selectedAgency!.copyWith(
            id: widget.selectedAgency!.id,
            agencyName: nameController.text,
            phoneNumber: phoneController.text,
            email: widget.selectedAgency!.id != null ? widget.selectedAgency!.email : emailController.text,
            city: cityController.text
        );
        widget.onSubmit(agencyToSave);
    }
  }
}