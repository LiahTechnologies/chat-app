import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetConnectionCheckerClass{


 Future<bool> init()async=> await InternetConnectionChecker().hasConnection;
  
}