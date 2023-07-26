import 'package:flutter/cupertino.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/utils/style_utils.dart';
import 'package:ripapp_dashboard/widgets/texts.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class DateLabelWidget extends StatelessWidget {

  final DateLabelInfo dateLabelInfo;

  const DateLabelWidget({Key? key, required this.dateLabelInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          Expanded(
              flex: 1,
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: getPadding(bottom: 5),
                    child: Text(
                      dateLabelInfo.dateName,
                      style: SafeGoogleFont(
                        'Montserrat',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: background,
                      ),
                    ),
                  ),
                  Texth3V2(testo: dateLabelInfo.getFormattedDate(), color: black),
                ],
              )
          ),


          Expanded(
              flex: 1,
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: getPadding(bottom: 5),
                    child: Text(
                      dateLabelInfo.timeName,
                      style: SafeGoogleFont(
                        'Montserrat',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: background,
                      ),
                    ),
                  ),
                  Texth3V2(testo: dateLabelInfo.getFormattedTime(), color: black),
                ],
              )
          )
        ]
    );
  }
}

class DateLabelInfo {
  DateTime date;
  String dateName;
  String timeName;

  DateLabelInfo({required this.date, required this.dateName, required this.timeName});

  String getFormattedDate(){
    var formatter = DateFormat('dd/MM/yyyy');
    String dateString = formatter.format(date).toString();
    if (dateString == '09/09/9999')
      dateString = "Dato non inserito";
    return dateString;
  }

  String getFormattedTime(){
    var formatter = DateFormat('HH:mm');
    return formatter.format(date).toString();;
  }
}
