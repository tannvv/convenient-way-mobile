import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:tien_duong/app/core/base/base_controller.dart';
import 'package:tien_duong/app/core/controllers/auth_controller.dart';
import 'package:tien_duong/app/core/utils/alert_quick_service.dart';
import 'package:tien_duong/app/core/utils/toast_service.dart';
import 'package:tien_duong/app/data/constants/account_status.dart';
import 'package:tien_duong/app/data/models/response_goong_model.dart';
import 'package:tien_duong/app/data/models/route_model.dart';
import 'package:tien_duong/app/data/repository/account_req.dart';
import 'package:tien_duong/app/data/repository/goong_req.dart';
import 'package:tien_duong/app/data/repository/request_model/create_route_model.dart';
import 'package:tien_duong/app/routes/app_pages.dart';

class CreateRouteController extends BaseController {
  final AuthController _authController = Get.find<AuthController>();

  final formKey = GlobalKey<FormState>();
  String _toName = '';
  final Rx<LatLng?> _toCoord = Rx<LatLng?>(null);
  String _fromName = '';
  final Rx<LatLng?> _fromCoord = Rx<LatLng?>(null);
  final TextEditingController homeController = TextEditingController();
  final TextEditingController workController = TextEditingController();

  final AccountRep _accountRepo = Get.find(tag: (AccountRep).toString());
  final GoongReq _goongRepo = Get.find(tag: (GoongReq).toString());

  set setToName(String value) => _toName = value;

  set setFromName(String value) => _fromName = value;
  set setToCoord(LatLng value) => _toCoord.value = value;
  set setFromCoord(LatLng value) => _fromCoord.value = value;

  LatLng? get fromCoord => _fromCoord.value;
  LatLng? get toCoord => _toCoord.value;

  Future<void> showMapPickUpFrom() async {
    final data =
        await Get.toNamed(Routes.PICK_UP_LOCATION, arguments: fromCoord);
    if (data != null) {
      _fromCoord.value = LatLng(data.latitude, data.longitude);
    }
  }

  Future<void> showMapPickUpTo() async {
    final data = await Get.toNamed(Routes.PICK_UP_LOCATION, arguments: toCoord);
    if (data != null) {
      _toCoord.value = LatLng(data.latitude, data.longitude);
    }
  }

  void updateFromLocation(ResponseGoong response) {
    _fromName = response.name ?? '';
    _fromCoord.value = LatLng(response.latitude!, response.longitude!);
  }

  void updateToLocation(ResponseGoong response) {
    _toName = response.name ?? '';
    _toCoord.value = LatLng(response.latitude!, response.longitude!);
  }

  Future<List<ResponseGoong>> queryLocation(String query) async {
    return _goongRepo.getList(query);
  }

  void back() {
    Get.back(result: false);
  }

  Future<void> registerRoute() async {
    String accountId = _authController.account!.id!;
    if (_fromCoord.value == null ||
        _toCoord.value == null ||
        _fromName == '' ||
        _toName == '') {
      ToastService.showError('Vui lòng chọn nhập vị trí');
      return;
    }
    CreateRoute createRouteModel = CreateRoute(
        fromName: _fromName,
        fromLongitude: _fromCoord.value!.longitude,
        fromLatitude: _fromCoord.value!.latitude,
        toName: _toName,
        toLongitude: _toCoord.value!.longitude,
        toLatitude: _toCoord.value!.latitude,
        accountId: accountId);
    final future = _accountRepo.createRoute(createRouteModel);
    await callDataService<RouteAcc?>(future, onSuccess: (newRoute) async {
      if (newRoute != null) {
        _authController.account!.infoUser!.routes!.add(newRoute);
        _authController.account!.status = AccountStatus.active;
        _authController.setDataPrefs();
        await QuickAlertService.showSuccess(
            'Bạn đã đăng kí tuyến đường thành công',
            duration: 3);
        Get.back(result: true);
      } else {
        ToastService.showError('Lỗi không xác định');
      }
    }, onError: showError);
  }
}
