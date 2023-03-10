import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:tien_duong/app/core/base/base_controller.dart';
import 'package:tien_duong/app/core/controllers/auth_controller.dart';
import 'package:tien_duong/app/core/controllers/map_location_controller.dart';
import 'package:tien_duong/app/core/services/animated_map_service.dart';
import 'package:tien_duong/app/core/utils/toast_service.dart';
import 'package:tien_duong/app/core/values/app_assets.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/app_values.dart';
import 'package:tien_duong/app/data/constants/package_status.dart';
import 'package:tien_duong/app/data/models/package_model.dart';
import 'package:tien_duong/app/data/repository/package_req.dart';
import 'package:tien_duong/app/data/repository/request_model/package_list_model.dart';
import 'package:tien_duong/app/modules/location_package/controllers/route_data_service.dart';
import 'package:tien_duong/app/network/exceptions/base_exception.dart';

class LocationPackageController extends BaseController {
  final AuthController _authController = Get.find<AuthController>();
  late AnimatedMapService _animatedMapService;
  final MapLocationController _mapLocationController =
      Get.find<MapLocationController>();
  final RxList<Package> packages = <Package>[].obs;
  LatLngBounds currentBounds = LatLngBounds();
  RouteDataService routeDataService = RouteDataService();

  final PackageReq _packageReq = Get.find(tag: (PackageReq).toString());

  @override
  void onInit() {
    routeDataService.fetchRoutes();
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
            points: routeDataService.routes ?? [],
          ),
        );

        return PolylineLayerWidget(
            options: PolylineLayerOptions(
                polylineCulling: true,
                saveLayers: true,
                polylines: polylines
            )
        );
      },
    );
  }

  void onMapCreated(MapController controller) {
    _animatedMapService = AnimatedMapService(controller: controller);
    if (packages.isNotEmpty) {
      gotoCurrentBound();
    } else {
      gotoCurrentLocation();
    }
  }

  void gotoCurrentLocation() {
    if (_mapLocationController.location != null) {
      LatLng currentLocation = _mapLocationController.location!;
      _animatedMapService.move(currentLocation, AppValues.focusZoomLevel);
    }
  }

  Future<void> fetchPackages() async {
    if (_authController.account == null) return;
    String deliverId = _authController.account!.id!;
    PackageListModel model = PackageListModel(
      deliverId: deliverId,
      status:
          '${PackageStatus.DELIVER_PICKUP},${PackageStatus.DELIVERY},${PackageStatus.DELIVERY_FAILED}',
    );
    var future = _packageReq.getList(model);
    await callDataService<List<Package>>(
      future,
      onSuccess: (response) async {
        packages(response);
        await createBounds();
      },
      onError: (exception) {
        if (exception is BaseException) {
          ToastService.showError(exception.message);
        }
      },
    );
  }

  Future<void> createBounds() async {
    await _mapLocationController.loadLocation();
    LatLng currentPosition = _mapLocationController.location!;
    currentBounds.extend(currentPosition);

    for (var package in packages) {
      if (package.status == PackageStatus.DELIVER_PICKUP) {
        LatLng packagePosition = LatLng(
          package.startLatitude!,
          package.startLongitude!,
        );
        currentBounds.extend(packagePosition);
      } else if (package.status == PackageStatus.DELIVERY) {
        LatLng packagePosition = LatLng(
          package.destinationLatitude!,
          package.destinationLongitude!,
        );
        currentBounds.extend(packagePosition);
      } else if (package.status == PackageStatus.DELIVERY_FAILED) {
        LatLng packagePosition = LatLng(
          package.startLatitude!,
          package.startLongitude!,
        );
        currentBounds.extend(packagePosition);
      }
    }
    currentBounds.pad(0.2);
  }

  LatLng getLatLngWithStatus(Package package) {
    if (package.status == PackageStatus.DELIVER_PICKUP) {
      return LatLng(package.startLatitude!, package.startLongitude!);
    } else if (package.status == PackageStatus.DELIVERY) {
      return LatLng(
          package.destinationLatitude!, package.destinationLongitude!);
    } else if (package.status == PackageStatus.DELIVERY_FAILED) {
      return LatLng(package.startLatitude!, package.startLongitude!);
    }
    return LatLng(package.startLatitude!, package.startLongitude!);
  }

  String getAssetsWithStatus(Package package) {
    if (package.status == PackageStatus.DELIVER_PICKUP) {
      return AppAssets.locationIcon;
    } else if (package.status == PackageStatus.DELIVERY) {
      return AppAssets.locationGreenIcon;
    } else if (package.status == PackageStatus.DELIVERY_FAILED) {
      return AppAssets.locationBlueIcon2;
    }
    return 'assets/images/pickup.png';
  }

  void gotoCurrentBound() {
    _animatedMapService.move(currentBounds.center, AppValues.overviewZoomLevel);
  }
}
