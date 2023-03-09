import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/utils/function_utils.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/input_styles.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/modules/create_package_page/controllers/create_package_page_controller.dart';
import 'package:tien_duong/app/modules/create_package_page/widgets/place_field_goong_create_package.dart';

class ReceivedInfo extends GetWidget<CreatePackagePageController> {
  const ReceivedInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      child: Form(
        key: controller.receiverFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PlaceFieldGoongCreatePackage(
                enable: true,
                hintText: '',
                labelText: 'Địa chỉ',
                autofocus: true,
                formKey: controller.endLocationKey,
                focusNode: controller.focusEndLocationNode,
                initialValue: controller.destinationAddress,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập địa chỉ';
                  }
                  if (controller.destinationLatitude == null ||
                      controller.destinationLongitude == null) {
                    return 'Không thể tìm thấy vị trí';
                  }
                  return null;
                },
                textController: controller.senderTxtCtrl,
                onSelected: controller.selectedSendLocation),
            Gap(20.h),
            TextFormField(
                style: subtitle1.copyWith(
                  color: AppColors.lightBlack,
                ),
                key: controller.receiverNameKey,
                onChanged: (value) => controller.receivedName = value,
                validator: FunctionUtils.validatorNotNull,
                initialValue: controller.receivedName,
                focusNode: controller.focusReceiverName,
                autofocus: true,
                decoration:
                    InputStyles.createPackage(labelText: 'Tên người nhận')),
            Gap(20.h),
            TextFormField(
                style: subtitle1.copyWith(
                  color: AppColors.lightBlack,
                ),
                key: controller.receiverPhoneKey,
                validator: FunctionUtils.validatorPhone,
                initialValue: controller.receivedPhone,
                focusNode: controller.focusReceiverPhone,
                autofocus: false,
                onChanged: (value) => controller.receivedPhone = value,
                decoration: InputStyles.createPackage(
                  labelText: 'Số điện thoại',
                )),
            Gap(20.h),
            Obx(
              () => controller.distance.value != 0.0
                  ? RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                          text:
                              'Khoảng cách: ${controller.distance.value.toStringAsFixed(2)} km',
                          style:
                              subtitle1.copyWith(color: AppColors.lightBlack),
                          children: [
                            TextSpan(
                              text:
                                  '\nGiá vận chuyển: ${controller.getPriceShip().toVND()}',
                            )
                          ]),
                    )
                  : Container(),
            )
          ],
        ),
      ),
    );
  }
}
