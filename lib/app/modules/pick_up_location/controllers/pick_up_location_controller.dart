import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:tien_duong/app/core/controllers/map_location_controller.dart';

class PickUpLocationController extends GetxController
    with GetTickerProviderStateMixin {
  final LatLng? requiredLocation = Get.arguments as LatLng?;
  final MapLocationController _mapLocationController =
      Get.find<MapLocationController>();
  MapController _mapController = MapController();
  late Rx<LatLng> centerLocation = Rx<LatLng>(LatLng(10, 100));

  StreamSubscription<MapEvent>? subscription;

  get mapController => _mapController;

  @override
  void onInit() {
    super.onInit();
    if (requiredLocation != null) {
      centerLocation.value = requiredLocation!;
    } else {
      if (_mapLocationController.location != null) {
        centerLocation.value = _mapLocationController.location!;
      }
    }
  }

  @override
  void onClose() {
    if (subscription != null) {
      subscription?.cancel();
    }
    super.onClose();
  }

  void onMapCreated(MapController controller) async {
    _mapController = controller;
    bool checkPermission = await _mapLocationController.getPermission();
    if (checkPermission) {
      _mapController.onReady.then((_) async {
        // bool isAcceptLocation = await _mapLocationController.loadLocation();
        // if (isAcceptLocation) {
        //   Position position = await Geolocator.getCurrentPosition();
        //   centerLocation.value = LatLng(position.latitude, position.longitude);
        //   _animatedMapMove(centerLocation.value, 12);
        // }
        // if (_mapLocationController.location != null) {
        //   _animatedMapMove(_mapLocationController.location!, 12);
        // }
        subscription = controller.mapEventStream.listen((MapEvent mapEvent) {
          if (mapEvent is MapEventMove) {
            centerLocation.value =
                LatLng(mapEvent.center.latitude, mapEvent.center.longitude);
          }
        });
      });
    }
  }

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    final latTween = Tween<double>(
        begin: _mapController.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: _mapController.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: _mapController.zoom, end: destZoom);
    var controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
    controller.addListener(() {
      _mapController.move(
        LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
        zoomTween.evaluate(animation),
      );
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });
    controller.forward();
  }

  void back() {
    Get.back(result: centerLocation.value);
  }
}
