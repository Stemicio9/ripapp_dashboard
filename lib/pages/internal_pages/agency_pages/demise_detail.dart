import 'dart:html' as html;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/blocs/profile_image_cubit.dart';
import 'package:ripapp_dashboard/blocs/selected_demise_cubit.dart';
import 'package:ripapp_dashboard/constants/images_constants.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/add_relative.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/deceased_detail.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/funeral_detail.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/relative_detail_row.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/wake_detail.dart';
import 'package:ripapp_dashboard/pages/internal_pages/header.dart';
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
  ProfileImageCubit get _profileImageCubit => context.read<ProfileImageCubit>();
  var imageFile = ImagesConstants.imgDemisePlaceholder;
  var obituaryName = "";
  var obituaryUrl = "";
  String firstName = "Mario";
  String lastName = "Rossi";
  final String age = "89";
  final String id = "67";
  final String deceasedDate = "22-03-2023";
  final String cityOfInterest = "Milano";
  final String city = "Milano";
  final String phoneNumber = "3401234567";
  final String funeralDate = "24-03-2023";
  final String funeralNote = "Note del funerale";
  final String funeralAddress = "Via Roma, 56";
  final String funeralHour = "16:00";
  final String wakeHour = "09:00";
  final String wakeNote = "Note della veglia";
  final String wakeAddress = "Via Milano, 35";
  final String wakeDate = "23-03-2023";
  final TextEditingController relativeController = TextEditingController();

  late List<RelativeEntity> relativeList = [
    RelativeEntity(relativeName: 'Madre di', relativePhone: '3401234567'),
    RelativeEntity(relativeName: 'Padre di', relativePhone: '3409876543'),
  ];



  List<Widget> relativeRows = [];

  void downloadFile(String url) {
    html.AnchorElement anchorElement =  html.AnchorElement(href: url);
    anchorElement.download = url;
    anchorElement.click();
  }


  Future<dynamic> downloadObituary(String uid, String demiseId) async {
    var fileList = await FirebaseStorage.instance
        .ref('obituaries/UID:$uid/demiseId:$demiseId/')
        .listAll();
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
      var fileList =
      await FirebaseStorage.instance.ref('profile_images/').listAll();
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
    _profileImageCubit.changeLoaded(true);
    obituaryUrl = value;
  }

  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser!;
    final uid = user.uid;
    createRelative();
    return BlocBuilder<ProfileImageCubit, ProfileImageState>(
        builder: (context, imageState) {
      return BlocBuilder<SelectedDemiseCubit, SelectedDemiseState>(
          builder: (context, state) {
        downloadUrlImage(uid, state.selectedDemise.firebaseid!)
            .then((value) => func(value));
        downloadObituary(uid, state.selectedDemise.firebaseid!).then((value) {
          obituary(value);
          obituaryName = extractFileNameFromFirebaseUrl(value);
        });

        firstName = state.selectedDemise.firstName ?? "";
        lastName = state.selectedDemise.lastName ?? "";
        return ScaffoldWidget(
          body: SingleChildScrollView(
            child: Padding(
              padding: getPadding(top: 40, bottom: 40, left: 5, right: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(
                    deleteProfileOnTap: () {},
                    leftPadding: const EdgeInsets.only(left: 5),
                    showBackButton: true,
                    onTap: null,
                    showPageTitle: false,
                    isVisible: false,
                  ),

                  //deceased data
                  imageState.loaded
                      ? DeceasedDetail(
                          imageFile: imageFile,
                          downloadObituary: (){downloadFile(obituaryUrl);},
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
                          funeralAddress: funeralAddress)),

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
        relativeName: element.relativeName,
        relativePhone: element.relativePhone,
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
}
