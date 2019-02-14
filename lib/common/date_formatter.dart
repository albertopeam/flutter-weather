import 'package:intl/intl.dart';

class DateFormatter {

  static String date(DateTime dt) {
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(dt);
  }

  static String dateTime(DateTime dt) {
    DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm');
    return formatter.format(dt);
  }
  
}