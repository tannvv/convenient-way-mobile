import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:tien_duong/app/config/build_config.dart';
import 'package:tien_duong/app/core/values/app_assets.dart';
import 'package:tien_duong/app/core/widgets/hyper_stack.dart';

import '../controllers/tracking_package_controller.dart';

class TrackingPackageView extends GetView<TrackingPackageController> {
  const TrackingPackageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final markerSize = 30.w;
    return HyperStack(
      children: [
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
}
