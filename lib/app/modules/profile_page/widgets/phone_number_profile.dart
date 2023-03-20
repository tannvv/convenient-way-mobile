import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/font_weight.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/modules/profile_page/controllers/profile_page_controller.dart';

class PhoneNumberProfile extends GetWidget<ProfilePageController> {
  const PhoneNumberProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Số điện thoại',
              style: body2.copyWith(color: AppColors.gray),
            ),
            SizedBox(
              width: Get.width * 0.6,
              height: 44.h,
              child: _inputPhone(),
            )
          ],
        ),
        SizedBox(
          height: 40,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8, right: 20),
            child: Visibility(
              child: ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.zero),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.grey)),
                  onPressed: () async {},
                  child: const Text('Lưu')),
            ),
          ),
        )
      ],
    );
  }

  TextFormField _inputPhone() {
    return TextFormField(
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintStyle: subtitle2,
        border: InputBorder.none,
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2.0,
            )),
      ),
      style: subtitle1.copyWith(
        fontSize: 15.sp,
        color: AppColors.softBlack,
        fontWeight: FontWeights.medium,
      ),
      initialValue: controller.initPhone,
      onChanged: (String value) {
        controller.phoneField.value = value;
      },
    );
  }
}
