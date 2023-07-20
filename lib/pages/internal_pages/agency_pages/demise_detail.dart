import 'dart:html' as html;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/blocs/CurrentPageCubit.dart';
import 'package:ripapp_dashboard/blocs/profile_image_cubit.dart';
import 'package:ripapp_dashboard/blocs/selected_demise_cubit.dart';
import 'package:ripapp_dashboard/constants/images_constants.dart';
import 'package:ripapp_dashboard/constants/kinships.dart';
import 'package:ripapp_dashboard/constants/route_constants.dart';
import 'package:ripapp_dashboard/models/DemiseRelative.dart';
import 'package:ripapp_dashboard/models/demise_entity.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/add_relative.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/deceased_detail.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/funeral_detail.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/relative_detail_row.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/wake_detail.dart';
import 'package:ripapp_dashboard/pages/internal_pages/header.dart';
import 'package:ripapp_dashboard/pages/internal_pages/page_header.dart';
import 'package:ripapp_dashboard/widgets/scaffold.dart';
import '../../../models/relative_entity.dart';
import '../../../utils/size_utils.dart';

class DemiseDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DemiseDetailState();
  }
}

class DemiseDetailState extends State<DemiseDetail> {
  CurrentPageCubit get _currentPageCubit => context.read<CurrentPageCubit>();
  ProfileImageCubit get _profileImageCubit => context.read<ProfileImageCubit>();
  SelectedDemiseCubit  get _selectedDemiseCubit => context.read<SelectedDemiseCubit>();
  var imageFile = ImagesConstants.imgDemisePlaceholder;
  var obituaryName = "";
  var obituaryUrl = "";
  String firstName = "";
  String lastName = "";
  String age = "";
  String id = "";
  String deceasedDate = "";
  String cityOfInterest = "";
  String city = "";
  String phoneNumber = "";
  String funeralDate = "";
  String funeralNote = "";
  String funeralAddress = "";
  String funeralHour = "";
  String wakeHour = "";
  String wakeNote = "";
  String wakeAddress = "";
  String wakeDate = "";
  String missingData = "Dato non inserito";
  final TextEditingController relativeController = TextEditingController();

  late List<DemiseRelative> relativeList = [];

  List<Widget> relativeRows = [];


  @override
  void initState() {
    final User user = FirebaseAuth.instance.currentUser!;
    final uid = user.uid;
    String demiseId = _selectedDemiseCubit.state.selectedDemise.firebaseid!;
    _profileImageCubit.fetchProfileImage(uid, demiseId);
    _profileImageCubit.fetchObituary(uid, demiseId);
    super.initState();
  }

  void downloadFile(String url) {
    html.AnchorElement anchorElement =  html.AnchorElement(href: url);
    anchorElement.download = url;
    anchorElement.click();
  }


  Future<dynamic> downloadObituary(String uid, String demiseId) async {
    var fileList = await FirebaseStorage.instance.ref('obituaries/UID:$uid/demiseId:$demiseId/').listAll();
    var file = fileList.items[0];
    var result = await file.getDownloadURL();
    return result;
  }

