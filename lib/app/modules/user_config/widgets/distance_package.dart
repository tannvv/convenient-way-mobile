import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/modules/user_config/controllers/user_config_controller.dart';

class DistancePackageForm extends GetWidget<UserConfigController> {
  const DistancePackageForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          border: Border.all(width: 2, color: Colors.black.withOpacity(0.16))),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Khoảng cách tối đa gói hàng với lộ trình',
              style: subtitle2.copyWith(color: Colors.black.withOpacity(0.6)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(flex: 3, child: _inputDistancePackage()),
                Flexible(
                    flex: 2,
                    child: SizedBox(
                      height: 32,
                      child: Visibility(
                        child: Obx(
                          () => ElevatedButton(
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry>(EdgeInsets.zero),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          controller.packageDistanceField
                                                      .value ==
                                                  controller
                                                      .initPackageDistanceOrigin
                                                      .value
                                              ? Colors.grey
                                              : Colors.green)),
                              onPressed: () async {
                                controller.updatePackageDistance();
                              },
                              child: const Text('Lưu')),
                        ),
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  TextFormField _inputDistancePackage() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        suffixText: 'm',
        border: InputBorder.none,
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2.0,
            )),
      ),
      initialValue: controller.initPackageDistance,
      onChanged: (String value) {
        controller.packageDistanceField.value = value;
      },
    );
  }
}
