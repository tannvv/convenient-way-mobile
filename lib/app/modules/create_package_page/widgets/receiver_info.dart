import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/input_styles.dart';
import 'package:tien_duong/app/core/values/shadow_styles.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/modules/create_package_page/controllers/create_package_page_controller.dart';
import 'package:tien_duong/app/modules/create_package_page/widgets/place_field.dart';

class ReceivedInfo extends GetWidget<CreatePackagePageController> {
  const ReceivedInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Container(
        padding: EdgeInsets.only(left: 14.w, right: 8.w, bottom: 20.h),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: ShadowStyles.map),
        child: Column(
          children: [
            TextFormField(
                style: subtitle1.copyWith(
                  color: AppColors.lightBlack,
                ),
                onChanged: (value) => controller.receivedName = value,
                validator: validatorNotNull,
                initialValue: controller.receivedName,
                decoration: InputStyles.map(
                  labelText: 'Tên người nhận',
                )),
            const Gap(10),
            TextFormField(
                style: subtitle1.copyWith(
                  color: AppColors.lightBlack,
                ),
                validator: validatorNotNull,
                initialValue: controller.receivedPhone,
                onChanged: (value) => controller.receivedPhone = value,
                decoration: InputStyles.map(
                  labelText: 'Số điện thoại',
                )),
            const Gap(10),
            PlaceField(
                enable: true,
                hintText: '',
                labelText: 'Địa chỉ',
                autofocus: false,
                onSelected: controller.selectedSendLocation),
          ],
        ),
      ),
    );
  }

  String? validatorNotNull(String? value) {
    if (value == null || value.isEmpty) {
      return 'Không được để trống';
    }
    return null;
  }
}
