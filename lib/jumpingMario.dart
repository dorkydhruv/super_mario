import 'dart:math';

import 'package:flutter/material.dart';

class JumpingMario extends StatelessWidget {
  const JumpingMario({super.key, this.direction, this.size});
  final direction;
  final size;

  @override
  Widget build(BuildContext context) {
    if (direction == 'right') {
      return Container(
        width: size,
        height: size,
        child: Image.asset('MarioImages/jumpingMario.png'),
      );
    } else {
      return Transform(
        transform: Matrix4.rotationY(pi),
        child: Container(
          width: size,
          height: size,
          child: Image.asset('MarioImages/jumpingMario.png'),
        ),
      );
    }
  }
}
