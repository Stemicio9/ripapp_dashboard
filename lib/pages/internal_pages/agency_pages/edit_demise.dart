import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/blocs/CurrentPageCubit.dart';
import 'package:ripapp_dashboard/blocs/profile_image_cubit.dart';
import 'package:ripapp_dashboard/blocs/selected_demise_cubit.dart';
import 'package:ripapp_dashboard/constants/images_constants.dart';
import 'package:ripapp_dashboard/constants/route_constants.dart';
import 'package:ripapp_dashboard/models/DemiseRelative.dart';
import 'package:ripapp_dashboard/models/city_from_API.dart';
import 'package:ripapp_dashboard/models/demise_entity.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/add_demise/relative_row.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/add_demise/relatives.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/add_relative.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/deceased_data.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/funeral_data.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/relative_row.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/wake_data.dart';
import 'package:ripapp_dashboard/pages/internal_pages/header.dart';
import 'package:ripapp_dashboard/pages/internal_pages/page_header.dart';
import 'package:ripapp_dashboard/widgets/scaffold.dart';
import '../../../constants/kinships.dart';
import '../../../constants/language.dart';
import '../../../constants/validators.dart';
import '../../../utils/size_utils.dart';
import 'package:intl/intl.dart';
import '../../../widgets/action_button.dart';
import '../../../widgets/snackbars.dart';



class EditDemise extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return EditDemiseState();
  }
}

