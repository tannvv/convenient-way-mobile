import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/font_weight.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/core/widgets/button_color.dart';
import 'package:tien_duong/app/modules/profile_page/controllers/profile_page_controller.dart';
import 'package:tien_duong/app/routes/app_pages.dart';

class WalletProfile extends GetWidget<ProfilePageController> {
  const WalletProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(5.r),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade300, blurRadius: 2, spreadRadius: 1)
        ],
      ),
      width: 324.w,
      height: 130.h,
      padding: EdgeInsets.symmetric(
        vertical: 12.h,
        horizontal: 14.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Số dư', style: body2.copyWith(color: AppColors.floatLabel)),
              Gap(6.w),
              _balanceAvailable(),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Obx(
            () => Text(
              controller.accountBalanceVND,
              style: subtitle1.copyWith(
                fontSize: 18.sp,
                color: AppColors.softBlack,
                fontWeight: FontWeights.medium,
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              ColorButton(
                'Nạp tiền',
                radius: 6.r,
                onPressed: () {
                  Get.toNamed(Routes.PAYMENT);
                },
                icon: Icons.payments_outlined,
              ),
              SizedBox(
                width: 10.w,
              ),
              ColorButton(
                'Giao dịch',
                radius: 6.r,
                onPressed: () => {Get.toNamed(Routes.TRANSACTION)},
                icon: Icons.summarize_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Obx _balanceAvailable() {
    return Obx(() => controller.isLoadingBalance
        ? Shimmer.fromColors(
            baseColor: AppColors.shimmerBaseColor,
            highlightColor: AppColors.shimmerHighlightColor,
            child: Container(
              width: 50.w,
              height: 14.h,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
          )
        : controller.isNewAccount
            ? Container()
            : Text(
                '(khả dụng: ${controller.availableBalance.toVND()})',
                style: caption.copyWith(
                  color: AppColors.softBlack,
                  fontWeight: FontWeights.medium,
                ),
              ));
  }
}
