import 'package:get/get.dart';
import 'package:tien_duong/app/core/base/base_paging_controller.dart';
import 'package:tien_duong/app/core/controllers/auth_controller.dart';
import 'package:tien_duong/app/core/utils/motion_toast_service.dart';
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
    Future<SimpleResponseModel> future =
        _packageRepo.deliverySuccess(packageId);
    await callDataService<SimpleResponseModel>(future, onSuccess: (response) {
      MotionToastService.showSuccess(response.message ?? 'Thành công');
      refreshController.requestRefresh();
    }, onError: (exception) {
      if (exception is BaseException) {
        MotionToastService.showError(exception.message);
      }
    });
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
