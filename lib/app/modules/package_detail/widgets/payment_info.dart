import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/modules/package_detail/controllers/package_detail_controller.dart';
import 'package:tien_duong/app/modules/package_detail/widgets/title_item.dart';

class PaymentInfo extends GetWidget<PackageDetailController> {
  const PaymentInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: controller.horizontalPadding, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const TitleItem(title: 'Chi tiết thanh toán'),
          Gap(8.h),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  'Sản phẩm',
                  style: subtitle2.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.description),
                ),
              ),
              Text(
                controller.totalPriceProducts,
                style: subtitle2.copyWith(
                    fontWeight: FontWeight.w500, color: AppColors.description),
              )
            ],
          ),
          Gap(8.h),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  'Phí vận chuyển',
                  style: subtitle2.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.description),
                ),
              ),
              Text(
                controller.package.priceShip.toVND(),
                style: subtitle2.copyWith(
                    fontWeight: FontWeight.w500, color: AppColors.description),
              )
            ],
          ),
          Gap(8.h),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  'Tổng',
                  style: subtitle2.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.description),
                ),
              ),
              Text(
                controller.totalPrice,
                style: subtitle2.copyWith(
                    fontWeight: FontWeight.w500, color: AppColors.description),
              )
            ],
          ),
        ],
      ),
    );
  }
}
