import 'package:get/get.dart';
import 'package:tien_duong/app/core/base/sender_tab_base_controller.dart';
import 'package:tien_duong/app/core/controllers/auth_controller.dart';
import 'package:tien_duong/app/data/constants/package_status.dart';
import 'package:tien_duong/app/data/models/package_cancel_model.dart';
import 'package:tien_duong/app/data/repository/package_req.dart';
import 'package:tien_duong/app/data/repository/request_model/package_cancel_list_model.dart';

class SenderCancelTabController extends SenderTabBaseController<PackageCancel>
    with GetSingleTickerProviderStateMixin {
  final AuthController _authController = Get.find<AuthController>();
  final PackageReq _packageRepo = Get.find(tag: (PackageReq).toString());

  @override
  Future<void> fetchDataApi() async {
    PackageCancelListModel requestModel = PackageCancelListModel(
        senderId: _authController.account!.id,
        status: PackageStatus.SENDER_CANCEL,
        pageIndex: pageIndex,
        pageSize: pageSize);
    Future<List<PackageCancel>> future =
        _packageRepo.getListCancelReason(requestModel);
    await callDataService<List<PackageCancel>>(future,
        onSuccess: onSuccess, onError: onError);
  }

  Future<void> reCreate(PackageCancel package) async {
    await reCreatePackage(package);
  }
}
