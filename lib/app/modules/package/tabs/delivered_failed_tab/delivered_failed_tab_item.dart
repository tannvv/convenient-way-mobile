import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tien_duong/app/core/utils/datetime_utils.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/shadow_styles.dart';
import 'package:tien_duong/app/data/models/package_model.dart';
import 'package:tien_duong/app/data/models/transaction_package_model.dart';
import 'package:tien_duong/app/modules/package/widgets/location_start_end.dart';
import 'package:tien_duong/app/modules/package/widgets/package_info.dart';
import 'package:tien_duong/app/modules/package/widgets/user_info.dart';

class DeliveredFailedTabItem extends StatelessWidget {
  const DeliveredFailedTabItem({
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
          _buildLastTransaction(),
          Gap(12.h),
          UserInfo(info: package.sender!.infoUser!),
          LocationStartEnd(
              locationStart: package.startAddress!,
              locationEnd: package.destinationAddress!),
          Gap(12.h),
          PackageInfo(
            package: package,
          ),
          // )
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
