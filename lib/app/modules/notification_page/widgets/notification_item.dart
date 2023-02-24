import 'package:tien_duong/app/core/utils/datetime_utils.dart';
import 'package:tien_duong/app/core/values/app_assets.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/shadow_styles.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/data/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.index, required this.model});

  final NotificationModel model;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: ShadowStyles.primary,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _default(),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 4.h),
                        child: Text(
                          '${model.title}',
                          style: subtitle2.copyWith(
                            color: AppColors.softBlack,
                            fontSize: 14.r,
                          ),
                        ),
                      ),
                      Text(
                        DateTimeUtils.dateTimeToString(model.createdAt),
                        style: body2.copyWith(
                          color: AppColors.gray,
                          fontSize: 14.r,
                        ),
                      ),
                      Text(
                        '${model.content}',
                        style: caption.copyWith(
                          fontSize: 14.r,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _payPal() {
    return Container(
      width: 40.r,
      height: 40.r,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.line,
      ),
      child: Stack(
        children: [
          Center(
            child: SvgPicture.asset(
              AppAssets.paypal,
              width: 26.r,
            ),
          ),
        ],
      ),
    );
  }

  Container _moMo() {
    return Container(
      width: 40.r,
      height: 40.r,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.otp,
      ),
      child: Stack(
        children: [
          Center(
            child: SvgPicture.asset(
              AppAssets.momo,
              width: 26.r,
            ),
          ),
        ],
      ),
    );
  }

  Container _vnpay() {
    return Container(
      width: 40.r,
      height: 40.r,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.otp,
      ),
      child: Stack(
        children: [
          Center(
            child: SvgPicture.asset(
              AppAssets.vnpay2,
              width: 26.r,
            ),
          ),
        ],
      ),
    );
  }

  Container _default() {
    return Container(
      width: 40.r,
      height: 40.r,
      padding: EdgeInsets.all(4.r),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.indicator,
      ),
      child: Stack(
        children: [
          Center(
            child: Image.asset(AppAssets.deliverPickupPng),
          ),
        ],
      ),
    );
  }
}
