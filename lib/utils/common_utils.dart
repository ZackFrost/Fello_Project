///Created by Ian Paul on 1-08-2021 22:48

import 'package:fello_demo_app/utils/color_utils.dart';
import 'package:flutter/material.dart';

class CommonUtils{

  double getDeviceWidth(BuildContext context, {double percentage = 100}) => MediaQuery.of(context).size.width * percentage / 100;

  double getDeviceHeight(BuildContext context, {double percentage = 100}) => MediaQuery.of(context).size.height * percentage / 100;

  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: COOL_PURPLE,
        content: Text(message, style: TextStyle(color: Colors.white), overflow: TextOverflow.ellipsis),
      ),
    );
  }
}