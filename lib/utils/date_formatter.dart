import 'package:intl/intl.dart';

String dateFormatted(){
  var now = DateTime.now();

  var foramter = DateFormat("EEE, MMM d, ''yy");
  
  String fortm = foramter.format(now);
  return fortm;
}