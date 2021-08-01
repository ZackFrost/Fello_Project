///Created by Ian Paul on 1-08-2021 20:10
import 'package:fello_demo_app/components/custom_logo.dart';
import 'package:fello_demo_app/components/jump_animation.dart';
import 'package:fello_demo_app/utils/color_utils.dart';
import 'package:fello_demo_app/utils/common_utils.dart';
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _tweenValue;

  @override
  void initState() {
    if (mounted) {
      _controller = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
      //Increase the end value for higher jump
      _tweenValue = Tween<double>(begin: 0, end: -160).animate(_controller!)
        //Checking if an animation is complete and reverse it
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) _controller!.reverse();
        });
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if(mounted) _controller!.dispose();
  }

  void _onTap() {
    _controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: BACKGROUND_COLOR,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: CommonUtils().getDeviceWidth(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomLogo(),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: JumpAnimation(
                        animation: _tweenValue!,
                        child: Image(
                          image: AssetImage("assets/mario.png"),
                          width: 180,
                          height: 180,
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 50),
                    child: GestureDetector(
                      onTap: _onTap,
                      child: Container(
                          decoration: BoxDecoration(color: COOL_PURPLE, borderRadius: BorderRadius.circular(6)),
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                          child: Text(
                            "Jump!",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                          )),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
