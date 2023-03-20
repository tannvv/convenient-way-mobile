import 'package:flutter/material.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/shadow_styles.dart';
import 'package:gap/gap.dart';
import 'package:tien_duong/app/core/widgets/button_color.dart';
import 'package:tien_duong/app/data/models/package_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tien_duong/app/modules/package/widgets/location_start_end.dart';
import 'package:tien_duong/app/modules/package/widgets/package_info.dart';
import 'package:tien_duong/app/modules/package/widgets/user_info_pickup_point.dart';

class CancelTabItem extends StatelessWidget {
  const CancelTabItem({
    Key? key,
    required this.package,
  }) : super(key: key);
  final Package package;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 24.w),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.w),
          boxShadow: ShadowStyles.primary),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserInfoPickupPoint(
            package: package,
          ),
          LocationStartEnd(
              locationStart: package.startAddress!,
              locationEnd: package.destinationAddress!),
          Gap(12.h),
          PackageInfo(package: package),
          Gap(12.h),
        ],
      ),
    );
  }
}
