import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:tien_duong/app/core/base/base_controller.dart';
import 'package:tien_duong/app/core/controllers/cw_map_controller.dart';
import 'package:tien_duong/app/core/utils/flutter_map_tapped_polyline.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/app_values.dart';
import 'package:tien_duong/app/data/models/route_model.dart';
import 'package:tien_duong/app/data/models/route_point_model.dart';
import 'package:tien_duong/app/data/repository/account_req.dart';
import 'package:tien_duong/app/data/repository/request_model/route_model/route_list_model.dart';

class RouteDetailController extends BaseController {
  CwMapController cwMapController = CwMapController();
  RouteAcc? route;
  LatLngBounds? bounds = LatLngBounds();
  // final RxList<RoutePoint> routePoints = <RoutePoint>[].obs;
  final RxList<RoutePoint> forwardPoints = <RoutePoint>[].obs;
  final RxList<RoutePoint> backwardPoints = <RoutePoint>[].obs;

  final AccountRep _accountRep = Get.find(tag: (AccountRep).toString());

  void onMapReady() {
    cwMapController.refreshCurrentLocation();
  }

  @override
  void onInit() {
    route = Get.arguments as RouteAcc;
    fetchRouteDetail();
    super.onInit();
  }

  Widget routesPolyline() {
    return Obx(
      () {
        List<TaggedPolyline> polylines = [];
        List<LatLng> forwardDirection = forwardPoints
            .map((element) => LatLng(element.latitude!, element.longitude!))
            .toList();
        List<LatLng> backwardDirection = backwardPoints
            .map((element) => LatLng(element.latitude!, element.longitude!))
            .toList();
        polylines.add(
          TaggedPolyline(
            color: AppColors.blue,
            borderColor: AppColors.blue,
            strokeWidth: 4.w,
            borderStrokeWidth: 3.w,
            points: forwardDirection,
          ),
        );
        polylines.add(
          TaggedPolyline(
            color: AppColors.gray,
            borderColor: AppColors.gray,
            strokeWidth: 4.w,
            borderStrokeWidth: 3.w,
            points: backwardDirection,
          ),
        );

        return CwPolyLineLayer(
          polylineCulling: true,
          polylines: polylines,
        );
      },
    );
  }

  Future<void> fetchRouteDetail() async {
    var future = _accountRep.getRoutePoints(route!.id!);
    callDataService<RouteListModel>(future, onSuccess: (response) {
      // routePoints.value = [];
      // routePoints(response);
      forwardPoints.value = [];
      backwardPoints.value = [];
      forwardPoints.value = response.forwardPoints!;
      backwardPoints.value = response.backwardPoints!;
      createBound();
    }, onError: showError);
  }

  void createBound() {
    bounds = LatLngBounds();
    bounds?.extend(LatLng(route!.fromLatitude!, route!.fromLongitude!));
    bounds?.extend(LatLng(route!.toLatitude!, route!.toLongitude!));
    cwMapController.centerZoomFitBounds(bounds!,
        zoom: AppValues.overviewZoomLevel);
  }
}
