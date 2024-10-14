import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ninja_jump/screens/game/game_screen.dart';
import 'package:ninja_jump/screens/settings/setting_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utils/enum.dart';
import '../../utils/global.dart';
import '../../utils/local_storage.dart';
import '../../widgets/custom_text.dart';
import '../utils/color_const.dart';
import '../utils/dimen_const.dart';
import '../widgets/custom_game_button.dart';
import '../widgets/exit_alert.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isAccepted = false;
  bool isChecked = false;
  String first = '';

  @override
  void initState() {
    super.initState();

    first = LocalStorage.instance.read(StorageKey.first.name) ?? '';
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        if (first == '') {
          if (context.mounted) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (ctx) => Builder(builder: (context) {
                return StatefulBuilder(
                  builder: (context, StateSetter setState) {
                    return AlertDialog(
                      surfaceTintColor: whiteColor,
                      backgroundColor: whiteColor,
                      content: SizedBox(
                        height: 1.sh * 0.80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SingleChildScrollView(
                              child: SizedBox(
                                  height: 1.sh * 0.65,
                                  width: double.infinity,
                                  child: WebViewWidget(
                                      controller: WebViewController()
                                        ..loadHtmlString(
                                            Global.language == Language.zh.name
                                                ? Global.policyZh
                                                : Global.language ==
                                                Language.vi.name
                                                ? Global.policyVi:
                                            Global.language ==
                                                Language.ko.name
                                                ? Global.policyKo
                                                : Global.language ==
                                                Language.hi.name
                                                ? Global.policyHi
                                                : Global.policyEn))),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                  activeColor: secondaryColor,
                                  side: BorderSide(
                                    width: 1.5,
                                    color: isChecked
                                        ? secondaryColor
                                        : Colors.black,
                                  ),
                                  value: isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked = value!;
                                      if (isChecked) {
                                        isAccepted = true;
                                      } else {
                                        isAccepted = false;
                                      }
                                    });
                                  },
                                ),
                                CustomText(
                                  text: 'agree'.tr,
                                  color: secondaryColor,
                                  fontSize: 12,
                                ),
                              ],
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateColor.resolveWith((states) =>
                                  isAccepted
                                      ? secondaryColor
                                      : greyColor)),
                              // ignore: sort_child_properties_last
                              child: CustomText(
                                text: "accept".tr,
                                color: whiteColor,
                                fontSize: 12,
                              ),
                              onPressed: isAccepted
                                  ? () async {
                                LocalStorage.instance.write(
                                    StorageKey.first.name, 'notfirst');
                                Navigator.pop(context);
                              }
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            );
          }
        }
      } catch (e) {
        // print("Error fetching SharedPreferences: $e");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
   var box=GetStorage();
   var scoreRecord = box.read('record')??0;
   return Scaffold(
      body:  Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                opacity: 0.8,
                image: AssetImage('assets/images/bg.webp'),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     CustomText(text: 'your_best_score'.tr,color: whiteColor,fontWeight: FontWeight.bold,fontSize: 16.sp,),
            //     kSizedBoxW10,
            //     CustomText(text: scoreRecord.toString(),color: red,fontWeight: FontWeight.bold,fontSize: 20.sp,),
            //   ],
            // ),
            kSizedBoxH20,
            CustomGameButton(
              onTap: (){
                Get.to(()=> GameScreen());
              },
              text: 'start'.tr,
              width: 200.w,
            ),
            kSizedBoxH20,
            CustomGameButton(
              onTap: (){
                Get.to(()=>const SettingScreen());
              },
              text: 'settings'.tr,
              width: 200.w,
            ),
            kSizedBoxH20,
            CustomGameButton(
              onTap: (){

                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return ExitAlert(

                    );
                  },
                );
              },
              text: 'exit'.tr,
              width: 200.w,
            )
          ],
        ),
      ),
    );
  }
}
