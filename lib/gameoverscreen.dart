// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Gameoverscreen extends StatelessWidget {
  final bool isGameOver;
  final function;
  const Gameoverscreen({required this.isGameOver, this.function, super.key});

  // game font
  static var gameFont = GoogleFonts.pressStart2p(
    textStyle: TextStyle(
      color: Colors.deepPurple[600],
      letterSpacing: 0,
      fontSize: 28,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return isGameOver
        ? Stack(
          children: [
            Container(
              alignment: Alignment(0, -0.3),
              child: Text(
                "G A M E O V E R",
                style: TextStyle(color: Colors.deepPurple[600], fontSize: 64),
                //style: gameFont
              ),
            ),
            Container(
              alignment: Alignment(0, 0.3),
              child: GestureDetector(
                onTap: function,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    color: Colors.deepPurple,
                    child: Text(
                      "PLAY AGAIN",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
        : Container();
  }
}
