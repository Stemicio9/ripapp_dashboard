import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:ripapp_dashboard/blocs/search_demises_cubit.dart';
import 'package:ripapp_dashboard/models/CityEntity.dart';
import 'package:ripapp_dashboard/models/demise_entity.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/add_relative.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/deceased_data.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/funeral_data.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/relative_row.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/wake_data.dart';
import 'package:ripapp_dashboard/pages/internal_pages/header.dart';
import 'package:ripapp_dashboard/repositories/kinship_repository.dart';
import 'package:ripapp_dashboard/widgets/action_button.dart';
import 'package:ripapp_dashboard/widgets/scaffold.dart';
import 'package:cross_file/cross_file.dart';
import 'package:ripapp_dashboard/widgets/texts.dart';
import '../../../constants/colors.dart';
import '../../../constants/language.dart';
import '../../../utils/size_utils.dart';
import 'package:intl/intl.dart';

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
  final List<XFile> _list = [];

  DemiseCubit get _searchDemiseCubit => context.read<DemiseCubit>();
  bool _dragging = false;
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
    'Fratello',
    'Sorella',
    'Figlio',
    'Figlia',
    'Nonno',
    'Nonna',
  ];

  late Image imageFile;

  final List<Widget> relativeRows = [];

  @override
  void initState() {
    wakeTimeController.text = "";
    funeralTimeController.text = "";
    funeralDateController.text = "";
    wakeDateController.text = "";
    deceasedDateController.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: SingleChildScrollView(
        child: Padding(
          padding: getPadding(top: 40, bottom: 40, left: 5, right: 5),
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
               // imageFile: imageFile,
                imageOnTap: () async {
                  Image? pickedImage = await ImagePickerWeb.getImageAsWidget();
                  print(pickedImage);
                  setState(() {
                    if (pickedImage != null)
                      imageFile = pickedImage!;
                  });

                  //TODO SALVARE IMMAGINE SU FIRESTORAGE
                 // final storageRef = FirebaseStorage.instance.ref();
                //  final path = "profile_images/deceased_images/$imageFile";
                //  final imageRef = storageRef.child(path);
                //  imageRef.putFile(imageFile);

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
                                testo: 'Trascina qui un file',
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
                  showWakeTimePicker: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      confirmText: getCurrentLanguageValue(CONFIRM) ?? "",
                      cancelText: getCurrentLanguageValue(CANCEL) ?? "",
                    );
                    print("picked time = " + pickedTime.toString());
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
                    await KinshipRepository().getAllKinship();
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
                    ActionButtonV2(action: formSubmit, text: 'Crea'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  formSubmit() {
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

    String wakeTimeString = wakeTimeController.text;
    if (wakeTimeString != null && wakeTimeString != ""){
      List<String> timeParts = wakeTimeString.split(":");
      int? wakeHours = int.tryParse(timeParts[0]);
      int? wakeMinutes = int.tryParse(timeParts[1]);
      if (wakeMinutes != null && wakeHours != null && demiseEntity.wakeDateTime != null){
        demiseEntity.wakeDateTime = DateTime(demiseEntity.wakeDateTime!.year, demiseEntity.wakeDateTime!.month, demiseEntity.wakeDateTime!.day, wakeHours, wakeMinutes);
      }
    }
    String funeralTimeString = funeralTimeController.text;
    if (funeralTimeString != null && funeralTimeString != ""){
      List<String> timeParts = funeralTimeString.split(":");
      int? funeralHours = int.tryParse(timeParts[0]);
      int? funeralMinutes = int.tryParse(timeParts[1]);
      if (funeralMinutes != null && funeralHours != null && demiseEntity.funeralDateTime != null){
        demiseEntity.funeralDateTime = DateTime(demiseEntity.funeralDateTime!.year, demiseEntity.funeralDateTime!.month, demiseEntity.funeralDateTime!.day, funeralHours, funeralMinutes);
      }
    }
    if ( demiseEntity.deceasedDate != null && demiseEntity.wakeDateTime != null && demiseEntity.funeralDateTime != null){
      if ( demiseEntity.deceasedDate!.isAfter(demiseEntity.wakeDateTime!) || demiseEntity.deceasedDate!.isAfter(demiseEntity.funeralDateTime!) )
        throw new Exception("incoherent dates");
    }


    demiseEntity.wakeNote = (wakeNoteController.text);
    demiseEntity.funeralAddress= (funeralAddressController.text);
    demiseEntity.funeralDateTime = (funeralDateController.text != "" && funeralDateController.text != null) ? convertDate(funeralDateController.text) : null;
    demiseEntity.funeralNotes = (funeralNoteController.text);
    //demiseEntity.cities = (citiesController.text);
    //demiseEntity.relative = (relativeController.text);

    //_searchDemiseCubit.saveProduct(demiseEntity);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: green,
        content: const Text('Defunto aggiunto con successo!'),
        duration: const Duration(milliseconds: 3000),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
    Navigator.pop(context);
  }

  void createNewRelativeRow() {
    selectedValues.add(kinship.first);
    var x = RelativeRow(
        onChanged: changeDropdown,
        kinship: kinship,
        relativeController: relativeController,
        deleteRelative: deleteRelative,
        value: selectedValues.last,
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

  DateTime? convertDate(String dateString) {
    var dt = dateString.split("-").reversed.join("-");
    return DateTime.parse(dt);
  }

}
