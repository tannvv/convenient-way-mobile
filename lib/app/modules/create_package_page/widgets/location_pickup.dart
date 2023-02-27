import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/utils/function_utils.dart';
import 'package:tien_duong/app/modules/create_package_page/controllers/create_package_page_controller.dart';
import 'package:tien_duong/app/modules/create_package_page/widgets/place_field.dart';

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
            PlaceField(
              enable: true,
              hintText: '',
              labelText: 'Điểm đi',
              initialValue: controller.startAddress,
              onSelected: controller.selectedPickupLocation,
              validator: FunctionUtils.validatorNotNull,
              textController: controller.pickupTxtCtrl,
            ),
            Gap(20.h),
          ],
        ),
      ),
    );
  }
}
