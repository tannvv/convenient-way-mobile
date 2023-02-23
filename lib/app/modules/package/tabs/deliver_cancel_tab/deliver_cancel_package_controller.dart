import 'package:tien_duong/app/core/base/base_paging_controller.dart';
import 'package:tien_duong/app/core/controllers/auth_controller.dart';
import 'package:tien_duong/app/data/repository/package_req.dart';
import 'package:tien_duong/app/data/repository/request_model/package_cancel_list_model.dart';
import 'package:tien_duong/app/data/repository/request_model/package_cancel_model.dart';
import 'package:get/get.dart';

class DeliverCancelPackageController extends BasePagingController<PackageCancelListModel>
    with GetSingleTickerProviderStateMixin {
  final AuthController _authController = Get.find<AuthController>();
  final PackageReq _packageRepo = Get.find(tag: (PackageReq).toString());

  @override
  Future<void> fetchDataApi() async {
    CancelModel requestModel = CancelModel(
        deliverId: _authController.account!.id,
        pageIndex: pageIndex,
        pageSize: pageSize);
    Future<List<PackageCancelListModel>> future = _packageRepo.getListCancel(requestModel);
    await callDataService<List<PackageCancelListModel>>(future,
        onSuccess: onSuccess, onError: onError);
  }
}