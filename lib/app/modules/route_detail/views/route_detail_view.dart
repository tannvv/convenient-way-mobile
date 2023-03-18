import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:tien_duong/app/config/build_config.dart';

import '../controllers/route_detail_controller.dart';

class RouteDetailView extends GetView<RouteDetailController> {
  const RouteDetailView({Key? key}) : super(key: key);
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
              center: LatLng(10.841411, 106.809936),
              zoom: 9,
              minZoom: 3,
              maxZoom: 18.4,
              slideOnBoundaries: true,
              onMapReady: controller.onMapReady,
            ),
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
                children: [controller.routesPolyline()],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
