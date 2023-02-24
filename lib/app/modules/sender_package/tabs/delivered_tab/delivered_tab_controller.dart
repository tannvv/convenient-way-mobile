import 'package:get/get.dart';
import 'package:tien_duong/app/core/base/sender_tab_base_controller.dart';
import 'package:tien_duong/app/core/controllers/auth_controller.dart';
import 'package:tien_duong/app/core/utils/material_dialog_service.dart';
import 'package:tien_duong/app/core/utils/toast_service.dart';
import 'package:tien_duong/app/data/constants/package_status.dart';
import 'package:tien_duong/app/data/models/package_model.dart';
import 'package:tien_duong/app/data/repository/package_req.dart';
import 'package:tien_duong/app/data/repository/request_model/package_list_model.dart';
import 'package:tien_duong/app/data/repository/response_model/simple_response_model.dart';

class DeliveredTabController extends SenderTabBaseController<Package>
    with GetSingleTickerProviderStateMixin {
  final AuthController _authController = Get.find<AuthController>();
  final PackageReq _packageRepo = Get.find(tag: (PackageReq).toString());

  @override
  Future<void> fetchDataApi() async {
    PackageListModel requestModel = PackageListModel(
        senderId: _authController.account!.id,
        status: PackageStatus.DELIVERED,
        pageIndex: pageIndex,
        pageSize: pageSize);
    Future<List<Package>> future = _packageRepo.getList(requestModel);
    await callDataService<List<Package>>(future,
        onSuccess: onSuccess, onError: onError);
  }

  Future<void> confirmFailed(String packageId) async {}
  Future<void> confirmSuccess(String packageId) async {
    MaterialDialogService.showConfirmDialog(onConfirmTap: () {
      var future = _packageRepo.senderConfirmDeliverySuccess(packageId);
      callDataService<SimpleResponseModel>(
        future,
        onSuccess: (_) {
          ToastService.showSuccess('Xác nhận thành công');
        },
        onError: showError,
        onStart: showOverlay,
        onComplete: hideOverlay,
      );
    });
  }
}
