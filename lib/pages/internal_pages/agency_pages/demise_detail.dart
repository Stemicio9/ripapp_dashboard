import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/blocs/CurrentPageCubit.dart';
import 'package:ripapp_dashboard/blocs/profile_image_cubit.dart';
import 'package:ripapp_dashboard/blocs/selected_demise_cubit.dart';
import 'package:ripapp_dashboard/constants/images_constants.dart';
import 'package:ripapp_dashboard/constants/kinships.dart';
import 'package:ripapp_dashboard/constants/route_constants.dart';
import 'package:ripapp_dashboard/models/DemiseRelative.dart';
import 'package:ripapp_dashboard/models/city_from_API.dart';
import 'package:ripapp_dashboard/models/demise_entity.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/add_relative.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/deceased_detail.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/funeral_detail.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/relative_detail_row.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/wake_detail.dart';
import 'package:ripapp_dashboard/pages/internal_pages/page_header.dart';
import 'package:ripapp_dashboard/widgets/scaffold.dart';
import 'package:ripapp_dashboard/widgets/utilities/string_formatters.dart';
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
  late List<CityFromAPI> citiesOfInterest = [];
  List<Widget> relativeRows = [];


  @override
  void initState() {
    String demiseId = _selectedDemiseCubit.state.selectedDemise.firebaseid!;
    _profileImageCubit.fetchProfileImage(demiseId);
    _profileImageCubit.fetchObituary(demiseId);
    super.initState();
  }

  void downloadFile(String url) {
    html.AnchorElement anchorElement =  html.AnchorElement(href: url);
    anchorElement.download = url;
    anchorElement.click();
  }

  @override
  Widget build(BuildContext context) {
    _currentPageCubit.changeCurrentPage(RouteConstants.demiseDetail);
    return BlocBuilder<ProfileImageCubit, ProfileImageState>(
        builder: (context, imageState) {
      obituaryName = extractFileNameFromFirebaseUrl(imageState.obituaryUrl);
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
                          imageState.loaded ? DeceasedDetail(
                            imageFile: imageState.imageUrl,
                            downloadObituary: (){downloadFile(imageState.obituaryUrl);},
                            obituaryName: obituaryName,
                            id: id,
                            age: age,
                            lastName: lastName,
                            firstName: firstName,
                            phoneNumber: phoneNumber,
                            city: city,
                            citiesOfInterest: citiesOfInterest,
                            deceasedDate: deceasedDate,
                          ) : Container(),

                          //wake data
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: WakeDetail(
                                wakeDate: wakeDate,
                                wakeNote: wakeNote,
                                wakeHour: wakeHour,
                                wakeAddress: wakeAddress,

                            ),
                          ),

                          //funeral data
                          Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: FuneralDetail(
                                  funeralDate: funeralDate,
                                  funeralNote: funeralNote,
                                  funeralHour: funeralHour,
                                  funeralAddress: funeralAddress,
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

  void fillValues(DemiseEntity demiseEntity) {
    firstName = demiseEntity.firstName != null ? demiseEntity.firstName.toString() : missingData;
    lastName =  demiseEntity.lastName != null ? demiseEntity.lastName.toString() : missingData;
    phoneNumber = demiseEntity.phoneNumber != null ? demiseEntity.phoneNumber.toString() : missingData;
    age =  demiseEntity.age != null ? demiseEntity.age.toString() : missingData;
    id = demiseEntity.id.toString();
    citiesOfInterest = demiseEntity.cities != null ? demiseEntity.cities!.map((e) => CityFromAPI(name: e.name)).toList(): [];
    city = demiseEntity.city != null  ? demiseEntity.city.toString() : missingData;
    phoneNumber = demiseEntity.phoneNumber != null ? demiseEntity.phoneNumber.toString() : missingData;
    deceasedDate = demiseEntity.deceasedDate != null ? StringFormatters().getFormattedDate(demiseEntity.deceasedDate) : missingData;
    funeralNote = demiseEntity.funeralNotes != null ? demiseEntity.funeralNotes.toString() : missingData;
    funeralAddress = demiseEntity.funeralAddress != null ? demiseEntity.funeralAddress.toString() : missingData;
    if (demiseEntity.funeralDateTime != null){
      funeralDate = StringFormatters().getFormattedDate(demiseEntity.funeralDateTime);
      funeralHour = StringFormatters().getFormattedTime(demiseEntity.funeralDateTime);
    } else {
      wakeDate = missingData;
      wakeHour = missingData;
    }
    wakeNote = demiseEntity.wakeNotes != null ? demiseEntity.wakeNotes.toString() : missingData;
    wakeAddress = demiseEntity.wakeAddress != null ? demiseEntity.wakeAddress.toString() : missingData;
    if (demiseEntity.wakeDateTime != null){
      wakeDate = StringFormatters().getFormattedDate(demiseEntity.wakeDateTime);
      wakeHour = StringFormatters().getFormattedTime(demiseEntity.wakeDateTime);
    } else {
      wakeDate = missingData;
      wakeHour = missingData;
    }

    relativeList = demiseEntity.relatives ?? [];
  }

}
