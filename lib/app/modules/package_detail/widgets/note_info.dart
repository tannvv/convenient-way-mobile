import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/modules/package_detail/controllers/package_detail_controller.dart';
import 'package:tien_duong/app/modules/package_detail/widgets/title_item.dart';

class NoteInfo extends GetWidget<PackageDetailController> {
  const NoteInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: controller.horizontalPadding, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const TitleItem(title: 'Ghi chú'),
          Gap(12.h),
          Text(
            controller.package.note ?? 'Không có',
            style: subtitle2.copyWith(
                fontWeight: FontWeight.w500, color: AppColors.description),
          )
        ],
      ),
    );
  }
}
