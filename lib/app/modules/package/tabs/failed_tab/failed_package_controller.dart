import 'package:tien_duong/app/core/base/base_paging_controller.dart';
import 'package:tien_duong/app/core/controllers/auth_controller.dart';
import 'package:tien_duong/app/data/constants/package_status.dart';
import 'package:tien_duong/app/data/models/package_model.dart';
import 'package:tien_duong/app/data/repository/package_req.dart';
import 'package:tien_duong/app/data/repository/request_model/package_list_model.dart';
import 'package:get/get.dart';

class FailedPackageController extends BasePagingController<Package>
    with GetSingleTickerProviderStateMixin {
  final PackageReq _packageRepo = Get.find(tag: (PackageReq).toString());

  @override
  void onInit() {
    super.onInit();
  }

  @override
  Future<void> fetchDataApi() async {
    PackageListModel requestModel = PackageListModel(
        deliverId: AuthController.instance.account!.id,
        status: PackageStatus.DELIVERY_FAILED,
        pageIndex: pageIndex,
        pageSize: pageSize);
    Future<List<Package>> future = _packageRepo.getList(requestModel);
    await callDataService<List<Package>>(future,
        onSuccess: onSuccess, onError: onError);
  }
}
