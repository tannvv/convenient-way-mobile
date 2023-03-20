import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/core/widgets/button_color.dart';
import 'package:tien_duong/app/modules/pickup_failed/controllers/pickup_failed_controller.dart';

import 'images_view.dart';

class ImageSelectPickupFailed extends GetWidget<PickupFailedController> {
  const ImageSelectPickupFailed({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(32.h),
        Text(
          'Vui lòng chụp ảnh để chứng minh?',
          style: subtitle1.copyWith(
              fontWeight: FontWeight.bold, color: Colors.grey[500]),
        ),
        Gap(16.h),
        const ImagesViewPickupFailed(),
        Gap(16.h),
      ],
    );
  }
}
