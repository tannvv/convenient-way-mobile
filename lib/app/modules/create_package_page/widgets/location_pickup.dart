import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
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
              key: controller.startLocationKey,
              focusNode: controller.focusStartLocationNode,
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
          ],
        ),
      ),
    );
  }
}
