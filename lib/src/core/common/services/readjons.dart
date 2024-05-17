import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

// String readJson(String name) {
//   var dir = Directory.current.path;

//   if (dir.endsWith("/test")) {
//     dir = dir.replaceAll("/test", "");
//   }

//   return File("$dir/test/$name").readAsStringSync();
// }

Future<Map<String,dynamic>> readJson(String path) async {
  final String response = await rootBundle.loadString('$path');
  final data = await json.decode(response);
  print("THIS IS  THE LOAD DATA  ${data['groups']}");
  return data;
}
