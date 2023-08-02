import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ripapp_dashboard/blocs/CurrentPageCubit.dart';
import 'package:ripapp_dashboard/blocs/profile_image_cubit.dart';
import 'package:ripapp_dashboard/blocs/selected_demise_cubit.dart';
import 'package:ripapp_dashboard/constants/kinships.dart';
import 'package:ripapp_dashboard/constants/route_constants.dart';
import 'package:ripapp_dashboard/models/DemiseRelative.dart';
import 'package:ripapp_dashboard/models/city_from_API.dart';
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
  String missingData = "Dato non inserito";
  final TextEditingController relativeController = TextEditingController();
  late List<DemiseRelative> relativeList = [];
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
          return BlocBuilder<SelectedDemiseCubit, SelectedDemiseState>(
              builder: (context, state) {
                relativeList = state.selectedDemise.relatives ?? [];
                createRelative();
                return ScaffoldWidget(
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: getPadding(top: 30, bottom: 30, left: 5, right: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PageHeader(
                            pageTitle: "Dettaglio decesso",
                            showBackButton: true,
                            onTap: (){
                              context.pop();
                              _currentPageCubit.changeCurrentPage(ScaffoldWidgetState.agency_demises_page);
                            },
                          ),

                          //deceased data
                          imageState.loaded ? DeceasedDetail(
                            imageFile: imageState.imageUrl,
                            downloadObituary: (){downloadFile(imageState.obituaryUrl);},
                            obituaryName: extractFileNameFromFirebaseUrl(imageState.obituaryUrl),
                            id:state.selectedDemise.id != null ? state.selectedDemise.id.toString() : missingData,
                            age: state.selectedDemise.age != null ? state.selectedDemise.age.toString() : missingData,
                            lastName: state.selectedDemise.lastName ?? missingData,
                            firstName: state.selectedDemise.firstName ?? missingData,
                            phoneNumber: state.selectedDemise.phoneNumber ?? missingData,
                            city: state.selectedDemise.city != null ? state.selectedDemise.city.toString() : missingData,
                            citiesOfInterest: state.selectedDemise.cities != null ? state.selectedDemise.cities!.map((e) => CityFromAPI(name: e.name)).toList() : [],
                            deceasedDate: state.selectedDemise.deceasedDate != null ? StringFormatters().getFormattedDate(state.selectedDemise.deceasedDate) : missingData,
                          ) : Container(),

                          //wake data
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: WakeDetail(
                                wakeDate:  StringFormatters().getFormattedDate(state.selectedDemise.wakeDateTime),
                                wakeNote:  state.selectedDemise.wakeNotes ?? missingData,
                                wakeHour:  StringFormatters().getFormattedTime(state.selectedDemise.wakeDateTime),
                                wakeAddress:  state.selectedDemise.wakeAddress ?? missingData,

                            ),
                          ),

                          //funeral data
                          Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: FuneralDetail(
                                  funeralDate: StringFormatters().getFormattedDate(state.selectedDemise.funeralDateTime),
                                  funeralNote: state.selectedDemise.funeralNotes ?? missingData,
                                  funeralHour: StringFormatters().getFormattedTime(state.selectedDemise.funeralDateTime),
                                  funeralAddress: state.selectedDemise.funeralAddress ?? missingData,
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
