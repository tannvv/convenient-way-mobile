import 'package:tien_duong/app/core/utils/datetime_utils.dart';
import 'package:tien_duong/app/core/values/app_assets.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/font_weight.dart';
import 'package:tien_duong/app/core/values/shadow_styles.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/data/constants/transaction_title.dart';
import 'package:tien_duong/app/data/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.index,
    required this.model,
  }) : super(key: key);

  final Transaction? model;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: ShadowStyles.primary,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (model?.title == TransactionTitle.RECEIVE)
            _receive()
          else if (model?.title == TransactionTitle.MOMO)
            _moMo()
          else if (model?.title == TransactionTitle.VNPAY)
            _vnpay()
          else if (model?.title == TransactionTitle.REFUND)
            _refund()
          else if (model?.title == TransactionTitle.DELIVERY_SUCCESS)
            _deliverySuccess()
          else
            _default(),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${model?.description}',
                        style: body2.copyWith(
                          color: AppColors.softBlack,
                          fontSize: 14.r,
                        ),
                      ),
                      Text(
                        DateTimeUtils.dateTimeToString(model?.createdAt),
                        style: body2.copyWith(
                          color: AppColors.gray,
                          fontSize: 14.r,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if ((model?.coinExchange ?? 0) > 0)
                        Text(
                          '+${model!.coinExchange.toVND()}',
                          style: subtitle2.copyWith(
                            color: AppColors.primary400,
                            fontWeight: FontWeights.medium,
                          ),
                        )
                      else
                        Text(
                          model!.coinExchange.toVND(),
                          style: subtitle2.copyWith(
                            color: AppColors.softBlack,
                            fontWeight: FontWeights.medium,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _deliverySuccess() {
    return Container(
      width: 40.r,
      height: 40.r,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.otp,
      ),
      child: Image.asset(
        AppAssets.senderConfirmPng,
        width: 30.h,
        height: 30.h,
      ),
    );
  }

  Container _receive() {
    return Container(
      width: 40.r,
      height: 40.r,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.otp,
      ),
      child: Image.asset(
        AppAssets.deliveredPng,
        width: 40.h,
        height: 40.h,
      ),
    );
  }

  Container _refund() {
    return Container(
      width: 40.r,
      height: 40.r,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.hardBlue,
      ),
      child: Stack(
        children: [
          Center(
            child: SvgPicture.asset(
              AppAssets.refund,
              color: AppColors.white,
              width: 26.r,
            ),
          ),
        ],
      ),
    );
  }

  Container _payPal() {
    return Container(
      width: 40.r,
      height: 40.r,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.line,
      ),
      child: Stack(
        children: [
          Center(
            child: SvgPicture.asset(
              AppAssets.paypal,
              width: 26.r,
            ),
          ),
        ],
      ),
    );
  }

  Container _moMo() {
    return Container(
      width: 40.r,
      height: 40.r,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.otp,
      ),
      child: Stack(
        children: [
          Center(
            child: SvgPicture.asset(
              AppAssets.momo,
              width: 26.r,
            ),
          ),
        ],
      ),
    );
  }

  Container _vnpay() {
    return Container(
      width: 40.r,
      height: 40.r,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.otp,
      ),
      child: Stack(
        children: [
          Center(
            child: SvgPicture.asset(
              AppAssets.vnpay2,
              width: 26.r,
            ),
          ),
        ],
      ),
    );
  }

  Container _default() {
    return Container(
      width: 40.r,
      height: 40.r,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.indicator,
      ),
      child: Stack(
        children: [
          Center(
            child: Icon(
              Icons.paid,
              size: 26.r,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
