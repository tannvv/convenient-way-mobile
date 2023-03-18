import 'package:get/get.dart';
import 'package:tien_duong/app/core/base/base_paging_controller.dart';
import 'package:tien_duong/app/core/controllers/auth_controller.dart';
import 'package:tien_duong/app/core/utils/material_dialog_service.dart';
import 'package:tien_duong/app/core/utils/toast_service.dart';
import 'package:tien_duong/app/data/constants/package_status.dart';
import 'package:tien_duong/app/data/models/package_model.dart';
import 'package:tien_duong/app/data/repository/package_req.dart';
import 'package:tien_duong/app/data/repository/request_model/package_list_model.dart';
import 'package:tien_duong/app/data/repository/response_model/simple_response_model.dart';

class DeliveredFailedTabController extends BasePagingController<Package>
    with GetSingleTickerProviderStateMixin {
  final AuthController _authController = Get.find<AuthController>();
  final PackageReq _packageRepo = Get.find(tag: (PackageReq).toString());

  @override
  Future<void> fetchDataApi() async {
    PackageListModel requestModel = PackageListModel(
        deliverId: _authController.account!.id,
        status: PackageStatus.DELIVERED_FAILED);
    Future<List<Package>> future = _packageRepo.getList(requestModel);
    await callDataService<List<Package>>(future,
        onSuccess: onSuccess, onError: onError);
  }

  Future<void> refundPackageSuccess(String packageId) async {
    MaterialDialogService.showConfirmDialog(
        msg: 'Bạn xác nhận hoàn trả thành công cho đơn hàng này',
        closeOnFinish: false,
        onConfirmTap: () async {
          var future = _packageRepo.refundSuccess(packageId);
          await callDataService<SimpleResponseModel>(future,
              onSuccess: (response) {
            ToastService.showSuccess('Hoàn trả thành công');
          }, onError: onError, onStart: showOverlay, onComplete: hideOverlay);
        });
  }

  Future<void> refundPackageFailed(String packageId) async {
    MaterialDialogService.showConfirmDialog(
        msg:
            'Bạn xác nhận hoàn trả thất bại cho đơn hàng này, hệ thống sẽ ghi nhận và sẽ xử lí vật lí',
        closeOnFinish: false,
        onConfirmTap: () async {
          var future = _packageRepo.refundFailed(packageId);
          await callDataService<SimpleResponseModel>(future,
              onSuccess: (response) {
            ToastService.showSuccess('Hoàn trả thất bại');
          }, onError: onError, onStart: showOverlay, onComplete: hideOverlay);
        });
  }
}
