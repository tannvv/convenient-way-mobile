import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:tien_duong/app/config/build_config.dart';
import 'package:tien_duong/app/core/values/app_assets.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/widgets/hyper_stack.dart';

import '../controllers/tracking_package_controller.dart';

class TrackingPackageView extends GetView<TrackingPackageController> {
  const TrackingPackageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final markerSize = 30.w;
    return HyperStack(
      children: [
        _buildBackButton(),
        FlutterMap(
          mapController: controller.mapController,
          options: MapOptions(
              interactiveFlags:
                  InteractiveFlag.pinchZoom | InteractiveFlag.drag,
              zoom: 10.5,
              minZoom: 10.5,
              maxZoom: 18.4,
              slideOnBoundaries: true,
              onMapCreated: controller.onMapCreated),
          children: [
            TileLayerWidget(
              options: TileLayerOptions(
                urlTemplate: BuildConfig.instance.mapConfig.mapboxUrlTemplate,
                additionalOptions: {
                  'access_token':
                      BuildConfig.instance.mapConfig.mapboxAccessToken,
                  'id': BuildConfig.instance.mapConfig.mapboxId,
                },
              ),
            ),
            Obx(
              () => MarkerLayerWidget(
                  options: MarkerLayerOptions(markers: [
                if (controller.locationStart != null)
                  Marker(
                      height: markerSize,
                      width: markerSize,
                      point: controller.locationStart!,
                      builder: (_) => SvgPicture.asset(AppAssets.locationIcon)),
                if (controller.locationEnd != null)
                  Marker(
                      height: markerSize,
                      width: markerSize,
                      point: controller.locationEnd!,
                      builder: (_) => SvgPicture.asset(AppAssets.locationIcon)),
                if (controller.locationDeliver.value != null)
                  Marker(
                      height: markerSize,
                      width: markerSize,
                      point: controller.locationDeliver.value!,
                      builder: (_) => SvgPicture.asset(AppAssets.motorcycle)),
              ])),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBackButton() {
    return Positioned(
      top: 40.h,
      left: 40.w,
      child: Container(
        padding: EdgeInsets.only(
          top: 10.h,
          left: 20.w,
        ),
        child: Row(
          children: [
            ElevatedButton(
              onPressed: () async {
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: AppColors.white,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: const EdgeInsets.all(0),
                minimumSize: Size(34.r, 34.r),
              ),
              child: SizedBox(
                height: 30.r,
                width: 30.r,
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 18.r,
                  color: AppColors.primary400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
