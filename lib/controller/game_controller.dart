// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class GameController extends GetxController with GetSingleTickerProviderStateMixin {
//   var brickYaxis = 1.0.obs;
//   var brickXaxis = -0.9.obs;
//   var time = 0.0;
//   var height = 0.0;
//   var initialHeight = 1.0.obs;
//   var jumpStarted = false.obs;
//   var gameStarted = false.obs;
//   var firstRotate = true.obs;
//   var endGame = false.obs;
//   var startRotatePos = 0.0.obs;
//   var endRotatePos = 0.5.obs;
//   var score = 0.obs;
//   var record = 0.obs;
//   var barrierXone = 1.0.obs;
//   var barrierXtwo = 2.5.obs;
//   var mainThemeSongStarted = false.obs;
//
//   late AnimationController rotationController;
//
//   TextEditingController wordController = TextEditingController();
//
//   @override
//   void onInit() {
//     rotationController = AnimationController(
//       duration: const Duration(milliseconds: 600),
//       vsync: this,
//     );
//     super.onInit();
//   }
//
//   @override
//   void onClose() {
//     wordController.dispose();
//     rotationController.dispose();
//     super.onClose();
//   }
//
//   void startGame() {
//     if (!mainThemeSongStarted.value) {
//       // mainThemeSoundPlayer.play();
//       mainThemeSongStarted.value = true;
//     }
//     if (!gameStarted.value) {
//       Timer.periodic(Duration(milliseconds: 40), (timer) {
//         loopBarriers();
//         if (endGame.value) {
//           timer.cancel();
//         }
//       });
//       gameStarted.value = true;
//     }
//   }
//
//   void handleTap() {
//     startGame();
//     if (jumpStarted.value) {
//       jump();
//     } else {
//       startJumping();
//     }
//   }
//
//   void jump() {
//     rotate();
//     time = 0;
//     initialHeight.value = brickYaxis.value;
//   }
//
//   void rotate() {
//     if (firstRotate.value) {
//       startRotatePos.value = 0;
//       endRotatePos.value = 0.5;
//       firstRotate.value = false;
//     } else {
//       startRotatePos.value = 0.5;
//       endRotatePos.value = 1;
//       firstRotate.value = true;
//     }
//     rotationController.reset();
//     rotationController.forward();
//   }
//
//   void startJumping() {
//     jumpStarted.value = true;
//     rotate();
//     Timer.periodic(Duration(milliseconds: 50), (timer) {
//       time += 0.05;
//       height = -2.9 * time * time + 2.6 * time;
//       brickYaxis.value = initialHeight.value - height;
//       if (brickYaxis.value > 1) {
//         timer.cancel();
//         jumpStarted.value = false;
//         time = 0;
//         initialHeight.value = 1;
//         brickYaxis.value = 1;
//       }
//     });
//   }
//
//   void loopBarriers() {
//     checkCollision();
//     barrierXone.value -= 0.05;
//     barrierXtwo.value -= 0.05;
//     if (barrierXone.value < -2) {
//       barrierXone.value += 3.5;
//       score.value += 1;
//     }
//     if (barrierXtwo.value < -2) {
//       barrierXtwo.value += 3.5;
//       score.value += 1;
//     }
//   }
//
//   void checkCollision() {
//     // Add your collision detection logic here
//     if (endGame.value) return;
//     // if collision detected, call handleGameEnd()
//   }
//
//   void handleGameEnd() {
//     endGame.value = true;
//     // Show dialog, stop sounds, etc.
//   }
//
//   void restart() {
//     brickYaxis.value = 1;
//     brickXaxis = -0.9;
//     time = 0;
//     height = 0;
//     initialHeight.value = 1;
//     jumpStarted.value = false;
//     gameStarted.value = false;
//     firstRotate.value = true;
//     endGame.value = false;
//     startRotatePos.value = 0;
//     endRotatePos.value = 0.5;
//     score.value = 0;
//     barrierXone.value = 1;
//     barrierXtwo.value = 2.5;
//   }
// }
