import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:ladder_game/create_ladder.dart';
import 'package:ladder_game/ladder_interface.dart';
import 'dart:async';

class LadderPage extends StatefulWidget {
  LadderPage({Key? key}) : super(key: key);

  @override
  State<LadderPage> createState() => _LadderPageState();
}

class _LadderPageState extends State<LadderPage> implements LadderInterface {
  bool selected = false;
  var gameBoard;
  //var moveDatas = List.generate(5, (index) => { }, growable: false);

  double top1 = 35;
  double left1 = 0;

  double top2 = 35;
  double left2 = 100;

  double top3 = 35;
  double left3 = 200;

  double top4 = 35;
  double left4 = 300;

  double top5 = 35;
  double left5 = 400;

  double grayBoxX = 450;
  double grayBoxY = 320;


  Map<String, int> stateEnum = {
    'IDLE': 0,
    'L': 1,
    'T': 2,
    'R': 3,
    'B': 4,
  };

  @override
  Widget build(BuildContext context) {
    CreateLadder createLadder = CreateLadder(context, this);

    // for(int index = 0; index < 5; index++){
    //   var map = <String, double>{};
    //   map['top'] = 0;
    //   map['left'] = 0;
    //   map['right'] = 0;
    //   moveDatas[index] = map;
    // }

    return Scaffold(
        appBar: AppBar(title: const Text('Ladder Game')),
        body: Stack(
          children: [
            CustomPaint(painter: createLadder),

            GestureDetector(
              onTap: () {
                setState(() {
                  resetPosition(0);
                  createLadder.gameBoardLog();
                  startTimer(0, createLadder.checkNumber(1));
                });
              },
              child: animatedBtn('1', 60, 30, const EdgeInsets.fromLTRB(20, 50, 0, 0), left1, top1, 0, 0, Colors.blue),
            ),

            GestureDetector(
              onTap: () {
                setState(() {
                  resetPosition(1);
                  createLadder.gameBoardLog();
                  startTimer(1, createLadder.checkNumber(2));
                });
              },
              child: animatedBtn('2', 60, 30, const EdgeInsets.fromLTRB(20, 50, 0, 0), left2, top2, 0, 0, Colors.red),
            ),

            GestureDetector(
              onTap: () {
                setState(() {
                  resetPosition(2);
                  createLadder.gameBoardLog();
                  startTimer(2, createLadder.checkNumber(3));
                });
              },
              child: animatedBtn('3', 60, 30, const EdgeInsets.fromLTRB(20, 50, 0, 0), left3, top3, 0, 0, Colors.green),
            ),

            GestureDetector(
              onTap: () {
                setState(() {
                  resetPosition(3);
                  createLadder.gameBoardLog();
                  startTimer(3, createLadder.checkNumber(4));
                });
              },
              child: animatedBtn('4', 60, 30, const EdgeInsets.fromLTRB(20, 50, 0, 0), left4, top4, 0, 0, Colors.brown),
            ),

            GestureDetector(
              onTap: () {
                setState(() {
                  resetPosition(4);
                  createLadder.gameBoardLog();
                  startTimer(4, createLadder.checkNumber(5));
                });
              },
              child: animatedBtn('5', 60, 30, const EdgeInsets.fromLTRB(20, 50, 0, 0), left5, top5, 0, 0, Colors.purpleAccent),
            ),

            Container(width: grayBoxX, height: grayBoxY, color: Colors.grey, margin: const EdgeInsets.fromLTRB(20, 180, 0, 0),)

          ],
        ));
  }

  void gameBoardInfo(var gameBoard) {
    this.gameBoard = gameBoard;
  }

  void startTimer(int index, List<int> result) {
    int count = 0;

    Timer.periodic(const Duration(milliseconds: 400), (timer) {
      setState(() {
        grayBoxX = 0;
        grayBoxY = 0;
        if (result[count] == stateEnum['B']) {
          //아래
          setNumber(index, 'top');
        } else if (result[count] == stateEnum['L']) {
          //왼쪽
          setNumber(index, 'right');
        } else if (result[count] == stateEnum['R']) {
          //오른쪽
          setNumber(index, 'left');
        }
        if (count == result.length - 1) timer.cancel();
        count++;
      });
    });
  }
  void resetPosition(int index){
    if(index == 0) {
      top1 = 35;
      left1 = 0;
    }else if(index == 1) {
      top2 = 35;
      left2 = 100;
    }else if(index == 2) {
      top3 = 35;
      left3 = 200;
    }else if(index == 3) {
      top4 = 35;
      left4 = 300;
    }else if(index == 4) {
      top5 = 35;
      left5 = 400;
    }
  }

  void setNumber(int index, String direction){
    if(index == 0) {
      if(direction == 'top') {
        top1 += 100;
      }else if(direction == 'left') {
        left1 += 100;
      }else if(direction == 'right'){
        left1 -= 100;
      }
    }else if(index == 1) {
      if(direction == 'top') {
        top2 += 100;
      }else if(direction == 'left') {
        left2 += 100;
      }else if(direction == 'right'){
        left2 -= 100;
      }
    }else if(index == 2) {
      if(direction == 'top') {
        top3 += 100;
      }else if(direction == 'left') {
        left3 += 100;
      }else if(direction == 'right'){
        left3 -= 100;
      }
    }else if(index == 3) {
      if(direction == 'top') {
        top4 += 100;
      }else if(direction == 'left') {
        left4 += 100;
      }else if(direction == 'right'){
        left4 -= 100;
      }
    }else if(index == 4) {
      if(direction == 'top') {
        top5+= 100;
      }else if(direction == 'left') {
        left5 += 100;
      }else if(direction == 'right'){
        left5 -= 100;
      }
    }
  }
}

Widget animatedBtn(String text, double width, double height,
    EdgeInsetsGeometry margin, double l, double t, double r, double b, Color color) {
  return Container(
    margin: margin,
    child: AnimatedContainer(
      width: width,
      height: height,
      margin: EdgeInsets.fromLTRB(l, t, r, b),
      duration: const Duration(milliseconds: 100),
      decoration: BoxDecoration(color: color),
      curve: Curves.fastOutSlowIn,
      child: Center(child: Text(text)),
    ),
  );
}