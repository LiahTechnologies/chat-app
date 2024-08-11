

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

double deviceHeight(BuildContext context)=>  MediaQuery.of(context).size.height;

double deviceWidth(BuildContext context)=>  MediaQuery.of(context).size.width;

deviceOrientation(BuildContext context)=>MediaQuery.of(context).orientation;
