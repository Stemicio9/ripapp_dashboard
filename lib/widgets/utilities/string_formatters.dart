import 'package:intl/intl.dart';

class StringFormatters{

  String getFormattedDate(date){
    var formatter = DateFormat('dd/MM/yyyy');
    String dateString = formatter.format(date).toString();
    if (dateString == '09/09/9999')
      dateString = "Dato non inserito";
    return dateString;
  }

  String getFormattedTime(date){
    var formatter = DateFormat('HH:mm');
    return formatter.format(date).toString();
  }

}