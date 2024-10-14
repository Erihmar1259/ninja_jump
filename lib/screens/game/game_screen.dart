

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ninja_jump/screens/game/back_btn.dart';
import 'package:ninja_jump/screens/home_screen.dart';
import 'package:ninja_jump/utils/dimen_const.dart';
import 'package:ninja_jump/widgets/exit_alert.dart';
import 'package:ninja_jump/widgets/game_over_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/color_const.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_game_button.dart';
import '../../widgets/custom_text.dart';
import 'counter.dart';
import 'game_over_container.dart';
import 'high_score_counter.dart';
import 'ninja.dart';
import 'obstacle.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({ super.key});



  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController worldController;

  int score = 0;
  double runDistance = 0;
  double runVelocity = 30;
  Duration lastUpdateCall = Duration.zero;
  List<Obstacle> obstacleList = [
    Obstacle(positionY: Random().nextDouble(), offsetX: 200)
  ];
  bool showRestart = false;

  final ninja = Ninja();
  final foreverDuration = const Duration(days: 99);

  var box = GetStorage();

  Future<void> _setHighScoreIfNecessary(int value) async {
    if(value > highScore) {
      box.write(Constants.highScoreKey, value);
    }
  }

  int get highScore => box.read(Constants.highScoreKey) ?? 0;

  @override
  void initState() {
     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
     SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    super.initState();
    //duration set to 99days which means basically to state forever
    worldController = AnimationController(
      vsync: this,
      duration: const Duration(days: 99),
    );
    worldController
      ..addListener(_update)
      ..forward();
  }
@override
  void dispose() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown,DeviceOrientation.portraitUp,]);
    super.dispose();
  }
  void _die() {
    setState(() {
      showRestart = true;
      worldController.stop();
    });
  }

  void _update() {
    final worldControllerElapsed = worldController.lastElapsedDuration ?? Duration.zero;

    ninja.update(lastUpdateCall, worldControllerElapsed);

    final elapsedSeconds = (worldControllerElapsed - lastUpdateCall).inMilliseconds / 1000; //TODO: check why using inSeconds is not working here

    runDistance += runVelocity * elapsedSeconds;

    final screenSize = MediaQuery.of(context).size;
    final ninjaRect = ninja.getRect(screenSize, runDistance);

    var shouldAdd = false;
    final toRemove = <Obstacle>[];

    for (final obstacle in obstacleList) {
      final obstacleRect = obstacle.getRect(screenSize, runDistance);

      if (ninjaRect.overlaps(obstacleRect)) {
        _die();
      }

      final leftThreshold = Random().nextInt(50);
      final rightThreshold = Random().nextInt(100) + 50;

      if (obstacleRect.right > leftThreshold && obstacleRect.right < rightThreshold) {
        shouldAdd = true;
      }

      if (obstacleRect.right < 0) {
        score += 1;
        _setHighScoreIfNecessary(score);
        toRemove.add(obstacle);
      }
    }

    //max 5 items
    if (obstacleList.length < Constants.maxObstaclesAtOnce && shouldAdd) {
      setState(() {
        obstacleList.add(
          Obstacle(
            positionY: Random().nextDouble(),
            offsetX: runDistance + Random().nextInt(150) + 50,
          ),
        );
      });
    }

    setState(() {
      obstacleList.removeWhere(toRemove.contains);
    });

    lastUpdateCall = worldControllerElapsed;
    if (elapsedSeconds != 0 && elapsedSeconds % 10 == 0) {
      runVelocity += 30;
    }
  }

  void _restart() {
    showRestart = false;
    score = 0;
    ninja.restart();
    obstacleList
      ..clear()
      ..add(Obstacle(positionY: Random().nextDouble(), offsetX: 200));
    worldController
      ..reset()
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final children = <Widget>[
      Container(
        color: Colors.blueAccent,
      ),
      Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/graphics/Mountains-Transparent.webp"),
            fit: BoxFit.cover,
          ),
        ),
      )
    ];

    for (final gameObject in [...obstacleList, ninja]) {
      children.add(
        AnimatedBuilder(
          animation: worldController,
          builder: (context, _) {
            final rect = gameObject.getRect(screenSize, runDistance);
            return Positioned(
              left: rect.left,
              top: rect.top,
              width: rect.width,
              height: rect.height,
              child: gameObject.render(),
            );
          },
        ),
      );
    }

    children
    ..add(BackButtonWidget())
      ..add(Counter(score: score))
      ..add(
        HighScoreCounter(highScore: highScore),
      );

    if (showRestart) {
      children.add(
        // GameOverContainer(
        //   onRestartTap: _restart,
        // ),
          AlertDialog(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(
                color: Colors.white,
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "game_over".tr,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            content: Container(
              margin: EdgeInsets.only(
                top: 15,
              ),
              height: 140.h,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: 'your_score'.tr,
                        color: whiteColor,
                      ),
                      kSizedBoxW10,
                      CustomText(
                        text: score.toString(),
                        color: Colors.yellow,
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomGameButton(
                          text: 'home'.tr,
                          width: 100.w,
                          textColor: whiteColor,
                          onTap: () {
                            Get.offAll(HomeScreen());
                          },
                        ),
                        CustomGameButton(
                          text: 'try_again'.tr,
                          width: 100.w,
                          textColor: whiteColor,
                          onTap: () {
                            _restart();
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
      );
    }

    return Scaffold(

      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: ninja.jump,
        child: Stack(
          alignment: Alignment.center,
          children: children,
        ),
      ),
    );
  }
}
