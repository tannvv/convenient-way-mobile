import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/widgets/hyper_shape.dart';
import 'package:tien_duong/app/core/widgets/place_field_default.dart';
import 'package:tien_duong/app/modules/manage_route/controllers/manage_route_controller.dart';
import 'package:tien_duong/app/modules/manage_route/widgets/place_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RouteInfo extends GetWidget<ManageRouteController> {
  const RouteInfo({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: EdgeInsets.only(
            top: controller.routes[index].isActive == true ? 0 : 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                              PlaceFieldDefault(
                                enable: controller.isEditField(index),
                                labelText: 'Điểm đi',
                                hintText:
                                    controller.routes[index].fromName ?? '',
                                // onClear: () {
                                //   controller.routes[index].fromName = '';
                                //   controller.routes[index].fromLatitude = 0;
                                //   controller.routes[index].fromLongitude = 0;
                                // },
                                onSelected: controller.updateFromLocation,
                              ),
                              PlaceFieldDefault(
                                labelText: 'Điểm đến',
                                enable: controller.isEditField(index),
                                onSelected: controller.updateToLocation,
                                hintText: controller.routes[index].toName ?? '',
                                // onClear: () {
                                //   controller.routes[index].toName = '';
                                //   controller.routes[index].toLatitude = 0;
                                //   controller.routes[index].toLongitude = 0;
                                // },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 5.w),
                        ElevatedButton(
                          onPressed: null,
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            backgroundColor: AppColors.blue,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            padding: const EdgeInsets.all(0),
                            minimumSize: Size(24.r, 24.r),
                          ),
                          child: SizedBox(
                            height: 24.r,
                            width: 24.r,
                            child: Icon(
                              Icons.swap_vert,
                              size: 16.r,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
