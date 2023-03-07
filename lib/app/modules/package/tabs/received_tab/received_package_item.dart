import 'package:flutter/material.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/shadow_styles.dart';
import 'package:gap/gap.dart';
import 'package:tien_duong/app/core/widgets/button_color.dart';
import 'package:tien_duong/app/core/widgets/color_button.dart';
import 'package:tien_duong/app/data/models/package_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tien_duong/app/modules/package/widgets/location_start_end.dart';
import 'package:tien_duong/app/modules/package/widgets/package_info.dart';
import 'package:tien_duong/app/modules/package/widgets/user_info.dart';

class ReceivedPackageItem extends StatelessWidget {
  const ReceivedPackageItem(
      {Key? key,
      required this.package,
      this.onCancelPackage,
      this.onConfirmPackage,
      required this.onShowQR})
      : super(key: key);
  final Package package;
  final Function()? onCancelPackage;
  final Function()? onConfirmPackage;
  final Function() onShowQR;
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
          UserInfo(info: package.sender!.infoUser!),
          LocationStartEnd(
              locationStart: package.startAddress!,
              locationEnd: package.destinationAddress!),
          Gap(12.h),
          PackageInfo(package: package),
          Gap(12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ColorButton(
                "Hủy",
                icon: Icons.delete,
                onPressed: onCancelPackage,
                backgroundColor: Colors.red,
                textColor: Colors.red,
                radius: 8.sp,
                //padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
              ),
              Gap(6.w),
              ColorButton(
                'Lấy mã QR',
                icon: Icons.qr_code,
                onPressed: onShowQR,
                backgroundColor: AppColors.primary800,
                textColor: AppColors.primary800,
                radius: 8.sp,
                //padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
              ),
              Gap(6.w),
              ColorButton(
                'Quét QR lấy hàng',
                icon: Icons.qr_code,
                onPressed: onConfirmPackage,
                backgroundColor: AppColors.primary800,
                textColor: AppColors.primary800,
                radius: 8.sp,
                //padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
              ),
            ],
          )
        ],
      ),
    );
  }
}
