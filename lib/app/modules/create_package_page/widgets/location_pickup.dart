import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/shadow_styles.dart';
import 'package:tien_duong/app/modules/create_package_page/controllers/create_package_page_controller.dart';
import 'package:tien_duong/app/modules/create_package_page/widgets/place_field.dart';

class LocationPickup extends GetWidget<CreatePackagePageController> {
  const LocationPickup({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: ShadowStyles.map),
      child: PlaceField(
          enable: true,
          hintText: 'Nhập địa chỉ',
          labelText: 'Địa chỉ',
          onSelected: controller.selectedPickupLocation,
          textController: TextEditingController()),
    );
  }
}
