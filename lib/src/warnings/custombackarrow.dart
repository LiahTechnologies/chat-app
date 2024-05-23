

import 'package:flutter/material.dart';
import 'package:njadia/src/utils/naviagtion.dart';

class CustomBackArrow extends StatelessWidget {
  const CustomBackArrow({super.key});

  @override
  Widget build(BuildContext context) {
    return  IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 18,
            color: Theme.of(context).colorScheme.background,
          ),
          onPressed: () => BackScreen(context: context),
        );
  }
}