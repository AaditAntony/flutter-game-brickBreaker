// ignore_for_file: camel_case_types, constant_identifier_names

import 'dart:async';

import 'package:brick_breaker/brick.dart';
import 'package:brick_breaker/cover_screen.dart';
import 'package:brick_breaker/gameoverscreen.dart';
import 'package:brick_breaker/myball.dart';
import 'package:brick_breaker/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

enum direction { UP, DOWN, LEFT, RIGHT }

class _HomepageState extends State<Homepage> {
  late FocusNode _focusNode;
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    // Request focus as soon as the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  // ball variable
  double ballX = 0;
  double ballY = 0;
  double ballXincrement = 0.02;
  double ballYincrement = 0.01;
  var ballYDirection = direction.DOWN;
  var ballXDirection = direction.LEFT;

  //player variables
  double playerX = -0.2;
  double playerWidth = 0.4;

  //brick variable
  static double firstBrickX = -1 + wallGap;
  static double firstBrickY = -0.9;
  static double brickWidth = 0.4; //out of 2
  static double brickHeight = 0.05; // out of 2
  static double brickGap = 0.01;
  static int numberOfBricksInRow = 4;
  static double wallGap =
      0.5 *
      (2 -
          numberOfBricksInRow * brickWidth -
          (numberOfBricksInRow - 1) * brickGap);

  List myBricks = [
    // [x,y broken = true/false]
    [firstBrickX + 0 * (brickWidth + brickGap), firstBrickY, false],
    [firstBrickX + 1 * (brickWidth + brickGap), firstBrickY, false],
    [firstBrickX + 2 * (brickWidth + brickGap), firstBrickY, false],
  ];
  // game settings
  bool hasGameStarted = false;
  bool isGameOver = false;
  //start game
  void startgame() {
    hasGameStarted = true;
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      //update direction
      updateDirection();
      // move ball
      moveBall();
      //check if the player is dead
      if (isPlayerDead()) {
        timer.cancel();
        isGameOver = true;
      }
      //check for the broken bricks
      checkForBrokenBricks();
    });
  }

  void checkForBrokenBricks() {
    //check for when ball hits the bottom of the list
    for (int i = 0; i < myBricks.length; i++) {
      if (ballX >= myBricks[i][0] &&
          ballX <= myBricks[i][0] + brickWidth &&
          ballY <= myBricks[i][1] + brickHeight &&
          myBricks[i][2] == false) {
        setState(() {
          myBricks[i][2] = true;
          // since brick is broken , update the direction of the ball based on which side of the brick it is hit
          // to do this, calculate the distance of the ball form each 4 sides.
          // the smallest distance is the side the ball has it

          double leftSideDist = (myBricks[i][0] - ballX).abs();
          double rightSideDist = (myBricks[i][0] + brickWidth - ballX).abs();
          double topSideDist = (myBricks[i][1] - ballY).abs();
          double bottomSideDist = (myBricks[i][1] + brickHeight - ballY).abs();

          String min = findMin(
            leftSideDist,
            rightSideDist,
            topSideDist,
            bottomSideDist,
          );
          switch (min) {
            case 'left':
              ballXDirection = direction.LEFT;
              break;
            case 'right':
              ballXDirection = direction.RIGHT;
              break;
            case 'up':
              ballYDirection = direction.UP;
              break;
            case 'down':
              ballYDirection = direction.DOWN;
              break;
          }
        });
      }
    }
  }

  // returns the smallest side
  String findMin(double a, double b, double c, double d) {
    List<double> myList = [a, b, c, d];
    double currentMin = a;
    for (int i = 0; i < myList.length; i++) {
      if (myList[i] < currentMin) {
        currentMin = myList[i];
      }
    }
    if (currentMin - a.abs() < 0.01) {
      return 'left';
    } else if (currentMin - b.abs() < 0.01) {
      return 'right';
    } else if (currentMin - c.abs() < 0.01) {
      return 'top';
    } else if (currentMin - d.abs() < 0.01) {
      return 'bottom';
    }
    return '';
  }

  // is player dead
  bool isPlayerDead() {
    // player dies if the ball reaches bottom of screen
    if (ballY >= 1) {
      return true;
    }
    return false;
  }

  // move ball
  void moveBall() {
    setState(() {
      // move horizontally
      if (ballXDirection == direction.LEFT) {
        ballX -= ballXincrement;
      } else if (ballXDirection == direction.RIGHT) {
        ballX += ballXincrement;
      }
      // move vertically
      if (ballYDirection == direction.DOWN) {
        ballY += ballYincrement;
      } else if (ballYDirection == direction.UP) {
        ballY -= ballYincrement;
      }
    });
  }

  void updateDirection() {
    // ball goes up when it hits player
    if (ballY >= 0.9 && ballX >= playerX && ballX <= playerX + playerWidth) {
      ballYDirection = direction.UP;
    }
    // ball goes down when it hits the top of the screen
    else if (ballY <= -1) {
      ballYDirection = direction.DOWN;
    }
    // ball goes down when it hits right wall
    if (ballX >= 1) {
      ballXDirection = direction.LEFT;
    } else if (ballX <= -1) {
      ballXDirection = direction.RIGHT;
    }
  }

  // move left

  void moveLeft() {
    setState(() {
      if (!(playerX - 0.2 < -1)) {
        playerX -= 0.2;
      }
    });
  }
  // move right

  void moveRight() {
    setState(() {
      if (!(playerX + playerWidth >= 1)) {
        playerX += 0.2;
      }
    });
  }

  // reset game back to initial value when user hit play again
  void resetGame() {
    setState(() {
      playerX = -0.2;
      ballX = 0;
      ballY = 0;
      isGameOver = false;
      hasGameStarted = false;
      myBricks = [
        // [x,y broken = true/false]
        [firstBrickX + 0 * (brickWidth + brickGap), firstBrickY, false],
        [firstBrickX + 1 * (brickWidth + brickGap), firstBrickY, false],
        [firstBrickX + 2 * (brickWidth + brickGap), firstBrickY, false],
      ];
    });
  }

  bool isMovingLeft = false;
  bool isMovingRight = false;

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: (event) {
        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
            moveLeft();
          } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
            moveRight();
          }
        }
      },
      child: GestureDetector(
        onTap: () {
          _focusNode.requestFocus(); // Make sure to regain focus on tap
          startgame();
        },
        child: Scaffold(
          backgroundColor: Colors.deepPurple[100],
          body: Center(
            child: Stack(
              children: [
                // tap to play
                Coverscreen(
                  hasGameStarted: hasGameStarted,
                  isGameOver: isGameOver,
                ),
                // game over screen
                Gameoverscreen(isGameOver: isGameOver, function: resetGame),
                // ball
                Myball(
                  ballx: ballX,
                  bally: ballY,
                  hasGameStarted: hasGameStarted,
                  isGameOver: isGameOver,
                ),
                //player
                MyPlayer(playerX: playerX, playerWidth: playerWidth),
                //bricks
                MyBrick(
                  brickX: myBricks[0][0],
                  brickY: myBricks[0][1],
                  brickWidth: brickWidth,
                  brickHeight: brickHeight,
                  brickBroken: myBricks[0][2],
                ),
                MyBrick(
                  brickX: myBricks[1][0],
                  brickY: myBricks[1][1],
                  brickWidth: brickWidth,
                  brickHeight: brickHeight,
                  brickBroken: myBricks[1][2],
                ),
                MyBrick(
                  brickX: myBricks[2][0],
                  brickY: myBricks[2][1],
                  brickWidth: brickWidth,
                  brickHeight: brickHeight,
                  brickBroken: myBricks[2][2],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