  Future<dynamic> downloadUrlImage(String uid, String demiseId) async {
    var fileList = await FirebaseStorage.instance
        .ref('profile_images/deceased_images/UID:$uid/demiseId:$demiseId/')
        .listAll();
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

  void func(value) {
    _profileImageCubit.changeLoaded(true);
    imageFile = value;
  }

  void obituary(value) {
    obituaryUrl = value;
  }

  @override
  Widget build(BuildContext context) {
    _currentPageCubit.changeCurrentPage(RouteConstants.demiseDetail);
    return BlocBuilder<ProfileImageCubit, ProfileImageState>(
        builder: (context, imageState) {
      return BlocBuilder<SelectedDemiseCubit, SelectedDemiseState>(
          builder: (context, state) {


        fillValues(state.selectedDemise);
        createRelative();
        return ScaffoldWidget(
          body: SingleChildScrollView(
            child: Padding(
              padding: getPadding(top: 30, bottom: 30, left: 5, right: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PageHeader(
                    pageTitle: "Dettaglio decesso",
                    showBackButton: true,
                  ),

                  //deceased data
                  imageState.loaded
                      ? DeceasedDetail(
                          imageFile: imageFile,
                          downloadObituary: (){downloadFile(imageState.obituaryUrl);},
                          obituaryName: obituaryName,
                          id: id,
                          age: age,
                          lastName: lastName,
                          firstName: firstName,
                          phoneNumber: phoneNumber,
                          city: city,
                          cityOfInterest: cityOfInterest,
                          deceasedDate: deceasedDate,
                        )
                      : Container(),

                  //wake data
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: WakeDetail(
                        wakeDate: wakeDate,
                        wakeNote: wakeNote,
                        wakeHour: wakeHour,
                        wakeAddress: wakeAddress),
                  ),

                  //funeral data
                  Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: FuneralDetail(
                          funeralDate: funeralDate,
                          funeralNote: funeralNote,
                          funeralHour: funeralHour,
                          funeralAddress: funeralAddress
                      )
                  ),

                  //add relative
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: AddRelative(
                      isDetail: true,
                      relativeRows: relativeRows,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
    });
  }

  createRelative() {
    relativeRows = [];
    for (var element in relativeList) {
      relativeRows.add(RelativeDetailRow(
        relativeName: element.kinshipType!.toShortString(),
        relativePhone: element.telephoneNumber,
      ));
    }
  }

  extractFileNameFromFirebaseUrl(value) {
    var x = Uri.parse(value).pathSegments;
    if (x.length > 1) {
      var l = x[x.length - 1].split('/');
      return l[l.length - 1];
    }
    return '';
  }

  /*  better todo something like that for dates
  DatelabelWidget{
    final Date x;

    build{
      Dateformat.format("MM..");
    }
  }*/
  void fillValues(DemiseEntity demiseEntity) {
    firstName = (demiseEntity.firstName != null) ? demiseEntity.firstName.toString() : missingData;
    lastName = ( demiseEntity.lastName != null) ? demiseEntity.lastName.toString() : missingData;
    phoneNumber = ( demiseEntity.phoneNumber != null) ? demiseEntity.phoneNumber.toString() : missingData;
    age = ( demiseEntity.age != null ) ? demiseEntity.age.toString() : missingData;
    id = demiseEntity.id.toString();
    deceasedDate = ( demiseEntity.deceasedDate != null ) ? demiseEntity.deceasedDate.toString() : missingData;

    if (demiseEntity.deceasedDate != null){
      deceasedDate = demiseEntity.deceasedDate!.day.toString() + "/"+ demiseEntity.deceasedDate!.month.toString() + "/" +
          demiseEntity.deceasedDate!.year.toString();
    } else deceasedDate = missingData;

    //cityOfInterest = demiseEntity.cities.toString(); todo decide how to handle city list
    city = ( demiseEntity.city != null ) ? demiseEntity.city.toString() : missingData;
    phoneNumber = ( demiseEntity.phoneNumber != null ) ? demiseEntity.phoneNumber.toString() : missingData;
    funeralNote = ( demiseEntity.funeralNotes != null ) ? demiseEntity.funeralNotes.toString() : missingData;
    funeralAddress = ( demiseEntity.funeralAddress != null ) ? demiseEntity.funeralAddress.toString() : missingData;

    if (demiseEntity.funeralDateTime != null){
      funeralDate = demiseEntity.funeralDateTime!.day.toString() + "/"+ demiseEntity.funeralDateTime!.month.toString() + "/" +
          demiseEntity.funeralDateTime!.year.toString();
      funeralHour = (demiseEntity.funeralDateTime!.hour < 10) ? "0" : "";
      funeralHour += (demiseEntity.funeralDateTime!.hour.toString() + ":"+ demiseEntity.funeralDateTime!.minute.toString());
    } else {
      funeralDate = missingData;
      funeralHour = missingData;
    }

    wakeNote = ( demiseEntity.wakeNotes != null ) ? demiseEntity.wakeNotes.toString() : missingData;
    wakeAddress = ( demiseEntity.wakeAddress != null ) ? demiseEntity.wakeAddress.toString() : missingData;

    wakeDate = ( demiseEntity.wakeDateTime != null ) ? demiseEntity.wakeDateTime.toString() : missingData;
    wakeHour = ( demiseEntity.wakeDateTime != null ) ? demiseEntity.wakeDateTime.toString() : missingData;

    if (demiseEntity.wakeDateTime != null){
      wakeDate = demiseEntity.wakeDateTime!.day.toString() + "/"+ demiseEntity.wakeDateTime!.month.toString() + "/" +
          demiseEntity.wakeDateTime!.year.toString();
      wakeHour = (demiseEntity.wakeDateTime!.hour < 10) ? "0" : "";
      wakeHour += demiseEntity.wakeDateTime!.hour.toString() + ":"+ demiseEntity.wakeDateTime!.minute.toString();
    } else {wakeDate = missingData;
      wakeHour = missingData;
    }

    relativeList = demiseEntity.relatives ?? [];
  }

  void fillDate(DateTime? dateTime, String date, String time) {
    if (dateTime != null) {
      String dateTimeString = dateTime.toString();
      date = dateTimeString.split(" ").first;
      time = dateTimeString.split(" ").last;
      List<String> timeComponents = time.split(":");
      String hours = timeComponents[0];
      String minutes = timeComponents[1];
      time = hours + ":" + minutes;
      print("eccoci la time  " + time);
    } else {
        date = missingData;
        time = missingData;
    }
  }

}
