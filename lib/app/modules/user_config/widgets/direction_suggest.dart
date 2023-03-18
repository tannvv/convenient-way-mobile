import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/data/repository/request_model/route_model/create_route_point_model.dart';
import 'package:tien_duong/app/modules/user_config/controllers/user_config_controller.dart';

class DirectionSuggestForm extends GetWidget<UserConfigController> {
  const DirectionSuggestForm({super.key});

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
              'Hướng gợi ý gói hàng',
              style: subtitle2.copyWith(color: Colors.black.withOpacity(0.6)),
            ),
            Gap(12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                _forwardButton(),
                Gap(8.w),
                _backwardButton(),
                Gap(8.w),
                _twoWayButton(),
              ],
            ),
            Gap(12.h),
          ],
        ),
      ),
    );
  }

  Widget _backwardButton() {
    return Obx(
      () => ElevatedButton(
        onPressed: () {
          controller.updateDirectionSuggest(DirectionType.backward);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: controller.authController.directionSuggestConfig ==
                  DirectionType.backward
              ? AppColors.blue
              : AppColors.gray,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: EdgeInsets.only(right: 8.w, top: 2.h, bottom: 2.h),
          minimumSize: Size(26.r, 26.r),
        ),
        child: Row(
          children: [
            SizedBox(
              height: 26.r,
              width: 26.r,
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 14.r,
                color: AppColors.white,
              ),
            ),
            const Text('Chiều về')
          ],
        ),
      ),
    );
  }

  Widget _twoWayButton() {
    return Obx(
      () => ElevatedButton(
        onPressed: () {
          controller.updateDirectionSuggest(DirectionType.both);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: controller.authController.directionSuggestConfig ==
                  DirectionType.both
              ? AppColors.blue
              : AppColors.gray,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: EdgeInsets.only(right: 8.w, top: 2.h, bottom: 2.h),
          minimumSize: Size(26.r, 26.r),
        ),
        child: Row(
          children: [
            SizedBox(
              height: 26.r,
              width: 26.r,
              child: Icon(
                Icons.swap_vert,
                size: 18.r,
                color: AppColors.white,
              ),
            ),
            const Text('Hai chiều')
          ],
        ),
      ),
    );
  }

  Widget _forwardButton() {
    return Obx(
      () => ElevatedButton(
          onPressed: () {
            controller.updateDirectionSuggest(DirectionType.forward);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: controller.authController.directionSuggestConfig ==
                    DirectionType.forward
                ? AppColors.blue
                : AppColors.gray,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: EdgeInsets.only(right: 8.w, top: 2.h, bottom: 2.h),
            minimumSize: Size(26.r, 26.r),
          ),
          child: Row(
            children: [
              SizedBox(
                height: 26.r,
                width: 26.r,
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 14.r,
                  color: AppColors.white,
                ),
              ),
              const Text('Chiều đi')
            ],
          )),
    );
  }
}
