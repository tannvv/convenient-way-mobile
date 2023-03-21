import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart%20%20';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/modules/complete_package_detail/controllers/complete_package_detail_controller.dart';

class RatingPackage extends GetWidget<CompletePackageDetailController> {
  const RatingPackage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: controller.horizontalPadding, vertical: 8.h),
      child: Column(
        children: [
          Text(
            'Trải nghiệm của bạn như thế nào?',
            style: subtitle2,
          ),
          Gap(8.h),
          Obx(
            () => RatingBar.builder(
              initialRating: controller.rating.value,
              ignoreGestures: controller.rating.value > 0,
              minRating: 1,
              direction: Axis.horizontal,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 8.0),
              itemSize: 24.sp,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
                size: 8.sp,
              ),
              onRatingUpdate: (value) {
                controller.gotoRatingPage(value);
              },
            ),
          )
        ],
      ),
    );
  }
}
