import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tien_duong/app/core/utils/datetime_utils.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/shadow_styles.dart';
import 'package:tien_duong/app/data/models/package_model.dart';
import 'package:tien_duong/app/data/models/transaction_package_model.dart';
import 'package:tien_duong/app/modules/package/widgets/user_info.dart';

import 'complete_package_info.dart';
import 'complete_package_location.dart';

class CompletePackageItem extends StatelessWidget {
  const CompletePackageItem({
    Key? key,
    required this.onTapDetail,
    required this.package,
  }) : super(key: key);
  final Package package;
  final Function() onTapDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 24.w),
      decoration: BoxDecoration(
          color: AppColors.white, boxShadow: ShadowStyles.primary),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLastTransaction(),
          Gap(12.h),
          UserInfo(info: package.sender!.infoUser!),
          CompletePackageLocation(
              locationStart: package.startAddress!,
              locationEnd: package.destinationAddress!),
          Gap(12.h),
          CompletePackageInfo(
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
          ),
          Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            width: 40.w,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(100.sp),
                highlightColor: Colors.grey,
                onTap: onTapDetail,
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: const Icon(Icons.arrow_forward_ios,
                      color: AppColors.primary700),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
