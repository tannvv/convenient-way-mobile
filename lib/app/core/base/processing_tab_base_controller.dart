import 'package:get/get.dart';
import 'package:tien_duong/app/core/base/base_paging_controller.dart';
import 'package:tien_duong/app/modules/package/controllers/package_controller.dart';

class ProcessingTabBaseController<T> extends BasePagingController<T> {
  final PackageController packageController = Get.find<PackageController>();
  @override
  Future<void> fetchDataApi() async {
    packageController.fetchPackageCount();
  }

  @override
  Future<void> onRefresh() async {
    packageController.fetchPackageCount();
    super.onRefresh();
  }
}
