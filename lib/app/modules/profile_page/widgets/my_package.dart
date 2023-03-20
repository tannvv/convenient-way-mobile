import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/values/app_assets.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/modules/profile_page/controllers/profile_page_controller.dart';
import 'package:tien_duong/app/routes/app_pages.dart';

class MyPackage extends GetWidget<ProfilePageController> {
  const MyPackage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(5.r),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade300, blurRadius: 2, spreadRadius: 1)
        ],
      ),
      width: 324.w,
      padding: EdgeInsets.symmetric(
        vertical: 12.h,
        horizontal: 14.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gói hàng của tôi',
            style: header,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _statusPackage(
                  AppAssets.deliverPickupPng, 'Đang\nthực hiện', () {}),
              Gap(8.w),
              _statusPackage(AppAssets.deliveredPng, 'Đã\nthực hiện', () {}),
              Gap(8.w),
              _statusPackage(
                  AppAssets.cancelPackagePng, 'Đơn đã hủy\n& hoàn trả', () {
                Get.toNamed(Routes.PACKAGE_CANCEL_AND_REFUND);
              }),
            ],
          )
        ],
      ),
    );
  }

  Widget _statusPackage(String assets, String text, Function() callback) {
    return Material(
      color: AppColors.white,
      child: InkWell(
        onTap: callback,
        borderRadius: BorderRadius.circular(12.w),
        child: Ink(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Column(
              children: [
                Image.asset(
                  assets,
                  width: 30.h,
                  height: 30.h,
                ),
                Gap(4.h),
                Text(
                  text,
                  style: caption.copyWith(color: AppColors.black),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
