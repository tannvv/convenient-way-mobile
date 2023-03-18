import 'package:tien_duong/app/core/widgets/hyper_shape.dart';
import 'package:tien_duong/app/core/widgets/place_field_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/modules/select_route/controllers/select_route_controller.dart';

class SelectRouteInfo extends GetWidget<SelectRouteController> {
  const SelectRouteInfo({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 11.5.h),
              height: 85.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HyperShape.startCircle(),
                  HyperShape.dot(),
                  HyperShape.dot(),
                  HyperShape.dot(),
                  HyperShape.endCircle(),
                ],
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 3.5.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Obx(
                            () => PlaceFieldDefault(
                              enable: controller.currentStep.value == 0,
                              labelText: 'Điểm đi',
                              hintText: '',
                              onSelected: controller.setStartLocation,
                              textController: controller.startTxtController,
                              direction: AxisDirection.up,
                            ),
                          ),
                          Obx(
                            () => PlaceFieldDefault(
                              labelText: 'Điểm đến',
                              enable: controller.currentStep.value == 0,
                              onSelected: controller.setEndLocation,
                              textController: controller.endTxtController,
                              hintText: '',
                              direction: AxisDirection.up,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12.w),
                    // ElevatedButton(
                    //   onPressed: null,
                    //   style: ElevatedButton.styleFrom(
                    //     shape: const CircleBorder(),
                    //     backgroundColor: AppColors.blue,
                    //     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    //     padding: const EdgeInsets.all(0),
                    //     minimumSize: Size(24.r, 24.r),
                    //   ),
                    //   child: SizedBox(
                    //     height: 24.r,
                    //     width: 24.r,
                    //     child: Icon(
                    //       Icons.swap_vert,
                    //       size: 16.r,
                    //       color: AppColors.white,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
