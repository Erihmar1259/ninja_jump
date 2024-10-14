

import 'package:get/get.dart';

import '../screens/home_screen.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAll(() =>const HomeScreen());
    });
    super.onInit();
  }
}
