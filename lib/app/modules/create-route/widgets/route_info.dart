import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/widgets/hyper_shape.dart';
import 'package:tien_duong/app/data/models/response_goong_model.dart';
import 'package:tien_duong/app/modules/create-route/controllers/create_route_controller.dart';
import 'package:tien_duong/app/modules/create-route/widgets/place_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class RouteInfo extends GetWidget<CreateRouteController> {
  const RouteInfo({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
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
                          PlaceField(
                            enable: true,
                            hintText: 'Nhập điểm đi',
                            labelText: 'Điểm đi',
                            onSelected: _onSelectHome,
                            textController: controller.startLocationController,
                          ),
                          PlaceField(
                            enable: true,
                            hintText: 'Nhập điểm đến',
                            labelText: 'Điểm đến',
                            onSelected: _onSelectWork,
                            textController: controller.endLocationController,
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
                        minimumSize: Size(40.r, 40.r),
                      ),
                      child: SizedBox(
                        height: 40.r,
                        width: 40.r,
                        child: Icon(
                          Icons.swap_vert,
                          size: 23.r,
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
    );
  }

  void _onSelectHome(ResponseGoong suggestion) {
    controller.setFromName = suggestion.name ?? '';
    LatLng coord = LatLng(suggestion.latitude ?? 0, suggestion.longitude ?? 0);
    controller.setFromCoord = coord;
  }

  void _onSelectWork(ResponseGoong suggestion) {
    controller.setToName = suggestion.name ?? '';
    LatLng coord = LatLng(suggestion.latitude ?? 0, suggestion.longitude ?? 0);
    controller.setToCoord = coord;
  }
}
