
import 'package:flutter/material.dart';
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
  final String firstName = "Mario";
  final String lastName = "Rossi";
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

  late Image imageFile;
  final TextEditingController relativeController = TextEditingController();

  late List<RelativeEntity> relativeList = [
     RelativeEntity(relativeName: 'Madre di', relativePhone: '3401234567'),
     RelativeEntity(relativeName: 'Padre di', relativePhone: '3409876543'),
  ];

  List<Widget> relativeRows = [];

  @override
  Widget build(BuildContext context) {
    createRelative();
    return ScaffoldWidget(
      body: SingleChildScrollView(
        child: Padding(
          padding: getPadding(top: 40, bottom: 40, left: 5, right: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(
                leftPadding: const EdgeInsets.only(left: 5),
                showBackButton: true,
                onTap: null,
                showPageTitle: false,
                isVisible: false,
              ),

              //deceased data
              DeceasedDetail(
                  downloadObituary: (){},
                  obituaryName: obituaryName,
                  id: id,
                  age: age,
                  lastName: lastName,
                  firstName: firstName,
                  phoneNumber: phoneNumber,
                  city: city,
                  cityOfInterest: cityOfInterest,
                  deceasedDate: deceasedDate,
              ),

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
