import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/core/widgets/hyper_shape.dart';

class RatingLocationStartEnd extends StatelessWidget {
  const RatingLocationStartEnd(
      {super.key, required this.locationStart, required this.locationEnd});
  final String locationStart;
  final String locationEnd;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                          _locationItem('Điểm nhận', locationStart),
                          //Gap(2.h),
                          _locationItem('Điểm giao', locationEnd),
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
