import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({ super.key});



  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Positioned(
      left: 0.w,
      top: screenSize.height * Constants.boundArea,
      width: 30.w,
      height: 30.h,
      child: InkWell(
        onTap: (){Get.back();},
        child: Image.asset('assets/images/back_btn.webp',width: 30.w,height: 30.h,),
      )
    );
  }
}
