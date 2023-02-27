import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/utils/function_utils.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/input_styles.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/modules/create_package_page/controllers/create_package_page_controller.dart';
import 'package:tien_duong/app/modules/create_package_page/widgets/place_field.dart';

class ReceivedInfo extends GetWidget<CreatePackagePageController> {
  const ReceivedInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      child: Form(
        key: controller.receiverFormKey,
        child: Column(
          children: [
            PlaceField(
                enable: true,
                hintText: '',
                labelText: 'Địa chỉ',
                autofocus: true,
                initialValue: controller.destinationAddress,
                validator: FunctionUtils.validatorNotNull,
                textController: controller.senderTxtCtrl,
                onSelected: controller.selectedSendLocation),
            Gap(20.h),
            TextFormField(
                style: subtitle1.copyWith(
                  color: AppColors.lightBlack,
                ),
                onChanged: (value) => controller.receivedName = value,
                validator: FunctionUtils.validatorNotNull,
                initialValue: controller.receivedName,
                decoration:
                    InputStyles.createPackage(labelText: 'Tên người nhận')),
            Gap(20.h),
            TextFormField(
                style: subtitle1.copyWith(
                  color: AppColors.lightBlack,
                ),
                validator: FunctionUtils.validatorNotNull,
                initialValue: controller.receivedPhone,
                onChanged: (value) => controller.receivedPhone = value,
                decoration: InputStyles.createPackage(
                  labelText: 'Số điện thoại',
                )),
            Gap(20.h),
          ],
        ),
      ),
    );
  }
}
