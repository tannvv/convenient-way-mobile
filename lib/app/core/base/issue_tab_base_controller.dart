import 'package:get/get.dart';
import 'package:tien_duong/app/core/base/base_paging_controller.dart';
import 'package:tien_duong/app/modules/package_cancel_and_refund/controllers/package_cancel_and_refund_controller.dart';

class IssueTabBaseController<T> extends BasePagingController<T> {
  final PackageCancelAndRefundController _packageController =
      Get.find<PackageCancelAndRefundController>();
  @override
  Future<void> fetchDataApi() async {
    _packageController.fetchPackageCount();
  }
}
