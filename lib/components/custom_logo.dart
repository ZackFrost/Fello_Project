///Created by Ian Paul on 2-08-2021 02:51
import 'package:fello_demo_app/utils/common_utils.dart';
import "package:flutter/material.dart";

class CustomLogo extends StatelessWidget {
  const CustomLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Image(
        image: AssetImage("assets/dummy_logo.png"),
        height: 50,
      ),
    );
  }
}
