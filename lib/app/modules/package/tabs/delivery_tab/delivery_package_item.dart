import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/shadow_styles.dart';
import 'package:tien_duong/app/core/widgets/button_color.dart';
import 'package:tien_duong/app/core/widgets/color_button.dart';
import 'package:tien_duong/app/data/models/package_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:tien_duong/app/modules/package/widgets/location_start_end.dart';
import 'package:tien_duong/app/modules/package/widgets/package_info.dart';
import 'package:tien_duong/app/modules/package/widgets/user_info.dart';

class DeliveryPackageItem extends StatelessWidget {
  const DeliveryPackageItem(
      {Key? key, required this.package, this.onCancelPackage, this.onConfirmPackage, required this.onShowQR})
      : super(key: key);
  final Package package;
  final Function()? onShowQR;
  final Function()? onCancelPackage;
  final Function()? onConfirmPackage;
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
                'Lấy mã QR',
                icon: Icons.qr_code,
                onPressed: onShowQR,
                backgroundColor: AppColors.primary800,
                textColor: AppColors.primary800,
                radius: 8.sp,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
              ),
              Gap(8.w),
              ColorButton(
                'Hủy',
                icon: Icons.delete,
                onPressed: onCancelPackage,
                backgroundColor: Colors.red,
                textColor: Colors.red,
                radius: 8.sp,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
              ),
              Gap(8.w),
              ColorButton(
                'QR Xác nhận',
                icon: Icons.verified,
                onPressed: onConfirmPackage,
                backgroundColor: AppColors.green,
                textColor: AppColors.green,
                radius: 8.sp,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
              ),
            ],
          )
        ],
      ),
    );
  }
}
