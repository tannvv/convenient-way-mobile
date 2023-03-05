import 'package:get/get.dart';

import '../controllers/package_detail_controller.dart';

class PackageDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PackageDetailController>(
      () => PackageDetailController(),
    );
  }
}
