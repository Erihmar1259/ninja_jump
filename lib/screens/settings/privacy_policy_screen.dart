import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../utils/color_const.dart';
import '../../utils/enum.dart';
import '../../utils/global.dart';
import '../../widgets/custom_text.dart';
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: CustomText(
          text: "policy".tr,
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
            opacity: 0.5,
            fit: BoxFit.cover,

          ),
        ),
        child: ListView(
          children: [
            Padding(
              padding:  EdgeInsets.only(top: 20.h,left: 10.w,right: 10.w),
              child: Text(
                Global.language==Language.ko.name? Global.policyKoOrg:Global.language==Language.zh.name? Global.policyZhOrg: Global.language==Language.hi.name? Global.policyHiOrg: Global.language==Language.vi.name?Global.policyViOrg:Global.policyEnOrg ,
                style:  TextStyle(
                    color: blackTextColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Audiowide"
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
