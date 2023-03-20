import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/widgets/header_scaffold.dart';

import '../controllers/delivered_failed_controller.dart';
import '../widgets/btn_submit.dart';
import '../widgets/image_select.dart';
import '../widgets/wrap_reasons.dart';

class DeliveredFailedView extends GetView<DeliveredFailedController> {
  const DeliveredFailedView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              HeaderScaffold(
                title: '',
                isBack: true,
              ),
              WrapReasonDeliveredFailed(),
              ImageSelectDeliveredFailed(),
              BtnSubmitDeliveredFailed(),
            ],
          ),
        ),
      ),
    );
  }
}
