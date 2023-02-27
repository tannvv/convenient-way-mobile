import 'package:get/get.dart';
import 'package:tien_duong/app/core/base/base_paging_controller.dart';
import 'package:tien_duong/app/core/controllers/auth_controller.dart';
import 'package:tien_duong/app/core/controllers/pickup_file_controller.dart';
import 'package:tien_duong/app/core/utils/material_dialog_service.dart';
import 'package:tien_duong/app/core/utils/toast_service.dart';
import 'package:tien_duong/app/data/constants/package_status.dart';
import 'package:tien_duong/app/data/models/package_model.dart';
import 'package:tien_duong/app/data/repository/package_req.dart';
import 'package:tien_duong/app/data/repository/request_model/package_list_model.dart';
import 'package:tien_duong/app/data/repository/response_model/simple_response_model.dart';
import 'package:tien_duong/app/network/exceptions/base_exception.dart';

class DeliveryPackageController extends BasePagingController<Package>
    with GetSingleTickerProviderStateMixin {
  final AuthController _authController = Get.find<AuthController>();
  final PackageReq _packageRepo = Get.find(tag: (PackageReq).toString());
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> accountDeliveredPackage(String packageId) async {
    if (await PickUpFileController().scanQR() == packageId) {
      Future<SimpleResponseModel> future =
          _packageRepo.deliverySuccess(packageId);
      await callDataService<SimpleResponseModel>(future, onSuccess: (response) {
        ToastService.showSuccess(response.message ?? 'Thành công');
        refreshController.requestRefresh();
      }, onError: (exception) {
        if (exception is BaseException) {
          ToastService.showError(exception.message);
        }
      });
    } else {
      ToastService.showError('QR Code không đúng vui lòng kiểm tra lại!');
      // MaterialDialogService.showConfirmDialog(
      //     msg: 'QR Code không đúng vui lòng kiểm tra lại!',
      //     onConfirmTap: () async {
      //       Get.back();
      //       onRefresh();
      //       _authController.reloadAccount();
      //     }).catchError((error) {
      //   Get.back();
      //  ToastService.showError(error.messages[0]);
      // }
      // );
    }
  }

  @override
  Future<void> fetchDataApi() async {
    PackageListModel requestModel = PackageListModel(
        deliverId: _authController.account!.id, status: PackageStatus.DELIVERY);
    Future<List<Package>> future = _packageRepo.getList(requestModel);
    await callDataService<List<Package>>(future,
        onSuccess: onSuccess, onError: onError);
  }
}
