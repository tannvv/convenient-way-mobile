import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:tien_duong/app/core/base/base_controller.dart';
import 'package:tien_duong/app/core/controllers/auth_controller.dart';
import 'package:tien_duong/app/core/controllers/cw_map_controller.dart';
import 'package:tien_duong/app/core/utils/location_utils.dart';
import 'package:tien_duong/app/core/values/app_assets.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/data/constants/package_status.dart';
import 'package:tien_duong/app/data/models/package_model.dart';
import 'package:tien_duong/app/data/models/polyline_model.dart';
import 'package:tien_duong/app/data/models/route_model.dart';
import 'package:tien_duong/app/data/repository/goong_req.dart';
import 'package:tien_duong/app/data/repository/package_req.dart';
import 'package:tien_duong/app/data/repository/request_model/package_list_model.dart';
import 'package:tien_duong/app/data/repository/request_model/request_polyline_model.dart';
import 'package:tien_duong/app/modules/location_package/models/point_package.dart';

class LocationPackageController extends BaseController {
  final AuthController _authController = Get.find<AuthController>();
  final CwMapController cwMapController = CwMapController();
  final RxList<Package> packages = <Package>[].obs;
  LatLngBounds currentBounds = LatLngBounds();
  RxList<PointPackage> pointPackages = <PointPackage>[].obs;
  // RxList<Polyline> polylines = <Polyline>[].obs;
  final RxList<LatLng> _routes = <LatLng>[].obs;

  final PackageReq _packageReq = Get.find(tag: (PackageReq).toString());
  final GoongReq _goongReq = Get.find(tag: (GoongReq).toString());

  @override
  void onInit() {
    fetchPackages();
    super.onInit();
  }

  Widget routesPolyline() {
    return Obx(
      () {
        List<Polyline> polylines = [];

        polylines.add(
          Polyline(
            color: AppColors.blue,
            borderColor: AppColors.blue,
            strokeWidth: 4,
            borderStrokeWidth: 3,
            points: _routes,
          ),
        );

        return PolylineLayer(
          polylineCulling: true,
          // saveLayers: true,
          polylines: polylines,
        );
      },
    );
  }

