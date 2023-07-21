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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: getPadding(bottom: 5),
          child: Text(
            dateLabelInfo.name,
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
    );
  }
}

class DateLabelInfo {
  DateTime date;
  String name;

  DateLabelInfo({required this.date, required this.name});

  String getFormattedDate(){
    var formatter = DateFormat('dd/MM/yyyy');
    print(formatter.format(date));
    return formatter.format(date).toString();
  }
}
