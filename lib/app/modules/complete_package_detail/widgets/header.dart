import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/values/app_assets.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/modules/complete_package_detail/controllers/complete_package_detail_controller.dart';

class Header extends GetWidget<CompletePackageDetailController> {
  const Header({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        AppAssets.logo,
                        width: 20.w,
                        height: 20.h,
                      ),
                      Gap(8.w),
                      Text(
                        'Tiện Đường',
                        style: h6.copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Gap(8.h),
                ],
              ),
              Column(
                children: [
                  Text(
                    controller.createAt,
                    style: caption.copyWith(color: AppColors.gray),
                  ),
                  Gap(4.h),
                ],
              )
            ],
          ),
          Text(
            'Mã đơn: ${controller.package.id}',
            style: caption.copyWith(color: AppColors.gray),
          )
        ],
      ),
    );
  }
}
