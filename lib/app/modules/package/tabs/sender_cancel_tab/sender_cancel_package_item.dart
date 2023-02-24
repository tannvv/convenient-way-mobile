import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/shadow_styles.dart';
import 'package:tien_duong/app/data/models/package_cancel_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:tien_duong/app/modules/package/widgets/location_start_end.dart';
import 'package:tien_duong/app/modules/package/widgets/package_cancel_info.dart';

class SenderCancelPackageItem extends StatelessWidget {
  const SenderCancelPackageItem({Key? key, required this.package})
      : super(key: key);
  final PackageCancel package;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 24.w),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(6.w),
            boxShadow: ShadowStyles.primary),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LocationStartEnd(
                locationStart: package.startAddress!,
                locationEnd: package.destinationAddress!),
            Gap(12.h),
            PackageCancelInfo(
              package: package,
            ),
          ],
        ));
  }
}
