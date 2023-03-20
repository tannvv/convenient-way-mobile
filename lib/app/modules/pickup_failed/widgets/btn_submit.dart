import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/button_styles.dart';
import 'package:tien_duong/app/modules/pickup_failed/controllers/pickup_failed_controller.dart';

class BtnSubmitPickupFailed extends GetWidget<PickupFailedController> {
  const BtnSubmitPickupFailed({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.w, vertical: 12.h),
                  backgroundColor: AppColors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                onPressed: () {
                  controller.onPickupFailed();
                },
                child: const Text('Gửi thông tin'))
          ],
        )
      ],
    );
  }
}
