import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final splashController  = Get.put(SplashController());
    return Scaffold(

      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.webp',),
            opacity: 0.7,
            fit: BoxFit.cover,

          ),
        ),
        child: const Center(
          child:FlutterLogo(),
        ),
      ),
    );
  }
}
