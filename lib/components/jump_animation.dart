///Created by Ian Paul on 1-08-2021 20:55
import 'package:flutter/material.dart';

class JumpAnimation extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  const JumpAnimation({Key? key, required this.animation, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      child: child,
      animation: animation,
      builder: (context, child){
        return Transform.translate(
              offset: Offset(0, animation.value),
              child: child,
        );
      },
    );
  }
}
