
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ripapp_dashboard/blocs/CurrentPageCubit.dart';
import 'package:ripapp_dashboard/blocs/profile_image_cubit.dart';
import 'package:ripapp_dashboard/blocs/search_demises_cubit.dart';
import 'package:ripapp_dashboard/constants/images_constants.dart';
import 'package:ripapp_dashboard/constants/route_constants.dart';
import 'package:ripapp_dashboard/constants/validators.dart';
import 'package:ripapp_dashboard/models/CityEntity.dart';
import 'package:ripapp_dashboard/models/city_from_API.dart';
import 'package:ripapp_dashboard/models/demise_entity.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/add_relative.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/deceased_data.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/dropzone/dropzone_widget.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/dropzone/file_data_model.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/funeral_data.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/relative_row.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/wake_data.dart';
import 'package:ripapp_dashboard/pages/internal_pages/header.dart';
import 'package:ripapp_dashboard/widgets/action_button.dart';
import 'package:ripapp_dashboard/widgets/scaffold.dart';
import 'package:uuid/uuid.dart';
import '../../../constants/kinships.dart';
import '../../../constants/language.dart';
import '../../../utils/size_utils.dart';
import 'package:intl/intl.dart';

import '../../../widgets/snackbars.dart';

class AddDemise extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddDemiseState();
  }
}

