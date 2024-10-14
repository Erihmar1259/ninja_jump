import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ninja_jump/utils/color_const.dart';
import 'package:ninja_jump/utils/dimen_const.dart';
import 'package:get_storage/get_storage.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/setting_card.dart';
import 'change_language.dart';
import 'privacy_policy_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  var box=GetStorage();
  var scoreRecord ;
  @override
  void initState() {
    scoreRecord= box.read('record')??0;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: CustomText(
            text: "settings".tr,
            color: whiteColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
          leading: IconButton(
            iconSize: 40,
            icon: Image.asset('assets/images/back_btn.webp',width: 30.w),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.webp',),
              opacity: 0.7,
              fit: BoxFit.cover,

            ),
          ),
          padding: EdgeInsets.all(10.w),
          child: ListView(
            children: [
              kSizedBoxH20,
              CustomText(text: 'your_best_score'.tr,fontWeight: FontWeight.bold,fontSize: 14.sp,color: whiteColor,),
              SizedBox(height: 5.h),
              SettingsCardWidget(
                childWidget: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/images/info.webp",width: 20.w,height: 20.h,color: secondaryColor,),
                        SizedBox(
                          width: 10.w,
                        ),
                        CustomText(text: 'your_score'.tr,fontWeight: FontWeight.bold,),
                      ],
                    ),
                     CustomText(text: scoreRecord.toString(),color: Colors.yellow,fontSize: 20.sp,),
                  ],
                ),
              ),
              CustomText(text: 'general'.tr,fontWeight: FontWeight.bold,fontSize: 14.sp,color: whiteColor,),
              SizedBox(height: 5.h),
              GestureDetector(
                onTap: () {
                  Get.to(() => const ChangeLanguageScreen());
                },
                child: SettingsCardWidget(
                  childWidget: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/images/language.webp",width: 20.w,height: 20.h,color: secondaryColor,),
                          SizedBox(
                            width: 10.w,
                          ),
                          CustomText(text: 'language'.tr,fontWeight: FontWeight.bold)
                        ],
                      ),
                      Row(
                        children: [
                          CustomText(
                            text: 'lang'.tr,
                             color: greyColor.withOpacity(0.6),
                          ),
                          Image.asset("assets/images/forward.webp",width: 15.w,height: 15.h,color: secondaryColor,),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              kSizedBoxH20,
              CustomText(text: 'other'.tr,fontWeight: FontWeight.bold,fontSize: 14.sp,color: whiteColor),
              SizedBox(height: 5.h),
              GestureDetector(
                onTap: () {
                  Get.to(() => const PrivacyPolicyScreen());
                },
                child: SettingsCardWidget(
                  childWidget: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/images/policy.webp",width: 20.w,height: 20.h,color: secondaryColor,),
                          SizedBox(
                            width: 10.w,
                          ),
                          CustomText(text: 'policy'.tr,fontWeight: FontWeight.bold,)
                        ],
                      ),
                      Image.asset("assets/images/forward.webp",width: 15.w,height: 15.h,color: secondaryColor,),
                    ],
                  ),
                ),
              ),
              kSizedBoxH20,
              SettingsCardWidget(
                childWidget: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/images/info.webp",width: 20.w,height: 20.h,color: secondaryColor,),
                        SizedBox(
                          width: 10.w,
                        ),
                        CustomText(text: 'version'.tr,fontWeight: FontWeight.bold,),
                      ],
                    ),
                    const CustomText(text: '1.0.0'),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
