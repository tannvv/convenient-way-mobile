import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:tien_duong/app/config/build_config.dart';
import 'package:tien_duong/app/core/values/app_values.dart';
import 'package:tien_duong/app/core/widgets/hyper_stack.dart';
import 'package:tien_duong/app/modules/location_package/controllers/location_package_controller.dart';
import 'package:tien_duong/app/modules/location_package/widgets/bottom.dart';

class ConvenientMap extends GetWidget<LocationPackageController> {
  const ConvenientMap({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: controller.cwMapController.mapController,
            options: MapOptions(
                interactiveFlags:
                    InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                center: AppValues.defaultLatLng,
                zoom: 10.5,
                minZoom: 9,
                maxZoom: 18.4,
                slideOnBoundaries: true,
                onMapReady: controller.onMapReady),
            children: [
              TileLayer(
                urlTemplate: BuildConfig.instance.mapConfig.mapboxUrlTemplate,
                additionalOptions: {
                  'access_token':
                      BuildConfig.instance.mapConfig.mapboxAccessToken,
                  'id': BuildConfig.instance.mapConfig.mapboxId,
                },
              ),
              Stack(
                children: [
                  controller.routesPolyline(),
                  // Obx(() => controller.pointPackages.isNotEmpty
                  //     ? MarkerLayerWidget(
                  //         options: MarkerLayerOptions(markers: [
                  //           for (int i = 0; i < controller.pointPackages.length; i++)
                  //             Marker(
                  //               height: 30.h,
                  //               width: 30.h,
                  //               point: controller.pointPackages[i].latLng!,
                  //               builder: (_) => Row(
                  //                 mainAxisSize: MainAxisSize.min,
                  //                 children: [
                  //                   SvgPicture.asset(
                  //                     controller.getAssetsWithType(
                  //                         controller.pointPackages[i].type!),
                  //                     width: 30.w,
                  //                     height: 30.h,
                  //                   ),
                  //                   Text((i + 1).toString())
                  //                 ],
                  //               ),
                  //             ),
                  //         ]),
                  //       )
                  //     : MarkerLayerWidget(options: MarkerLayerOptions(markers: []))),
                  controller.markerLayer(),
                  _currentLocationMarker(),
                ],
              )
            ],
          ),
          const Bottom(),
        ],
      ),
    );
  }

  Widget _currentLocationMarker() {
    return IgnorePointer(
      child: CurrentLocationLayer(
        positionStream: controller.cwMapController.geolocatorPositionStream(),
        style: LocationMarkerStyle(
          markerDirection: MarkerDirection.heading,
          showHeadingSector: false,
          markerSize: Size(40.h, 40.h),
          marker: Stack(
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 0),
                        blurRadius: 4,
                        spreadRadius: 0,
                        color: Colors.black.withOpacity(0.4),
                      ),
                    ],
                  ),
                  height: 26.h,
                  width: 26.w,
                  child: DefaultLocationMarker(
                    child: Container(
                      padding: EdgeInsets.only(bottom: 2.h),
                      child: const Center(
                        child: Icon(
                          Icons.navigation,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
