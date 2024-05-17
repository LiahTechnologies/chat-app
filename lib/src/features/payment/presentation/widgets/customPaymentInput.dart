import 'package:flutter/material.dart';
import 'package:njadia/src/core/common/constants/style/color.dart';

class CustomPaymetInput extends StatelessWidget {
  const CustomPaymetInput({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return  TextField(
      controller: controller,
      decoration:  InputDecoration(focusColor: Theme.of(context).iconTheme.color),
    );
  }
}
