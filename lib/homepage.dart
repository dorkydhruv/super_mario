import 'dart:async';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_mario/button.dart';
import 'package:super_mario/jumpingMario.dart';
import 'package:super_mario/mario.dart';
import 'package:super_mario/shrooms.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double marioX = 0;
  static double marioY = 1;
  static double shroomX = 0.5;
  static double shroomY = 1;
  double marioSize = 70;
  double time = 0;
  double height = 0;
  double initialHeight = marioY;
  String direction = 'right';
  bool midRun = false;
  bool midjump = false;
  var gameFont = GoogleFonts.pressStart2p(
      textStyle: const TextStyle(color: Colors.white, fontSize: 20));

  void checkShroomAte() {
    if ((marioX - shroomX).abs() < 0.05 && (marioY - shroomY).abs() < 0.05) {
      setState(() {
        shroomX = 2;
        marioSize = 120;
      });
    }
  }

  void preJump() {
    time = 0;
    initialHeight = marioY;
  }

  void jump() {
    if (!midjump) {
      midjump = true;
      preJump();
      Timer.periodic(Duration(milliseconds: 50), (timer) {
        time += 0.05;
        height = -4.9 * time * time + 5 * time;

        if (initialHeight - height > 1) {
          midjump = false;
          setState(() {
            marioY = 1;
          });
          timer.cancel();
        } else {
          setState(() {
            marioY = initialHeight - height;
          });
        }
      });
    }
  }

  void moveRight() {
    direction = 'right';
    checkShroomAte();
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      checkShroomAte();
      if (MyButton().userIsHoldingButton() == true && marioX + 0.02 < 1) {
        setState(() {
          marioX += 0.02;
          midRun = !midRun;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void moveLeft() {
    direction = 'left';
    checkShroomAte();
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      checkShroomAte();
      if (MyButton().userIsHoldingButton() == true && marioX - 0.02 > -1) {
        setState(() {
          marioX -= 0.02;
          midRun = !midRun;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                Container(
                  color: CupertinoColors.activeBlue,
                  child: AnimatedContainer(
                    alignment: Alignment(marioX, marioY),
                    duration: Duration.zero,
                    child: midjump
                        ? JumpingMario(
                            direction: direction,
                            size: marioSize,
                          )
                        : MyMario(
                            direction: direction,
                            midRun: midRun,
                            size: marioSize),
                  ),
                ),
                Container(
                  child: Mushroom(),
                  alignment: Alignment(shroomX, shroomY),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            'MARIO',
                            style: gameFont,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text('000', style: gameFont),
                        ],
                      ),
                      Column(
                        children: [
                          Text('MARIO', style: gameFont),
                          const SizedBox(
                            height: 10,
                          ),
                          Text('1-1', style: gameFont),
                        ],
                      ),
                      Column(
                        children: [
                          Text('MARIO', style: gameFont),
                          const SizedBox(
                            height: 10,
                          ),
                          Text('9999', style: gameFont),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: const Color.fromARGB(230, 73, 48, 15),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MyButton(
                      iconData: Icons.arrow_back,
                      function: moveLeft,
                    ),
                    MyButton(
                      iconData: Icons.arrow_upward,
                      function: jump,
                    ),
                    MyButton(
                      iconData: Icons.arrow_right_alt,
                      function: moveRight,
                    )
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
