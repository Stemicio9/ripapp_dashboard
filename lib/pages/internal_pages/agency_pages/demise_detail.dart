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
  String firstName = "Mario";
  String lastName = "Rossi";
  String age = "89";
  String id = "67";
  String deceasedDate = "22-03-2023";
  String cityOfInterest = "Milano";
  String city = "Milano";
  String phoneNumber = "3401234567";
  String funeralDate = "24-03-2023";
  String funeralNote = "Note del funerale";
  String funeralAddress = "Via Roma, 56";
  String funeralHour = "16:00";
  String wakeHour = "09:00";
  String wakeNote = "Note della veglia";
  String wakeAddress = "Via Milano, 35";
  String wakeDate = "23-03-2023";
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



        firstName = state.selectedDemise.firstName ?? "";
        lastName = state.selectedDemise.lastName ?? "";
        phoneNumber = state.selectedDemise.phoneNumber ?? "";
        print('allopa?' + state.selectedDemise.relatives.toString());
        relativeList = state.selectedDemise.relatives ?? [];
        createRelative();
        lastName = state.selectedDemise.lastName ?? "";
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
}
