import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:tien_duong/app/core/base/base_controller.dart';
import 'package:tien_duong/app/core/controllers/auth_controller.dart';
import 'package:tien_duong/app/core/controllers/cw_map_controller.dart';
import 'package:tien_duong/app/core/utils/flutter_map_tapped_polyline.dart';
import 'package:tien_duong/app/core/utils/toast_service.dart';
import 'package:tien_duong/app/core/values/app_assets.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/app_values.dart';
import 'package:tien_duong/app/data/models/polyline_model.dart';
import 'package:tien_duong/app/data/models/response_goong_model.dart';
import 'package:tien_duong/app/data/repository/account_req.dart';
import 'package:tien_duong/app/data/repository/goong_req.dart';
import 'package:tien_duong/app/data/repository/request_model/create_route_model.dart';
import 'package:tien_duong/app/data/repository/request_model/request_polyline_model.dart';
import 'package:tien_duong/app/data/repository/request_model/route_model/create_route_point_model.dart';

class SelectRouteController extends BaseController {
  AuthController authController = Get.find<AuthController>();
  CwMapController cwMapController = CwMapController();
  final RxList<PolylineModel> _polylines = <PolylineModel>[].obs;
  LatLngBounds? _bounds;
  final GoongReq _goongReq = Get.find(tag: (GoongReq).toString());
  final AccountRep _accountReq = Get.find(tag: (AccountRep).toString());

  final List<LatLng> _forwardRoutes = [];
  final List<LatLng> _backwardRoutes = [];

  final Rx<String> selectedRouteId = ''.obs;
  final RxInt currentStep = 0.obs;

  final TextEditingController startTxtController = TextEditingController();
  final TextEditingController endTxtController = TextEditingController();
  final RxDouble startLatitude = 0.0.obs;
  final RxDouble startLongitude = 0.0.obs;
  final RxDouble endLatitude = 0.0.obs;
  final RxDouble endLongitude = 0.0.obs;

  final RxBool isLoadingFetchPolyline = false.obs;

  @override
  void onInit() {
    fetchPolyline();
    super.onInit();
  }

  void onMapReady() async {
    await cwMapController.refreshCurrentLocation();
    createBound();
  }

  Widget routesPolyline() {
    return Obx(
      () {
        List<TaggedPolyline> polylines = [];

        for (var route in _polylines) {
          polylines.add(
            TaggedPolyline(
                color: selectedRouteId.value == route.id
                    ? AppColors.blue
                    : AppColors.gray,
                borderColor: selectedRouteId.value == route.id
                    ? AppColors.blue
                    : AppColors.gray,
                strokeWidth: 4.w,
                borderStrokeWidth: 3.w,
                points: route.polyPoints!,
                tag: route.id),
          );
        }

        return CwPolyLineLayer(
          polylineCulling: true,
          polylines: polylines,
          onTap: (p, tapPosition) {
            setSelectedRouteId(p[0].tag ?? '');
          },
        );
      },
    );
  }

  Widget markerLayer() {
    return Obx(
      () {
        List<Marker> markers = [];

        if (startLatitude.value != 0.0 && startLongitude.value != 0.0) {
          markers.add(
            Marker(
              width: 30.h,
              height: 30.h,
              point: LatLng(startLatitude.value, startLongitude.value),
              builder: (ctx) => SvgPicture.asset(
                AppAssets.locationIcon,
                height: 30.h,
                width: 30.h,
              ),
            ),
          );
        }

        if (endLatitude.value != 0.0 && endLongitude.value != 0.0) {
          markers.add(
            Marker(
              width: 30.h,
              height: 30.h,
              point: LatLng(endLatitude.value, endLongitude.value),
              builder: (ctx) => SvgPicture.asset(
                AppAssets.locationIcon,
                height: 30.h,
                width: 30.h,
              ),
            ),
          );
        }

        return MarkerLayer(markers: markers);
      },
    );
  }

  void setStartLocation(ResponseGoong response) {
    if (response.name != null &&
        response.latitude != null &&
        response.longitude != null) {
      startLatitude.value = response.latitude ?? 0.0;
      startLongitude.value = response.longitude ?? 0.0;
      startTxtController.text = response.name ?? '';
      createBound();
      fetchPolyline();
    }
  }

  void setEndLocation(ResponseGoong response) {
    if (response.name != null &&
        response.latitude != null &&
        response.longitude != null) {
      endLatitude.value = response.latitude ?? 0.0;
      endLongitude.value = response.longitude ?? 0.0;
      endTxtController.text = response.name ?? '';
      createBound();
      fetchPolyline();
    }
  }

  Widget selectedRoutePolyline() {
    return Obx(
      () {
        if (selectedRouteId.value.isEmpty) return Container();
        List<LatLng> activePolyline = _polylines
            .firstWhere((element) => element.id == selectedRouteId.value)
            .polyPoints!;
        List<TaggedPolyline> polylines = [];

        polylines.add(
          TaggedPolyline(
            color: AppColors.blue,
            borderColor: AppColors.blue,
            strokeWidth: 4.w,
            borderStrokeWidth: 3.w,
            points: activePolyline,
          ),
        );

        return CwPolyLineLayer(
          polylineCulling: true,
          polylines: polylines,
        );
      },
    );
  }

  void setSelectedRouteId(String id) {
    selectedRouteId.value = id;
    orderPolyline();
  }

