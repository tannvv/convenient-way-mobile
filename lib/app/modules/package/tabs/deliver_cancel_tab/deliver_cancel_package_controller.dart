import 'package:get/get.dart';
import 'package:tien_duong/app/core/base/base_paging_controller.dart';
import 'package:tien_duong/app/core/controllers/auth_controller.dart';
import 'package:tien_duong/app/data/constants/package_status.dart';
import 'package:tien_duong/app/data/models/package_cancel_model.dart';
import 'package:tien_duong/app/data/repository/package_req.dart';
import 'package:tien_duong/app/data/repository/request_model/package_cancel_list_model.dart';

class DeliverCancelPackageController extends BasePagingController<PackageCancel>
    with GetSingleTickerProviderStateMixin {
  final AuthController _authController = Get.find<AuthController>();
  final PackageReq _packageRepo = Get.find(tag: (PackageReq).toString());

  @override
  Future<void> fetchDataApi() async {
    PackageCancelListModel requestModel = PackageCancelListModel(
        deliverId: _authController.account!.id,
        status: PackageStatus.DELIVER_CANCEL,
        pageIndex: pageIndex,
        pageSize: pageSize);
    Future<List<PackageCancel>> future =
        _packageRepo.getListCancelReason(requestModel);
    await callDataService<List<PackageCancel>>(future,
        onSuccess: onSuccess, onError: onError);
  }
}