class AddDemiseState extends State<AddDemise> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController deceasedDateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController wakeDateController = TextEditingController();
  final TextEditingController wakeTimeController = TextEditingController();
  final TextEditingController wakeNoteController = TextEditingController();
  final TextEditingController funeralAddressController = TextEditingController();
  final TextEditingController funeralDateController = TextEditingController();
  final TextEditingController funeralTimeController = TextEditingController();
  final TextEditingController funeralNoteController = TextEditingController();
  final TextEditingController citiesController = TextEditingController();
  final TextEditingController relativeController = TextEditingController();
  final TextEditingController filterController = TextEditingController();
  DemiseCubit get _searchDemiseCubit => context.read<DemiseCubit>();
  DateTime? wakeDate;
  DateTime? funeralDate;
  List<CityFromAPI> cityOptions = <CityFromAPI>[];
  List<CityFromAPI> citiesOfInterestOptions = <CityFromAPI>[];
  File_Data_Model? obituaryFile;
  CurrentPageCubit get _currentPageCubit => context.read<CurrentPageCubit>();

  static const List<String> kinship = <String>[
    'Madre',
    'Padre',
    'Fratello',
    'Sorella',
    'Figlio',
    'Figlia',
    'Nonno',
    'Nonna',
  ];

  final _formKey = GlobalKey<FormState>();
  final List<Widget> relativeRows = [];
  ProfileImageCubit get _profileImageCubit => context.read<ProfileImageCubit>();
  var imageFile = ImagesConstants.imgDemisePlaceholder;
  var memoryImage;
  bool isNetwork = true;
  late String fileName = "";
  late Uint8List fileBytes = Uint8List.fromList([0,1]);


  Future<dynamic> downloadUrlImage(String uid) async {
    var fileList = await FirebaseStorage.instance.ref('profile_images/').listAll();
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
    _currentPageCubit.changeCurrentPage(RouteConstants.addDemise);
    final User user = FirebaseAuth.instance.currentUser!;
    final uid = user.uid;
    downloadUrlImage(uid).then((value) => func(value));
    return BlocBuilder<ProfileImageCubit, ProfileImageState>(
        builder: (context, state) {
          print("il nostro link è " + imageFile.toString());
          return ScaffoldWidget(
            body: SingleChildScrollView(
              child: Padding(
                padding: getPadding(top: 40, bottom: 40, left: 5, right: 5),
                child: Form(
                  key: _formKey ,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Header(
                        deleteProfileOnTap: (){},
                        leftPadding: const EdgeInsets.only(left: 5),
                        showBackButton: true,
                        onTap: null,
                        showPageTitle: false,
                        isVisible: false,
                      ),

                      //deceased data
                      state.loaded ?  DeceasedData(
                        isEdit: false,
                        isNetwork: isNetwork,
                        imageFile: imageFile,
                        memoryImage: memoryImage,
                        imageOnTap: () async {
                          FilePickerResult? result = await FilePicker.platform.pickFiles();
                          if (result != null) {
                            fileBytes = result.files.first.bytes!;
                            fileName = result.files.first.name;
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
                        options: cityOptions,
                        nameValidator: notEmptyValidate,
                        lastNameValidator: notEmptyValidate,
                        phoneValidator:notEmptyValidate ,
                        ageValidator: notEmptyValidate,
                        dateValidator: notEmptyValidate,
                        citiesOfInterestValidator: notEmptyValidate,
                        cityValidator: notEmptyValidate,
                        citiesOfInterestOptions: citiesOfInterestOptions,
                        iconOnTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now().add(const Duration(days: -365 * 10)),
                              lastDate: DateTime.now().add(const Duration(days: 365)));
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
                        child: Column(
                          children: [
                            Container(
                              height: 300,
                              padding: const EdgeInsets.only(bottom: 20),
                              child: DropZoneWidget(
                                file: obituaryFile,
                                onDroppedFile: (file) => setState(()=> obituaryFile = file),

                              ),
                            ),

                          ],
                        ),




                          ) : Container(),

                      //wake data
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: WakeData(
                          timeController: wakeTimeController,
                          wakeAddressController: addressController,
                          dateController: wakeDateController,
                          wakeNoteController: wakeNoteController,
                          timeValidator: notEmptyValidate,
                          dateValidator: notEmptyValidate,
                          wakeAddressValidator: notEmptyValidate,
                          showWakeTimePicker: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              confirmText: getCurrentLanguageValue(CONFIRM) ?? "",
                              cancelText: getCurrentLanguageValue(CANCEL) ?? "",
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
                                DateTime.now().add(const Duration(days: 365)));
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
                              confirmText: getCurrentLanguageValue(CONFIRM) ?? "",
                              cancelText: getCurrentLanguageValue(CANCEL) ?? "",
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
                                DateTime.now().add(const Duration(days: 365)));
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
                        child: AddRelative(
                          relativeRows: relativeRows,
                          addRelative: () async {
                            setState(() {
                              createNewRelativeRow();
                            });
                          },
                        ),
                      ),

                      //form submit
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ActionButtonV2(
                                action: formSubmit,
                                text: getCurrentLanguageValue(SAVE) ?? ""),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );});
  }

  formSubmit() async{
    // if (_formKey.currentState!.validate()) {
    if (obituaryFile == null) {
      ErrorSnackbar(context, text: 'Inserire necrologio!');
    } else {

      DemiseEntity demiseEntity = DemiseEntity();
      demiseEntity.firstName = (nameController.text);
      demiseEntity.lastName = (lastNameController.text);
      demiseEntity.city = CityEntity(name: cityController.text);
      demiseEntity.phoneNumber = (phoneController.text);
      demiseEntity.age = ageController.text != "" ? int.parse(ageController.text) : null;
      demiseEntity.deceasedDate = (deceasedDateController.text != "" && deceasedDateController.text != null) ? convertDate(deceasedDateController.text) : null;
      demiseEntity.funeralDateTime = (funeralDateController.text != "" && funeralDateController.text != null) ? convertDate(funeralDateController.text) : null;
      demiseEntity.wakeDateTime = (wakeDateController.text != "" && wakeDateController.text != null) ? convertDate(wakeDateController.text) : null;
      demiseEntity.wakeAddress = (addressController.text);
      demiseEntity.wakeNotes = (wakeNoteController.text);
      demiseEntity.funeralAddress = (funeralAddressController.text);
      demiseEntity.funeralDateTime = (funeralDateController.text != "" && funeralDateController.text != null) ? convertDate(funeralDateController.text) : null;
      demiseEntity.funeralNotes = (funeralNoteController.text);
      //demiseEntity.cities = (citiesController.text);
      //demiseEntity.relative = (relativeController.text);

      String wakeTimeString = wakeTimeController.text;
      if (wakeTimeString != null && wakeTimeString != "") {
        List<String> timeParts = wakeTimeString.split(":");
        int? wakeHours = int.tryParse(timeParts[0]);
        int? wakeMinutes = int.tryParse(timeParts[1]);
        if (wakeMinutes != null && wakeHours != null &&
            demiseEntity.wakeDateTime != null) {
          demiseEntity.wakeDateTime = DateTime(
              demiseEntity.wakeDateTime!.year,
              demiseEntity.wakeDateTime!.month,
              demiseEntity.wakeDateTime!.day, wakeHours, wakeMinutes);
        }
      }
      String funeralTimeString = funeralTimeController.text;
      if (funeralTimeString != null && funeralTimeString != "") {
        List<String> timeParts = funeralTimeString.split(":");
        int? funeralHours = int.tryParse(timeParts[0]);
        int? funeralMinutes = int.tryParse(timeParts[1]);
        if (funeralMinutes != null && funeralHours != null &&
            demiseEntity.funeralDateTime != null) {
          demiseEntity.funeralDateTime = DateTime(
              demiseEntity.funeralDateTime!.year,
              demiseEntity.funeralDateTime!.month,
              demiseEntity.funeralDateTime!.day, funeralHours,
              funeralMinutes);
        }
      }
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
      var uuid = const Uuid();
      var demiseId = uuid.v4();
      demiseEntity.firebaseid = demiseId;

      _searchDemiseCubit.saveDemise(demiseEntity);

      var obituaryPath = 'obituaries/UID:$uid/demiseId:$demiseId/';
      var obituaryList = await FirebaseStorage.instance.ref(obituaryPath).listAll();
      if (obituaryList.items.isNotEmpty) {
        var fileesistente = obituaryList.items[0];
        fileesistente.delete();
      }
      await FirebaseStorage.instance.ref("$obituaryPath${obituaryFile!.name}").putData(obituaryFile!.file);



      var path = 'profile_images/deceased_images/UID:$uid/demiseId:$demiseId/';
      var fileList = await FirebaseStorage.instance.ref(path).listAll();
      if (fileList.items.isNotEmpty) {
        var fileesistente = fileList.items[0];
        fileesistente.delete();
      }
      if(fileName != "" ){
        await FirebaseStorage.instance.ref("$path$fileName").putData(fileBytes);
      }

      SuccessSnackbar(context, text: 'Defunto aggiunto con successo!');
      context.pop();
    }
    // } else {
    //   ErrorSnackbar(
    //     context,
    //       text: 'Impossibile aggiungere defunto!'
    //  );
    // }

  }

  void createNewRelativeRow() {
    selectedValues.add(kinship.first);
    var x = RelativeRow(
      onChanged: changeDropdown,
      relativeValidator: notEmptyValidate,
      relativeController: relativeController,
      deleteRelative: deleteRelative, changeKinship: (Kinship selectedKinship) {  }, statusChange: (String selectedValue) {  }, isDetail: false, selectedKinship: Kinship.brother, listKinship: const ['nonno'],

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
      print("ILPARENTE");
      print(value);
      var index = relativeRows.indexOf(relativeRow);
      selectedValues[index] = value;
      changeDropdown(relativeRow, value);
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

  DateTime? convertDate(String dateString) {
    var dt = dateString.split("-").reversed.join("-");
    return DateTime.parse(dt);
  }

}
