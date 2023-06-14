
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:ripapp_dashboard/models/demise_entity.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/add_relative.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/deceased_data.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/funeral_data.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/relative_row.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/wake_data.dart';
import 'package:ripapp_dashboard/pages/internal_pages/header.dart';
import 'package:ripapp_dashboard/widgets/scaffold.dart';
import 'package:cross_file/cross_file.dart';
import 'package:ripapp_dashboard/widgets/texts.dart';
import '../../../constants/colors.dart';
import '../../../constants/language.dart';
import '../../../constants/validators.dart';
import '../../../models/CityEntity.dart';
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
  final TextEditingController addressController = TextEditingController();
  final TextEditingController wakeDateController = TextEditingController();
  final TextEditingController wakeTimeController = TextEditingController();
  final TextEditingController wakeNoteController = TextEditingController();
  final TextEditingController wakwAddressController = TextEditingController();
  final TextEditingController funeralAddressController = TextEditingController();
  final TextEditingController funeralDateController = TextEditingController();
  final TextEditingController funeralTimeController = TextEditingController();
  final TextEditingController funeralNoteController = TextEditingController();
  final TextEditingController citiesController = TextEditingController();
  final TextEditingController relativeController = TextEditingController();
  final TextEditingController filterController = TextEditingController();
  final List<XFile> _list = [];
  bool _dragging = false;
  final _formKey = GlobalKey<FormState>();

  Offset? offset;
  DateTime? wakeDate;
  DateTime? funeralDate;
  static const List<String> cityOptions = <String>[
    'Milano',
    'Roma',
    'Firenze',
    'Torino',
  ];
  static const List<String> citiesOfInterestOptions = <String>[
    'Milano',
    'Roma',
    'Firenze',
    'Torino',
  ];
  static const List<String> kinship = <String>[
    'Madre',
    'Padre',
  ];

  late Image imageFile;

  final List<Widget> relativeRows = [];

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: SingleChildScrollView(
        child: Padding(
          padding: getPadding(top: 40, bottom: 40, left: 5, right: 5),
          child: Form(
            key: _formKey,
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
                DeceasedData(
                  //imageFile: imageFile,
                  imageOnTap: () async {
                    //TODO: IMPLEMENTARE IMAGEPICKER
                    // Uint8List? bytesFromPicker = await ImagePickerWeb.getImageAsBytes();
                    Image? pickedImage = await ImagePickerWeb.getImageAsWidget();
                    print(pickedImage);
                    setState(() {
                      imageFile = pickedImage!;
                    });
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
                  phoneValidator:notEmptyValidate ,
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
                  onDragDone: (detail) async {
                    setState(() {
                      _list.addAll(detail.files);
                    });

                    debugPrint('onDragDone:');
                    for (final file in detail.files) {
                      debugPrint('  ${file.path} ${file.name}'
                          '  ${await file.lastModified()}'
                          '  ${await file.length()}'
                          '  ${file.mimeType}');
                    }
                  },
                  onDragUpdated: (details) {
                    setState(() {
                      offset = details.localPosition;
                    });
                  },
                  onDragEntered: (detail) {
                    setState(() {
                      _dragging = true;
                      offset = detail.localPosition;
                    });
                  },
                  onDragExited: (detail) {
                    setState(() {
                      _dragging = false;
                      offset = null;
                    });
                  },
                  child: DottedBorder(
                    strokeWidth: 1,
                    child: Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color:
                        _dragging ? Colors.blue.withOpacity(0.4) : greyDrag,
                      ),
                      child: Stack(
                        children: [
                          if (_list.isEmpty)
                            Center(
                              child: Texth2V2(
                                testo: "Trascina qui un file",
                                color: greyDisabled,
                                weight: FontWeight.bold,
                              ),

                            )
                          else
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Texth4V2(
                                testo: _list.map((e) => e.name).join("\n"),
                                color: black,
                                weight: FontWeight.bold,
                              ),
                            ),
                          if (offset != null)
                            Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                '$offset',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                ),

                //wake data
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: WakeData(
                    timeController: wakeTimeController,
                    addressController: addressController,
                    dateController: wakeDateController,
                    wakeNoteController: wakeNoteController,
                    timeValidator: notEmptyValidate,
                    dateValidator: notEmptyValidate,
                    addressValidator: notEmptyValidate,
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
                    addRelative: () {
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
                      ActionButtonV2(action: formSubmit, text: getCurrentLanguageValue(SAVE) ?? ""),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }



  formSubmit() {
    if(_formKey.currentState!.validate()){
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
        kinship: kinship,
        relativeController: relativeController,
        deleteRelative: deleteRelative,
        relativeValidator: notEmptyValidate,
        value: selectedValues.last
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
