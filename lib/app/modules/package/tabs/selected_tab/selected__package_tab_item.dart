import 'package:flutter/material.dart';
import 'package:tien_duong/app/core/utils/datetime_utils.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/shadow_styles.dart';
import 'package:gap/gap.dart';
import 'package:tien_duong/app/core/widgets/button_color.dart';
import 'package:tien_duong/app/data/models/package_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tien_duong/app/data/models/transaction_package_model.dart';
import 'package:tien_duong/app/modules/package/widgets/location_start_end.dart';
import 'package:tien_duong/app/modules/package/widgets/package_info.dart';
import 'package:tien_duong/app/modules/package/widgets/user_info_pickup_point.dart';

class SelectedPackageTabItem extends StatelessWidget {
  const SelectedPackageTabItem(
      {Key? key,
      required this.package,
      this.onCancelPackage,
      this.onConfirmPackage,
      this.onCodeConfirm,
      this.onPickupFailed,
      required this.onShowQR})
      : super(key: key);
  final Package package;
  final Function()? onCancelPackage;
  final Function()? onConfirmPackage;
  final Function()? onCodeConfirm;
  final Function() onShowQR;
  final Function()? onPickupFailed;
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
          _buildLastTransaction(),
          Gap(12.h),
          UserInfoPickupPoint(
            package: package,
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
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
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
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ColorButton(
                'Tôi không thể lấy hàng',
                icon: Icons.sms_failed,
                onPressed: onPickupFailed,
                backgroundColor: Colors.red,
                textColor: Colors.red,
                radius: 8.sp,
                //padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
              ),
              Gap(12.h),
              ColorButton(
                "Hủy đơn",
                icon: Icons.delete,
                onPressed: onCancelPackage,
                backgroundColor: Colors.red,
                textColor: Colors.red,
                radius: 8.sp,
                //padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildLastTransaction() {
    TransactionPackage? transaction = package.transactionPackages?.last;
    if (transaction == null) return Container();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 12.h),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary700),
        borderRadius: BorderRadius.circular(6.w),
      ),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            width: 40.w,
            child: const Icon(Icons.check, color: AppColors.primary700),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.description!,
                ),
                Gap(4.h),
                Text(DateTimeUtils.dateTimeToStringFixUTC(
                    transaction.createdAt!))
              ],
            ),
          )
        ],
      ),
    );
  }
}
