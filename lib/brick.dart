// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class MyBrick extends StatelessWidget {
  final brickX;
  final brickY;
  final brickHeight;
  final brickWidth;
  final bool brickBroken;
  const MyBrick({
    this.brickHeight,
    this.brickWidth,
    this.brickX,
    this.brickY,
    super.key,
    required this.brickBroken,
  });

  @override
  Widget build(BuildContext context) {
    return brickBroken
        ? Container()
        : Container(
          alignment: Alignment(
            (2 * brickX + brickWidth) / (2 - brickWidth),
            brickY,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              height: MediaQuery.of(context).size.height * brickHeight / 2,
              width: MediaQuery.of(context).size.width * brickWidth / 2,
              color: Colors.deepPurple,
            ),
          ),
        );
  }
}
