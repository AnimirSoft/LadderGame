import 'dart:developer';
import 'dart:math' as dartmath;
import 'package:flutter/material.dart';
import 'package:ladder_game/ladder_interface.dart';

class CreateLadder extends CustomPainter{
  BuildContext context;
  late var gameBoard;
  int verticalLines = 5; // 세로 col
  int horizontalLines = 5; // 가로 row

  int lineCount = 5; // 가로 라인 (랜덤 배치)
  int lineOffset = 100; // 라인 간격 Offset

  LadderInterface _ladderInterface;

  CreateLadder(this.context, this._ladderInterface);

  @override
  void paint(Canvas canvas, Size size) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;


    Paint paint = Paint()
      ..color = Colors.deepPurpleAccent
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0;

    Paint paint2 = Paint()
      ..color = Colors.deepOrange
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0;



    // 게임 보드 세팅
    gameBoard = List.generate(horizontalLines, (index) => List.generate(verticalLines, (index) => 0), growable: false);
    //gameBoardLog(gameBoard);


    // 가로 라인 랜덤 세팅
    int lineCountCheck = 0;


    for(int index1 = 1; index1 < horizontalLines-1; index1++){
      var randomCount = dartmath.Random().nextInt(horizontalLines * verticalLines);
      //log('$randomCount');

      for(int index2 = 0; index2 < verticalLines-1; index2++){

        if(gameBoard[index1][index2] == 0){
          var index2Tmp = index2;
          if(index2Tmp != 0){
            index2Tmp -= 1;
          }

          var index1Tmp = index1;
          if(index1Tmp != 0){
            index1Tmp -= 1;
          }

          if(gameBoard[index1][index2Tmp] == 0 || gameBoard[index1][index2Tmp] == 2 && gameBoard[index1Tmp][index2] == 2){
            if(gameBoard[index1Tmp][index2] != 1){

              gameBoard[index1][index2] = 1;
              gameBoard[index1][index2+1] = 2;
              lineCountCheck++;

            }
          }

          if(lineCountCheck == lineCount){
            break;
          }

        }
      }
    }
    //gameBoardLog(gameBoard);


    // 라인 그리기
    for(int index1 = 0; index1 < horizontalLines; index1++){
      for(int index2 = 0; index2 < verticalLines; index2++){

        if(gameBoard[index1][index2] != 1) {
          // 아래로 라인 그리기
          int rightOffset = index2 * lineOffset - 50;
          int bottomOffset = index1 * lineOffset;
          //log("rightOffset : $rightOffset | bottomOffset : $bottomOffset");

          canvas.drawLine(Offset(rightOffset.toDouble() + lineOffset, lineOffset.toDouble() + bottomOffset), Offset(rightOffset.toDouble() + lineOffset, lineOffset.toDouble() + lineOffset + bottomOffset), paint);
        }else if(gameBoard[index1][index2] == 1) {
          // 아래 오른쪽 그리기

          int rightOffset = index2 * lineOffset - 50;
          int bottomOffset = index1 * lineOffset;

          canvas.drawLine(Offset(rightOffset.toDouble() + lineOffset, lineOffset.toDouble() + bottomOffset), Offset(rightOffset.toDouble() + lineOffset + lineOffset, lineOffset.toDouble() + bottomOffset), paint);
          canvas.drawLine(Offset(rightOffset.toDouble() + lineOffset, lineOffset.toDouble() + bottomOffset), Offset(rightOffset.toDouble() + lineOffset, lineOffset.toDouble() + lineOffset + bottomOffset), paint);
        }
      }
    }

    _ladderInterface.gameBoardInfo(gameBoard);
  }


  List<int> checkNumber(int number){

    int index1 = number-1;
    Map<String, int> stateEnum = {
      'IDLE' : 0,
      'L' : 1,
      'T' : 2,
      'R' : 3,
      'B' : 4,
    };

    List<int> checkList = [];

    int state = 0;

    for (int index2 = 0; index2 < verticalLines; index2++) {

      int value = gameBoard[index2][index1];

        if(value == 0){
          state = stateEnum['B']!;
          checkList.add(state);
          log('아래 : $value');
        }else if(value== 1){
          if(state == stateEnum['B']) {
            // 위에서 내려온 경우 1을 만났을때
            state = stateEnum['R']!;
            checkList.add(state);
            log('오른쪽 : $value');
            index1 += 1;
            index2 -= 1;
          }else if(state == stateEnum['L']) {
            // 오른쪽에서 왼쪽으로 이동해서 1을 만났을때
            state = stateEnum['B']!;
            checkList.add(state);
            log('아래 : $value');
          }else if(state == stateEnum['R']) {
            // 왼쪽으로 오른쪽으로 이동해서 1을 만났을때
            state = stateEnum['B']!;
            checkList.add(state);
            log('아래 : $value');
          }
        }else if(value == 2) {
          if(state == stateEnum['B']) {
            // 위에서 내려온 경우 2을 만났을때
            state = stateEnum['L']!;
            checkList.add(state);
            log('왼쪽 : $value');
            index1 -= 1;
            index2 -= 1;
          }else if(state == stateEnum['L']) {
            // 오른쪽에서 왼쪽으로 이동해서 2을 만났을때
            state = stateEnum['B']!;
            checkList.add(state);
            log('아래 : $value');
          }else if(state == stateEnum['R']) {
            // 왼쪽으로 오른쪽으로 이동해서 2을 만났을때
            state = stateEnum['B']!;
            checkList.add(state);
            log('아래 : $value');
          }
        }
    }

    return checkList;
  }


  void gameBoardLog(){
    for(int index1 = 0; index1 < horizontalLines; index1++){
      String tmp = "";
      for(int index2 = 0; index2 < verticalLines; index2++){
        tmp += "${gameBoard[index1][index2]} ";
        if(index2 == verticalLines-1) {
          log(tmp);
        }
      }
    }
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}