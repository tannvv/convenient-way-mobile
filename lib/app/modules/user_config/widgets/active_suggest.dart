import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/modules/user_config/controllers/user_config_controller.dart';

class ActiveSuggest extends GetWidget<UserConfigController> {
  const ActiveSuggest({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text('Trạng thái hoạt động'),
        Gap(12.w),
        Obx(
          () => FlutterSwitch(
            value: controller.isActive.value,
            borderRadius: 30.0,
            padding: 8.0,
            onToggle: (val) {
              controller.isActive.value = val;
              controller.changeStatus();
            },
          ),
        )
      ],
    );
  }
}
