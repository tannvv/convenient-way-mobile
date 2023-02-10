import 'package:tien_duong/app/core/base/base_paging_controller.dart';
import 'package:tien_duong/app/core/controllers/auth_controller.dart';
import 'package:tien_duong/app/data/models/package_model.dart';
import 'package:tien_duong/app/data/repository/package_req.dart';
import 'package:tien_duong/app/data/repository/request_model/package_cancel_list_model.dart';
import 'package:get/get.dart';

class DeliverCancelPackageController extends BasePagingController<Package>
    with GetSingleTickerProviderStateMixin {
  final PackageReq _packageRepo = Get.find(tag: (PackageReq).toString());

  @override
  Future<void> fetchDataApi() async {
    PackageCancelListModel requestModel = PackageCancelListModel(
        deliverId: AuthController.instance.account!.id,
        pageIndex: pageIndex,
        pageSize: pageSize);
    Future<List<Package>> future = _packageRepo.getListCancel(requestModel);
    await callDataService<List<Package>>(future,
        onSuccess: onSuccess, onError: onError);
  }
}
