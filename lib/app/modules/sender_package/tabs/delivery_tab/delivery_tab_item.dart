import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/widgets/button_color.dart';
import 'package:tien_duong/app/data/models/package_model.dart';
import 'package:tien_duong/app/modules/sender_package/widgets/location_start_end.dart';
import 'package:tien_duong/app/modules/sender_package/widgets/package_info.dart';
import 'package:tien_duong/app/modules/sender_package/widgets/user_info.dart';
import 'package:tien_duong/app/modules/sender_package/widgets/wrap_item.dart';

class DeliveryTabItem extends StatelessWidget {
  const DeliveryTabItem(
      {Key? key,
        required this.package,
        required this.onShowQR,
        required this.onConfirmPackage,
        required this.onCodeConfirm,
        required this.showMapTracking,
        required this.onShowDeliverInfo})
      : super(key: key);
  final Package package;
  final Function() onShowQR;
  final Function() onConfirmPackage;
  final Function() onCodeConfirm;
  final Function() showMapTracking;
  final Function() onShowDeliverInfo;
  @override
  Widget build(BuildContext context) {
    return WrapItem(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserInfo(
            info: package.deliver!.infoUser!,
            onTap: onShowDeliverInfo,
          ),
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
                //padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
              ),
              Gap(12.h),
              ColorButton(
                'Theo dõi đơn hàng',
                icon: Icons.location_on,
                onPressed: showMapTracking,
                backgroundColor: Colors.lightBlueAccent,
                textColor: Colors.blueAccent,
                radius: 8.sp,
                //padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ColorButton(
                'Xác nhận bằng Mã',
                icon: Icons.onetwothree,
                onPressed: onCodeConfirm,
                backgroundColor: AppColors.primary800,
                textColor: AppColors.primary800,
                radius: 8.sp,
                //padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
              ),
              Gap(12.w),
              ColorButton(
                'Quét QR lấy hàng',
                icon: Icons.qr_code_scanner,
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
