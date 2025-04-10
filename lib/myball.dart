// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class Myball extends StatelessWidget {
  final ballx;
  final bally;
  final bool isGameOver;
  final bool hasGameStarted;
  const Myball({
    this.ballx,
    this.bally,
    required this.isGameOver,
    required this.hasGameStarted,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return hasGameStarted
        ? Container(
          alignment: Alignment(ballx, bally),
          child: Container(
            height: 15,
            width: 15,
            decoration: BoxDecoration(
              color: isGameOver ? Colors.deepPurple[300] : Colors.deepPurple,
              shape: BoxShape.circle,
            ),
          ),
        )
        : Container(
          alignment: Alignment(ballx, bally),
          child: AvatarGlow(
            child: Material(
              elevation: 8.0,
              shape: CircleBorder(),
              child: CircleAvatar(
                backgroundColor: Colors.deepPurple[100],
                radius: 7.0,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepPurple,
                  ),
                  width: 15,
                  height: 15,
                ),
              ),
            ),
          ),
        );
  }
}
