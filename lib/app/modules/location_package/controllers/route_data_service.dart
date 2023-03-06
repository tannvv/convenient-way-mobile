import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:tien_duong/app/data/models/polyline_model.dart';
import 'package:tien_duong/app/data/repository/goong_req.dart';
import 'package:tien_duong/app/data/repository/request_model/request_polyline_model';
import '../../../core/base/base_controller.dart';

class RouteDataService extends BaseController {
  // Loading
  final Rx<bool> _isLoading = Rx<bool>(false);
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) {
    _isLoading.value = value;
  }

  GoongReq _goongReq = Get.find(tag: (GoongReq).toString());
  // Routes
  final Rx<List<LatLng>> _routes = Rx<List<LatLng>>([]);
  List<LatLng> get routes => _routes.value;
  set routes(List<LatLng> value) {
    _routes.value = value;
  }

  RequestPolylineModel model = RequestPolylineModel(
      from: Point(latitude: 10.801466035130357, longitude: 106.81435493397935),
      to: [Point(latitude: 10.841229214985104, longitude: 106.80969642833857)]);

  Future<void> fetchRoutes() async {
    isLoading = true;
    var routesService = _goongReq.getPolyline(model);

    await callDataService(routesService,
        onSuccess: (List<PolylineModel> response) {
      routes = response[0].polyPoints!;
    }, onError: showError);
    isLoading = false;
  }
}
