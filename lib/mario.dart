import 'dart:math';

import 'package:flutter/material.dart';

class MyMario extends StatelessWidget {
  MyMario({super.key, this.direction, this.midRun, this.size});
  final direction;
  final midRun;
  final size;

  @override
  Widget build(BuildContext context) {
    if (direction == 'right') {
      return Container(
        width: size,
        height: size,
        child: midRun!
            ? Image.asset('MarioImages/runningMario.png')
            : Image.asset('MarioImages/standingMario.png'),
      );
    } else {
      return Transform(
        transform: Matrix4.rotationY(pi),
        child: Container(
          width: size,
          height: size,
          child: midRun!
              ? Image.asset('MarioImages/runningMario.png')
              : Image.asset('MarioImages/standingMario.png'),
        ),
      );
    }
  }
}
