import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:tien_duong/app/core/controllers/auth_controller.dart';
import 'package:tien_duong/app/core/services/animated_map_service.dart';
import 'package:tien_duong/app/core/values/app_values.dart';
import 'package:tien_duong/app/data/constants/notification_type.dart';
import 'package:tien_duong/app/data/models/package_model.dart';

class TrackingPackageController extends GetxController {
  Package package = Get.arguments as Package;

  final AuthController _authController = Get.find<AuthController>();

  LatLng? locationStart;
  LatLng? locationEnd;
  Rx<LatLng?> locationDeliver = Rx(null);

  LatLngBounds currentBounds = LatLngBounds();
  MapController? _mapController;
  AnimatedMapService? _animatedMapService;

  MapController? get mapController => _mapController;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() {
    locationStart = LatLng(package.startLatitude!, package.startLongitude!);
    locationEnd =
        LatLng(package.destinationLatitude!, package.destinationLongitude!);
    createBounds();
    onTracking();
  }

  void onMapCreated(MapController? mapController) {
    _mapController = mapController;
    _animatedMapService = AnimatedMapService(controller: _mapController!);
    gotoCurrentBound();
  }

  void gotoCurrentBound() {
    if (_animatedMapService != null) {
      _animatedMapService?.move(
          currentBounds.center, AppValues.overviewZoomLevel);
    }
  }

  void createBounds() {
    currentBounds = LatLngBounds(locationStart, locationEnd);
    gotoCurrentBound();
  }

  void onTracking() {
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification?.title == TypeOfNotification.TRACKING) {
        if (message.data['deliverId'] == package.deliverId) {
          locationDeliver.value = LatLng(
              double.parse(message.data['latitude']!),
              double.parse(message.data['longitude']!));
        }
      }
    });
  }
}
