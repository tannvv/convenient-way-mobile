import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/utils/function_utils.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/button_styles.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/modules/delivered_failed/controllers/delivered_failed_controller.dart';

class WrapReasonDeliveredFailed extends GetWidget<DeliveredFailedController> {
  const WrapReasonDeliveredFailed({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(20.h),
        Text(
          'Tại sao bạn không thể giao hàng',
          style: subtitle1.copyWith(
              fontWeight: FontWeight.bold, color: Colors.grey[500]),
        ),
        Gap(12.h),
        Wrap(
          spacing: 12.w,
          children: [
            _reasonChip('Không thể liên lạc'),
            _reasonChip('Người nhận không đồng ý lấy hàng'),
          ],
        ),
        Gap(12.h),
        TextFormField(
          controller: controller.reasonController,
          validator: FunctionUtils.validatorNotNull,
          key: controller.reasonFieldKey,
          focusNode: controller.reasonFocusNode,
          decoration: InputDecoration(
            hintText: 'Chọn hoặc nhập lí do',
            hintStyle: subtitle2.copyWith(
              color: AppColors.lightBlack,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
            ),
          ),
        ),
      ],
    );
  }

  Widget _reasonChip(String text) {
    return TextButton(
      onPressed: () {
        controller.reasonController.text = text;
      },
      style: ButtonStyles.paymentChip(),
      child: Text(
        text,
        style: subtitle2.copyWith(
          color: AppColors.lightBlack,
        ),
      ),
    );
  }
}
