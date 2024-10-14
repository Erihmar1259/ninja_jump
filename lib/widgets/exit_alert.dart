import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../utils/color_const.dart';
import 'custom_game_button.dart';
import 'custom_text.dart';

class ExitAlert extends StatelessWidget {
  ExitAlert();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
            "exit".tr,
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
            CustomText(
              text: 'are_u_sure'.tr,
              color: whiteColor,
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomGameButton(
                    text: 'cancel'.tr,
                    width: 100.w,
                    textColor: whiteColor,
                    onTap: () {
                      Get.back();
                    },
                  ),
                  CustomGameButton(
                    text: 'exit'.tr,
                    width: 100.w,
                    textColor: whiteColor,
                    onTap: () {
                      exit(0);
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
