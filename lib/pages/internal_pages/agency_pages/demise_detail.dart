
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
  String firstName = "Mario";
  String lastName = "Rossi";
  final String age = "89";
  final String id = "67";
  final String deceasedDate = "22-03-2023";
  final String cityOfInterest = "Milano";
  final String city = "Milano";
  final String phoneNumber = "3401234567";
  final String obituaryName = "Necrologio_Mario_Rossi.pdf";

  final String funeralDate = "24-03-2023";
  final String funeralNote = "Note del funerale";
  final String funeralAddress = "Via Roma, 56";
  final String funeralHour = "16:00";

  final String wakeHour = "09:00";
  final String wakeNote = "Note della veglia";
  final String wakeAddress = "Via Milano, 35";
  final String wakeDate= "23-03-2023";
  final TextEditingController relativeController = TextEditingController();
  late List<RelativeEntity> relativeList = [
     RelativeEntity(relativeName: 'Madre di', relativePhone: '3401234567'),
     RelativeEntity(relativeName: 'Padre di', relativePhone: '3409876543'),
  ];
  ProfileImageCubit get _profileImageCubit => context.read<ProfileImageCubit>();
  var imageFile = ImagesConstants.imgDemisePlaceholder;
  List<Widget> relativeRows = [];
  Future<dynamic> downloadUrlImage(String uid) async {
    var fileList = await FirebaseStorage.instance.ref('profile_images/deceased_images/$uid/').listAll();
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

  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser!;
    final uid = user.uid;
    downloadUrlImage(uid).then((value) => func(value));
    createRelative();
    return BlocBuilder<ProfileImageCubit, ProfileImageState>(
        builder: (context, imageState) {
          print("il nostro link è " + imageFile.toString());
          return  BlocBuilder<SelectedDemiseCubit, SelectedDemiseState>(
        builder: (context, state) {
      firstName = state.selectedDemise.firstName ?? "";
      lastName = state.selectedDemise.lastName ?? "";
      return


        ScaffoldWidget(
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
                 imageState.loaded ?  DeceasedDetail(
                     imageFile: imageFile,
                    downloadObituary: () {},
                    obituaryName: obituaryName,
                    id: id,
                    age: age,
                    lastName: lastName,
                    firstName: firstName,
                    phoneNumber: phoneNumber,
                    city: city,
                    cityOfInterest: cityOfInterest,
                    deceasedDate: deceasedDate,
                  ) : Container(),

                  //wake data
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: WakeDetail(
                        wakeDate: wakeDate,
                        wakeNote: wakeNote,
                        wakeHour: wakeHour,
                        wakeAddress: wakeAddress

                    ),
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
    }); });



  }

  createRelative(){
    relativeRows = [];
      for(var element in relativeList){
        relativeRows.add(
            RelativeDetailRow(
                relativeName: element.relativeName,
                relativePhone: element.relativePhone,
            ));
      }
  }

}
