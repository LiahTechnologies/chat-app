import 'package:flutter/material.dart';

Future<DateTime?> customDatePicker(BuildContext context) async {
  DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2400));
  return date;
}