class EditDemiseState extends State<EditDemise> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController deceasedDateController = TextEditingController();
  final TextEditingController citiesController = TextEditingController();
  final TextEditingController filterController = TextEditingController();


  final TextEditingController wakeDateController = TextEditingController();
  final TextEditingController wakeTimeController = TextEditingController();
  final TextEditingController wakeNoteController = TextEditingController();
  final TextEditingController wakeAddressController = TextEditingController();

  final TextEditingController funeralAddressController = TextEditingController();
  final TextEditingController funeralDateController = TextEditingController();
  final TextEditingController funeralTimeController = TextEditingController();
  final TextEditingController funeralNoteController = TextEditingController();
  CurrentPageCubit  get _currentPageCubit => context.read<CurrentPageCubit>();
  SelectedDemiseCubit  get _selectedDemiseCubit => context.read<SelectedDemiseCubit>();
  int relativeIndex = 0;

  final TextEditingController relativeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime? wakeDate;
  DateTime? funeralDate;
  List<CityFromAPI> cityOptions = <CityFromAPI>[];
  List<CityFromAPI> citiesOfInterestOptions = <CityFromAPI>[];
  ProfileImageCubit get _profileImageCubit => context.read<ProfileImageCubit>();
  List<RelativeRowNew> relativesNew = [];

  static const List<String> kinship = <String>[
    'Madre',
    'Padre',
  ];


  final List<Widget> relativeRows = [];
  var imageFile = ImagesConstants.imgDemisePlaceholder;
  var memoryImage;
  bool isNetwork = true;
  late String fileName;
  late Uint8List fileBytes;

  setKinshipFromDropdownOf(int index, Kinship kinship) {
    (_selectedDemiseCubit.state.selectedDemise).relatives![index].kinshipType = kinship;
  }

  setTelephoneNumber(int index, String phoneNumber) {
    (_selectedDemiseCubit.state.selectedDemise).relatives![index].telephoneNumber = phoneNumber;
  }

  Future<dynamic> downloadUrlImage(String uid,String demiseId) async {
    var fileList = await FirebaseStorage.instance.ref('profile_images/deceased_images/UID:$uid/demiseId:$demiseId/').listAll();
    for (var element in fileList.items) {
      print(element.name);
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

  refactorRelativeIndexes(){
    for(int i = 0; i< relativesNew.length; i++){
      relativesNew[i].currentIndex = i;
    }
  }

  @override
  Widget build(BuildContext context) {
    _currentPageCubit.changeCurrentPage(RouteConstants.editDemise);
    final User user = FirebaseAuth.instance.currentUser!;
    final uid = user.uid;
    return BlocBuilder<ProfileImageCubit, ProfileImageState>(
        builder: (context, imageState) {
      return BlocBuilder<SelectedDemiseCubit, SelectedDemiseState>(
          builder: (context, state) {
              print("perche non si valoriza? "+ state.selectedDemise.toString());
              downloadUrlImage(uid,state.selectedDemise.firebaseid!).then((value) => func(value));

              nameController.text = state.selectedDemise.firstName ?? nameController.text;
              lastNameController.text = state.selectedDemise.lastName ?? lastNameController.text;
              phoneController.text = state.selectedDemise.phoneNumber ?? phoneController.text;
              if (state.selectedDemise.age != null) {
                ageController.text = state.selectedDemise.age.toString();
              }
              deceasedDateController.text = state.selectedDemise.deceasedDate.toString();


              //  DateTime datetime = state.selectedDemise.wakeDateTime!;
              //   wakeDateController.text =  DateTime(datetime.year, datetime.month, datetime.day).toString();
              //   wakeTimeController.text = state.selectedDemise.wakeDateTime!.hour.toString() + state.selectedDemise.wakeDateTime!.minute.toString();
              wakeAddressController.text = state.selectedDemise.wakeAddress ?? wakeAddressController.text;
              wakeNoteController.text = state.selectedDemise.wakeNotes ?? wakeNoteController.text;


              // funeralDateController.text = state.selectedDemise.funeralDateTime!.toString() ?? "";
              //funeralTimeController.text = state.selectedDemise.funeralDateTime.toString() ?? "";
              funeralNoteController.text = state.selectedDemise.funeralNotes ?? funeralNoteController.text;
              funeralAddressController.text = state.selectedDemise.funeralAddress ?? funeralAddressController.text;
              relativesNew.clear();
              for (int i = 0; i < state.selectedDemise.relatives!.length; ++i){
                print("entro nell'aggiunta ai newrelative");
                DemiseRelative currentRelative = state.selectedDemise.relatives![i];
                relativesNew.add(
                    RelativeRowNew(value: currentRelative.telephoneNumber!,
                        kinship: currentRelative.kinshipType!,
                        currentIndex: i)
                );}


              //relativeController.text = state.selectedDemise.relative.toString() ?? "";

              return ScaffoldWidget(
                body: SingleChildScrollView(
                  child: Padding(
                    padding: getPadding(top: 30, bottom: 30, left: 5, right: 5),
                    child: Form(
                      key: _formKey ,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          const PageHeader(
                            pageTitle: "Modifica decesso",
                            showBackButton: true,
                          ),

                          //deceased data
                          imageState.loaded ? DeceasedData(
                            emptyFields: (){
                              nameController.text = '';
                              lastNameController.text = '';
                              cityController.text = '';
                              phoneController.text = '';
                              ageController.text = '';
                              deceasedDateController.text = '';
                              wakeAddressController.text = '';
                              wakeDateController.text = '';
                              wakeTimeController.text = '';
                              wakeNoteController.text = '';
                              funeralAddressController.text = '';
                              funeralDateController.text = '';
                              funeralTimeController.text = '';
                              funeralNoteController.text = '';
                              citiesController.text = '';
                              relativeController.text = '';
                              filterController.text = '';
                            },
                            isEdit: true,
                            isNetwork: isNetwork,
                            imageFile: imageFile,
                            memoryImage: memoryImage,
                            imageOnTap: () async {
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

                            filterController: filterController,
                            nameController: nameController,
                            phoneController: phoneController,
                            cityController: cityController,
                            lastNameController: lastNameController,
                            ageController: ageController,
                            dateController: deceasedDateController,
                            citiesController: citiesController,
                            nameValidator: notEmptyValidate,
                            lastNameValidator: notEmptyValidate,
                            phoneValidator: notEmptyValidate,
                            ageValidator: notEmptyValidate,
                            dateValidator: notEmptyValidate,
                            citiesOfInterestValidator: notEmptyValidate,
                            cityValidator: notEmptyValidate,
                            options: cityOptions,
                            citiesOfInterestOptions: citiesOfInterestOptions,
                            iconOnTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(
                                      const Duration(days: 365)));
                              if (pickedDate != null) {
                                String formattedDate =
                                DateFormat('dd-MM-yyyy').format(pickedDate);
                                setState(() {
                                  deceasedDateController.text = formattedDate;
                                });
                              } else {
                                print("Date is not selected");
                              }
                            },
                            child: Container(),

                          ) : Container(),




                          //wake data
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: WakeData(
                              timeController: wakeTimeController,
                              wakeAddressController: wakeAddressController,
                              dateController: wakeDateController,
                              wakeNoteController: wakeNoteController,
                              timeValidator: notEmptyValidate,
                              dateValidator: notEmptyValidate,
                              wakeAddressValidator: notEmptyValidate,
                              showWakeTimePicker: () async {
                                TimeOfDay? pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  confirmText: getCurrentLanguageValue(
                                      CONFIRM) ?? "",
                                  cancelText: getCurrentLanguageValue(CANCEL) ??
                                      "",
                                );
                                if (pickedTime != null) {
                                  setState(() {
                                    wakeTimeController.text =
                                        pickedTime.format(context).toString();
                                  });
                                } else {
                                  print("Time is not selected");
                                }
                              },
                              showWakeDatePicker: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate:
                                    DateTime.now().add(
                                        const Duration(days: 365)));
                                if (pickedDate != null) {
                                  String formattedDate =
                                  DateFormat('dd-MM-yyyy').format(pickedDate);
                                  setState(() {
                                    wakeDateController.text = formattedDate;
                                  });
                                } else {
                                  print("Date is not selected");
                                }
                              },
                            ),
                          ),

                          //funeral data
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: FuneralData(
                              addressController: funeralAddressController,
                              timeController: funeralTimeController,
                              dateController: funeralDateController,
                              noteController: funeralNoteController,
                              timeValidator: notEmptyValidate,
                              dateValidator: notEmptyValidate,
                              addressValidator: notEmptyValidate,
                              showFuneralTimePicker: () async {
                                TimeOfDay? pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  confirmText: getCurrentLanguageValue(
                                      CONFIRM) ?? "",
                                  cancelText: getCurrentLanguageValue(CANCEL) ??
                                      "",
                                );
                                if (pickedTime != null) {
                                  setState(() {
                                    funeralTimeController.text =
                                        pickedTime.format(context).toString();
                                  });
                                } else {
                                  print("Time is not selected");
                                }
                              },
                              showFuneralDatePicker: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate:
                                    DateTime.now().add(
                                        const Duration(days: 365)));
                                if (pickedDate != null) {
                                  String formattedDate =
                                  DateFormat('dd-MM-yyyy').format(pickedDate);
                                  setState(() {
                                    funeralDateController.text = formattedDate;
                                  });
                                } else {
                                  print("Date is not selected");
                                }
                              },
                            ),
                          ),

                          //add relative
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: RelativesWidget(
                              isDetail: false,
                              relatives: relativesNew,
                              addDemisePress: () {
                                RelativeRowNew relativeRow = RelativeRowNew(currentIndex: relativesNew.length);
                                setState(() {
                                  //relativesNew.add(relativeRow);
                                  RelativeRowNew newRelative = RelativeRowNew(); //used just for default values
                                  _selectedDemiseCubit.state.selectedDemise.relatives!.add(DemiseRelative(telephoneNumber: newRelative.value, kinshipType: newRelative.kinship));
                                });
                              },
                              onKinshipChange: (int index, Kinship kinship) {
                                print("entro nel kinship change");
                                setState(() {
                                  _selectedDemiseCubit.state.selectedDemise.relatives![index].kinshipType = kinship;
                                  //relativesNew[index].kinship = kinship;
                                });
                              },
                              inputValueChange: (int index, String value) {
                                print("CAMBIO VALORE DI INDICE $index");
                                setState(() {
                                  _selectedDemiseCubit.state.selectedDemise.relatives![index].telephoneNumber = value;
                                  //relativesNew[index].value = value;
                                });
                              },
                              deleteRow: (int index) {
                                // TODO
                                // TODO What problem can generate this method?
                                setState(() {
                                  //relativesNew.removeAt(index);
                                  _selectedDemiseCubit.state.selectedDemise.relatives!.removeAt(index);
                                  //refactorRelativeIndexes();
                                });
                              },)
                          ),


                          //form submit
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ActionButtonV2(action: formSubmit,
                                    text: getCurrentLanguageValue(SAVE) ?? ""),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              );
          });
    });
  }



  formSubmit() async {
    if(_formKey.currentState!.validate()){
      DemiseEntity demiseEntity = DemiseEntity();
      if (demiseEntity.deceasedDate != null && demiseEntity.wakeDateTime != null && demiseEntity.funeralDateTime != null) {
        if (demiseEntity.deceasedDate!.isAfter(demiseEntity.wakeDateTime!) || demiseEntity.deceasedDate!.isAfter(demiseEntity.funeralDateTime!)) {
          return ErrorSnackbar(
              context,
              text: 'Date selezionate incoerenti!'
          );
        }
      }


      final User user = FirebaseAuth.instance.currentUser!;
      final uid = user.uid;
      var path = 'profile_images/deceased_images/UID:$uid/demiseId:${demiseEntity.firebaseid}/';

      var fileList = await FirebaseStorage.instance.ref(path).listAll();
      if (fileList.items.isNotEmpty) {
        var fileesistente = fileList.items[0];
        fileesistente.delete();
      }
      await FirebaseStorage.instance.ref("$path$fileName").putData(fileBytes);


      SuccessSnackbar(
          context,
          text: 'Defunto modificato con successo!'
      );
      Navigator.pop(context);
    }else{
      ErrorSnackbar(
          context,
          text: 'Impossibile modificare defunto!'
      );
    }
  }


  void createNewRelativeRow() {
    selectedValues.add(kinship.first);
    var x = RelativeRow(
        onChanged: changeDropdown,
        relativeController: relativeController,
        deleteRelative: deleteRelative,
        relativeValidator: notEmptyValidate,
      index: relativeIndex,
      changeTelephoneNumber: setTelephoneNumber,
      isDetail: false, changeKinship: setKinshipFromDropdownOf,
      selectedKinship: kinship as Kinship,
      listKinship: ['nonno'],
       /*statusChange: (String selectedValue) {  }, kinChange: (Kinship selectedKinship)*/

    );

    // RelativeRow(onChanged: (String? value) {
    //   setState(() {
    //     dropdownValue = value!;
    //   });
    // }, kinship: kinship, relativeController: relativeController, deleteRelative: (){}, value: dropdownValue);

    relativeRows.add(x);

  }

  changeDropdown(RelativeRow relativeRow, value){
    setState(() {
      var index = relativeRows.indexOf(relativeRow);
      selectedValues[index] = value;
    });
  }

  deleteRelative(RelativeRow relativeRow){
    setState(() {
      var index = relativeRows.indexOf(relativeRow);
      relativeRows.remove(relativeRow);
      selectedValues.removeAt(index);
    });
  }

  var selectedValues = [];

}
