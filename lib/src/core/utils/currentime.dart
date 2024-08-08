
import 'package:intl/intl.dart';

String currentTime(){

final now = DateTime.now();
String formattedTime = DateFormat.jm().format(now);
return formattedTime;
}