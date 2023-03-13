import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/utils/function_utils.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/input_styles.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/modules/create_package_page/controllers/create_package_page_controller.dart';
import 'package:tien_duong/app/modules/create_package_page/widgets/place_field_goong_create_package.dart';

class LocationPickup extends GetWidget<CreatePackagePageController> {
  const LocationPickup({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.pickupFormKey,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        child: Column(
          children: [
            PlaceFieldGoongCreatePackage(
              enable: true,
              hintText: '',
              labelText: 'Điểm đi',
              focusNode: controller.focusStartLocationNode,
              formKey: controller.startLocationKey,
              autofocus: true,
              initialValue: controller.startAddress,
              onSelected: controller.selectedPickupLocation,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập địa chỉ';
                }
                if (controller.startLatitude == null ||
                    controller.startLongitude == null) {
                  return 'Không thể tìm thấy vị trí';
                }
                return null;
              },
              textController: controller.pickupTxtCtrl,
            ),
            Gap(20.h),
            TextFormField(
                style: subtitle1.copyWith(
                  color: AppColors.lightBlack,
                ),
                key: controller.pickupNameKey,
                onChanged: (value) => controller.pickupName = value,
                validator: FunctionUtils.validatorNotNull,
                focusNode: controller.focusPickupName,
                initialValue: controller.pickupName,
                decoration: InputStyles.createPackage(labelText: 'Tên')),
            Gap(20.h),
            TextFormField(
                style: subtitle1.copyWith(
                  color: AppColors.lightBlack,
                ),
                key: controller.receiverPhoneKey,
                validator: FunctionUtils.validatorPhone,
                focusNode: controller.focusReceiverPhone,
                initialValue: controller.pickupPhone,
                maxLength: 10,
                autofocus: false,
                keyboardType: TextInputType.phone,
                onChanged: (value) => controller.pickupPhone = value,
                decoration: InputStyles.createPackage(
                  labelText: 'Số điện thoại',
                )),
            Gap(12.h),
          ],
        ),
      ),
    );
  }
}
