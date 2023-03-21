import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/utils/datetime_utils.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/data/models/transaction_package_model.dart';

import '../controllers/complete_package_detail_controller.dart';

class CompleteTransactionsPackage
    extends GetWidget<CompletePackageDetailController> {
  const CompleteTransactionsPackage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Column(
        children: [
          for (int i = 0; i < controller.transactionPackages.length; i++)
            _buildTransaction(controller.transactionPackages[i], i)
        ],
      ),
    );
  }

  Widget _buildTransaction(TransactionPackage transaction, int index) {
    bool isLast = index == controller.transactionPackages.length - 1;
    bool isFirst = index == 0;
    Color colorDisable = Colors.black45;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: controller.widthSeparateTransaction,
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Text(
                DateTimeUtils.dateTimeToStringDateFixUTC(transaction.createdAt),
                style: caption.copyWith(
                    color: isFirst ? Colors.black : colorDisable),
              ),
              Text(
                DateTimeUtils.dateTimeToStringTimeFixUTC(transaction.createdAt),
                style: caption.copyWith(
                    color: isFirst ? Colors.black : colorDisable),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Icon(
              isFirst ? Icons.check_circle_rounded : Octicons.primitive_dot,
              color: isFirst ? AppColors.blue : colorDisable,
            ),
            isLast
                ? Container()
                : SizedBox(
                    height: controller.widthSeparateTransaction - 20.h,
                    child: VerticalDivider(color: colorDisable))
          ],
        ),
        Expanded(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.getLabel(transaction.toStatus!),
                style: subtitle2.copyWith(
                    color: isFirst ? AppColors.blue : colorDisable),
              ),
              Gap(4.h),
              Text(
                transaction.description ?? '-',
                style: TextStyle(color: isFirst ? Colors.black : colorDisable),
              ),
            ],
          ),
        ))
      ],
    );
  }
}