  Widget markerLayer() {
    return Obx(() {
      List<Marker> markers = [];

      for (var i = 0; i < pointPackages.length; i++) {
        markers.add(
          Marker(
            height: 30.h,
            width: 30.h,
            point: pointPackages[i].latLng!,
            builder: (_) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  getAssetsWithType(pointPackages[i].type!),
                  width: 30.w,
                  height: 30.h,
                ),
                Text((i + 1).toString())
              ],
            ),
          ),
        );
      }
      return MarkerLayer(
        markers: markers,
      );
    });
  }

  void onMapReady() async {
    await cwMapController.refreshCurrentLocation();
    createBounds();
  }

  void centerZoomFitBounds() {
    currentBounds.pad(0.4);
    LatLng? ne = currentBounds.northEast;
    LatLng? sw = currentBounds.southWest;
    final heightBuffer = (sw!.latitude - ne!.latitude).abs() * 0.8;
    sw = LatLng(sw.latitude - heightBuffer, sw.longitude);
    currentBounds.extend(sw);
    gotoCurrentBound();
  }

  Future<void> fetchPackages() async {
    if (_authController.account == null) return;
    String deliverId = _authController.account!.id!;
    PackageListModel model = PackageListModel(
      deliverId: deliverId,
      status: '${PackageStatus.SELECTED},${PackageStatus.PICKUP_SUCCESS}',
    );
    var future = _packageReq.getList(model);
    await callDataService<List<Package>>(
      future,
      onSuccess: (response) async {
        packages(response);
        pointPackages.value = getPointPackage(packages);
        getPolyLine();
      },
      onError: showError,
    );
  }

  Future<void> createBounds() async {
    currentBounds = LatLngBounds();
    LatLng? currentPosition = cwMapController.currentLocation;
    if (currentPosition != null) {
      currentBounds.extend(currentPosition);
    }

    for (var package in packages) {
      LatLng packagePosition = LatLng(
        package.startLatitude!,
        package.startLongitude!,
      );
      LatLng packageEndPosition = LatLng(
        package.destinationLatitude!,
        package.destinationLongitude!,
      );
      currentBounds.extend(packagePosition);
      currentBounds.extend(packageEndPosition);
    }
    RouteAcc? activeRoute = _authController.account?.infoUser?.routes
        ?.firstWhereOrNull((element) => element.isActive == true);
    if (activeRoute != null) {
      LatLng routeStart =
          LatLng(activeRoute.fromLatitude!, activeRoute.fromLongitude!);
      LatLng routeEnd =
          LatLng(activeRoute.toLatitude!, activeRoute.toLongitude!);
      currentBounds.extend(routeStart);
      currentBounds.extend(routeEnd);
    }
    // gotoCurrentLocation();
    centerZoomFitBounds();
  }

  LatLng getLatLngWithStatus(Package package) {
    if (package.status == PackageStatus.SELECTED) {
      return LatLng(package.startLatitude!, package.startLongitude!);
    } else if (package.status == PackageStatus.PICKUP_SUCCESS) {
      return LatLng(
          package.destinationLatitude!, package.destinationLongitude!);
    } else if (package.status == PackageStatus.PICKUP_SUCCESS) {
      return LatLng(package.startLatitude!, package.startLongitude!);
    }
    return LatLng(package.startLatitude!, package.startLongitude!);
  }

  String getAssetsWithStatus(Package package) {
    if (package.status == PackageStatus.PICKUP_SUCCESS) {
      return AppAssets.locationIcon;
    } else if (package.status == PackageStatus.PICKUP_SUCCESS) {
      return AppAssets.locationGreenIcon;
    } else if (package.status == PackageStatus.DELIVERED_FAILED) {
      return AppAssets.locationBlueIcon2;
    }
    return 'assets/images/pickup.png';
  }

  String getAssetsWithType(String type) {
    if (type == 'deliver') {
      return AppAssets.locationIcon;
    } else if (type == 'delivery') {
      return AppAssets.locationGreenIcon;
    } else if (type == 'pickup') {
      return AppAssets.locationBlueIcon2;
    }
    return 'assets/images/pickup.png';
  }

  void gotoCurrentBound() {
    cwMapController.centerZoomFitBounds(currentBounds);
  }

  List<PointPackage> getPointPackage(List<Package> packages) {
    List<PointPackage> result = [];
    RouteAcc? activeRoute = _authController.account?.infoUser?.routes
        ?.firstWhereOrNull((element) => element.isActive == true);
    if (activeRoute == null) return [];
    LatLng startLocation =
        LatLng(activeRoute.fromLatitude!, activeRoute.fromLongitude!);
    LatLng endLocation =
        LatLng(activeRoute.toLatitude!, activeRoute.toLongitude!);
    List<Package> forwardDirection = [];
    List<Package> backwardDirection = [];
    for (var package in packages) {
      LatLng packageStart =
          LatLng(package.startLatitude!, package.startLongitude!);
      LatLng packageEnd =
          LatLng(package.destinationLatitude!, package.destinationLongitude!);
      double calculateDistanceStart =
          LocationUtils.calculateDistance2(startLocation, packageStart);
      double calculateDistanceEnd =
          LocationUtils.calculateDistance2(startLocation, packageEnd);
      if (calculateDistanceStart < calculateDistanceEnd) {
        forwardDirection.add(package);
      } else {
        backwardDirection.add(package);
      }
    }
    int index = 0;
    PointPackage deliverStartPoint = PointPackage(
        type: 'deliver',
        index: index,
        latLng: startLocation,
        name: activeRoute.fromName);
    index++;
    result.add(deliverStartPoint);
    List<PointPackage> forwardPoint = [];
    for (var package in forwardDirection) {
      PointPackage pointPackage = PointPackage(
          type: 'pickup',
          index: index,
          latLng: LatLng(package.startLatitude!, package.startLongitude!),
          name: package.startAddress,
          package: package);
      index++;
      forwardPoint.add(pointPackage);
      PointPackage pointPackage2 = PointPackage(
          type: 'delivery',
          index: index,
          latLng: LatLng(
              package.destinationLatitude!, package.destinationLongitude!),
          name: package.destinationAddress,
          package: package);
      index++;
      forwardPoint.add(pointPackage2);
    }
    forwardPoint.sort((point1, point2) {
      double distancePoint1 =
          LocationUtils.calculateDistance2(startLocation, point1.latLng!);
      double distancePoint2 =
          LocationUtils.calculateDistance2(startLocation, point2.latLng!);
      if (distancePoint1 == distancePoint2) return 0;
      return distancePoint1 > distancePoint2 ? 1 : -1;
    });
    result.addAll(forwardPoint);

    PointPackage deliverEndPoint = PointPackage(
        type: 'deliver',
        index: index,
        latLng: endLocation,
        name: activeRoute.toName);
    index++;
    result.add(deliverEndPoint);

    List<PointPackage> backwardPoint = [];
    for (var package in backwardDirection) {
      PointPackage pointPackage = PointPackage(
          type: 'pickup',
          index: index,
          latLng: LatLng(package.startLatitude!, package.startLongitude!),
          name: package.startAddress,
          package: package);
      index++;
      backwardPoint.add(pointPackage);
      PointPackage pointPackage2 = PointPackage(
          type: 'delivery',
          index: index,
          latLng: LatLng(
              package.destinationLatitude!, package.destinationLongitude!),
          name: package.destinationAddress,
          package: package);
      index++;
      backwardPoint.add(pointPackage2);
    }
    backwardPoint.sort((point1, point2) {
      double distancePoint1 =
          LocationUtils.calculateDistance2(startLocation, point1.latLng!);
      double distancePoint2 =
          LocationUtils.calculateDistance2(startLocation, point2.latLng!);
      if (distancePoint1 == distancePoint2) return 0;
      return distancePoint1 > distancePoint2 ? -1 : 1;
    });

    result.addAll(backwardPoint);

    return result;
  }

  void getPolyLine() {
    if (pointPackages.isEmpty) return;
    RequestPolylineModel model = RequestPolylineModel();
    model.to = [];
    for (var i = 0; i < pointPackages.length; i++) {
      if (i == 0) {
        Point startPoint = Point();
        startPoint.latitude = pointPackages[i].latLng!.latitude;
        startPoint.longitude = pointPackages[i].latLng!.longitude;
        model.from = startPoint;
      } else {
        Point endPoint = Point();
        endPoint.latitude = pointPackages[i].latLng!.latitude;
        endPoint.longitude = pointPackages[i].latLng!.longitude;
        model.to?.add(endPoint);
      }
    }
    var future = _goongReq.getPolyline(model);
    callDataService<List<PolylineModel>>(future, onSuccess: (response) {
      _routes.value = response[0].polyPoints!;
    }, onError: showError);
  }
}