  void orderPolyline() {
    _polylines.sort((a, b) => selectedRouteId.value == a.id ? 1 : -1);
  }

  Future<void> fetchPolyline() async {
    if (startLatitude.value != 0.0 &&
        startLongitude.value != 0.0 &&
        endLatitude.value != 0.0 &&
        endLongitude.value != 0.0) {
      _polylines.value = [];
      RequestPolylineModel model = RequestPolylineModel(
        from: Point(
            longitude: startLongitude.value, latitude: startLatitude.value),
        to: [Point(longitude: endLongitude.value, latitude: endLatitude.value)],
      );
      var future = _goongReq.getPolyline(model);
      callDataService<List<PolylineModel>>(future, onSuccess: (response) {
        _polylines.value = [];
        _polylines(response);
        setSelectedRouteId(_polylines.first.id ?? '');
      }, onStart: () {
        isLoadingFetchPolyline.value = true;
      }, onComplete: () {
        isLoadingFetchPolyline.value = false;
      });
    }
  }

  void createBound() {
    _bounds = LatLngBounds();
    LatLng? currentLocation = cwMapController.currentLocation;
    if (currentLocation != null) {
      _bounds!.extend(currentLocation);
    }
    if (startLatitude.value != 0.0 && startLongitude.value != 0.0) {
      _bounds!.extend(LatLng(startLatitude.value, startLongitude.value));
    }
    if (endLatitude.value != 0.0 && endLongitude.value != 0.0) {
      _bounds!.extend(LatLng(endLatitude.value, endLongitude.value));
    }
    if (_bounds?.isValid ?? false) {
      centerZoomFitBounds();
      cwMapController.centerZoomFitBounds(_bounds!,
          zoom: AppValues.overviewZoomLevel);
    }
  }

  void centerZoomFitBounds() {
    _bounds?.pad(0.4);
    LatLng? ne = _bounds?.northEast;
    LatLng? sw = _bounds?.southWest;
    final heightBuffer = (sw!.latitude - ne!.latitude).abs() * 2.2;
    sw = LatLng(sw.latitude - heightBuffer, sw.longitude);
    _bounds?.extend(sw);
  }

  void previousStep() {
    currentStep.value = currentStep.value - 1;
  }

  void nextStep() {
    if (currentStep.value == 0) {
      if (startLatitude.value == 0.0 || startLongitude.value == 0.0) {
        ToastService.showError('Điểm bắt đầu không hợp lệ');
        return;
      }
      if (endLatitude.value == 0.0 || endLongitude.value == 0.0) {
        ToastService.showError('Điểm kết thúc không hợp lệ');
        return;
      }
      PolylineModel selectedPolyline = _polylines
          .firstWhere((element) => element.id == selectedRouteId.value);
      if (selectedPolyline.polyPoints == null ||
          selectedPolyline.polyPoints!.isEmpty) {
        ToastService.showError('Không tìm thấy đường đi');
        return;
      }
      _forwardRoutes.addAll(selectedPolyline.polyPoints!);
      switchDirectionRoute();
    }
    currentStep.value = currentStep.value + 1;
  }

  Future<void> createRoute() async {
    PolylineModel selectedPolyline =
        _polylines.firstWhere((element) => element.id == selectedRouteId.value);
    _backwardRoutes.addAll(selectedPolyline.polyPoints!);
    List<CreateRoutePointModel> points = [];
    for (var i = 0; i < _forwardRoutes.length; i++) {
      CreateRoutePointModel pointForward = CreateRoutePointModel(
          latitude: _forwardRoutes[i].latitude,
          longitude: _forwardRoutes[i].longitude,
          index: i,
          directionType: DirectionType.forward);
      points.add(pointForward);
    }
    for (var i = 0; i < _backwardRoutes.length; i++) {
      CreateRoutePointModel pointBackward = CreateRoutePointModel(
          latitude: _backwardRoutes[i].latitude,
          longitude: _backwardRoutes[i].longitude,
          index: i,
          directionType: DirectionType.backward);
      points.add(pointBackward);
    }
    revertDirectionRoute();
    CreateRoute model = CreateRoute();
    model.fromName = startTxtController.text;
    model.toName = endTxtController.text;
    model.fromLatitude = startLatitude.value;
    model.fromLongitude = startLongitude.value;
    model.toLatitude = endLatitude.value;
    model.toLongitude = endLongitude.value;
    model.routePoints = points;
    model.accountId = authController.account!.id;

    var future = _accountReq.createRoute(model);
    callDataService(future, onSuccess: (response) async {
      ToastService.showSuccess('Tạo tuyến đường thành công');
      await authController.reloadAccount();
      Get.back(result: true);
    }, onComplete: () {
      isLoading = false;
    }, onStart: () {
      isLoading = true;
    });
  }

  void switchDirectionRoute() {
    LatLng temp = LatLng(startLatitude.value, startLongitude.value);
    startLatitude.value = endLatitude.value;
    startLongitude.value = endLongitude.value;
    endLatitude.value = temp.latitude;
    endLongitude.value = temp.longitude;

    createBound();
    fetchPolyline();
  }

  void revertDirectionRoute() {
    LatLng temp = LatLng(startLatitude.value, startLongitude.value);
    startLatitude.value = endLatitude.value;
    startLongitude.value = endLongitude.value;
    endLatitude.value = temp.latitude;
    endLongitude.value = temp.longitude;
  }
}
