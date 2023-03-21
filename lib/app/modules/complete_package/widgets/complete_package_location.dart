import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/core/widgets/hyper_shape.dart';

class CompletePackageLocation extends StatelessWidget {
  const CompletePackageLocation(
      {super.key, required this.locationStart, required this.locationEnd});
  final String locationStart;
  final String locationEnd;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(top: 11.5.h),
          height: 70.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HyperShape.startCircle(),
              HyperShape.dot(),
              HyperShape.dot(),
              HyperShape.dot(),
              HyperShape.endCircle(),
            ],
          ),
        ),
        Gap(20.w),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(top: 3.5.h),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Gap(2.h),
                      _locationItem('Điểm nhận', locationStart),
                      Gap(2.h),
                      _locationItem('Điểm giao', locationEnd),
                    ],
                  ),
                ),
                SizedBox(width: 5.w),
              ],
            ),
          ),
        ),
      ],
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
          Gap(12.h),
          Text(
            label,
            style: caption.copyWith(color: Colors.grey[700]),
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
