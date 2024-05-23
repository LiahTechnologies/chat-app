
import 'package:flutter/material.dart';

customGetxBottomsheet(Widget child, BuildContext context,
    {bool? enbaleDrag = false, bool? isDismissable = true}) {
  return showModalBottomSheet(
    context: context,
    builder: (context) => Scaffold(
      resizeToAvoidBottomInset: false,
      body: child,
    ),
  );
}
