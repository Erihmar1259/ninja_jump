import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controller/language_controller.dart';
import '../../../utils/color_const.dart';
import '../../../utils/enum.dart';
import '../../utils/dimen_const.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/setting_card.dart';

class ChangeLanguageScreen extends StatelessWidget {
  const ChangeLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languageController = Get.put(LanguageController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: CustomText(
          text: "change_language".tr,
          color: whiteColor,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
        leading: IconButton(
          iconSize: 30,
          icon: Image.asset('assets/images/back_btn.webp',width: 30.w,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        padding: EdgeInsets.all(10.w),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.webp',),
            opacity: 0.5,
            fit: BoxFit.cover,

          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => GestureDetector(
                onTap: () {
                  languageController.changeLanguage("en", "US");
                },
                child: SettingsCardWidget(
                  childWidget: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/usa.webp",
                            width: 20.w,
                            height: 20.h,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          const CustomText(
                            text: "English",
                          )
                        ],
                      ),
                      Icon(
                        languageController.language.value ==
                                Language.en.name
                            ? Icons.check_circle
                            : Icons.check_circle_outline,
                        color: languageController.language.value ==
                                Language.en.name
                            ? secondaryColor
                            : grey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            kSizedBoxH10,
            Obx(
                  () => GestureDetector(
                onTap: () {
                  languageController.changeLanguage("ko", "KR");
                },
                child: SettingsCardWidget(
                  childWidget: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/korea.webp",
                            width: 20.w,
                            height: 20.h,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          const CustomText(
                            text: "한국인",
                          )
                        ],
                      ),
                      Icon(
                        languageController.language.value ==
                            Language.ko.name
                            ? Icons.check_circle
                            : Icons.check_circle_outline,
                        color: languageController.language.value ==
                            Language.ko.name
                            ? secondaryColor
                            : grey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            kSizedBoxH10,
            Obx(
              () => GestureDetector(
                onTap: () {
                  languageController.changeLanguage("zh", "CN");
                },
                child: SettingsCardWidget(
                  childWidget: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/china.webp",
                            width: 20.w,
                            height: 20.h,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          const CustomText(
                            text: "中文",
                          )
                        ],
                      ),
                      Icon(
                        languageController.language.value ==
                                Language.zh.name
                            ? Icons.check_circle
                            : Icons.check_circle_outline,
                        color: languageController.language.value ==
                                Language.zh.name
                            ? secondaryColor
                            : grey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            kSizedBoxH10,
            Obx(
              () => GestureDetector(
                onTap: () {
                  languageController.changeLanguage("vi", "VN");
                },
                child: SettingsCardWidget(
                  childWidget: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/vietnam.webp",
                            width: 20.w,
                            height: 20.h,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          const CustomText(
                            text: "Tiếng Việt",
                          )
                        ],
                      ),
                      Icon(
                        languageController.language.value ==
                                Language.vi.name
                            ? Icons.check_circle
                            : Icons.check_circle_outline,
                        color: languageController.language.value ==
                                Language.vi.name
                            ? secondaryColor
                            : grey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            kSizedBoxH10,
            Obx(
              () => GestureDetector(
                onTap: () {
                  languageController.changeLanguage("hi", "IN");
                },
                child: SettingsCardWidget(
                  childWidget: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/india.webp",
                            width: 20.w,
                            height: 20.h,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          const CustomText(
                            text: "हिन्दी",
                          )
                        ],
                      ),
                      Icon(
                        languageController.language.value ==
                                Language.hi.name
                            ? Icons.check_circle
                            : Icons.check_circle_outline,
                        color: languageController.language.value ==
                                Language.hi.name
                            ? secondaryColor
                            : grey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
