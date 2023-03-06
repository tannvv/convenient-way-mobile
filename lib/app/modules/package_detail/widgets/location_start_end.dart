import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/core/widgets/hyper_shape.dart';
import 'package:tien_duong/app/modules/package_detail/controllers/package_detail_controller.dart';
import 'package:tien_duong/app/modules/package_detail/widgets/title_item.dart';

class LocationStartEnd extends GetWidget<PackageDetailController> {
  const LocationStartEnd({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: controller.horizontalPadding, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const TitleItem(title: 'Chặng đường: '),
              Text(
                '  (${controller.package.distance?.ceil()} m)',
                style: subtitle2.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.grey[500]),
              )
            ],
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(top: 11.h),
                height: 80.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HyperShape.startCircle(),
                    HyperShape.dot(),
                    HyperShape.dot(),
                    HyperShape.dot(),
                    HyperShape.dot(),
                    HyperShape.dot(),
                    HyperShape.endCircle(),
                  ],
                ),
              ),
              Gap(20.w),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //Gap(2.h),
                          _locationItem(
                              'Điểm đi', controller.package.startAddress ?? ''),
                          //Gap(2.h),
                          _locationItem('Điểm đến',
                              controller.package.destinationAddress ?? ''),
                        ],
                      ),
                    ),
                    SizedBox(width: 5.w),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _locationItem(String label, String location) {
    return JustTheTooltip(
      curve: Curves.bounceInOut,
      margin: EdgeInsets.symmetric(horizontal: 40.w),
      preferredDirection: AxisDirection.up,
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          location,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xff333333),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Gap(20.h),
          Text(
            label,
            style: caption.copyWith(
                color: Colors.grey[600], fontWeight: FontWeight.w600),
          ),
          Text(
            location.split(',')[0],
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xff333333),
            ),
          ),
        ],
      ),
    );
  }
}
