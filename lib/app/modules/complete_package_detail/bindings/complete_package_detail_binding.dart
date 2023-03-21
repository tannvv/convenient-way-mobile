import 'package:get/get.dart';

import '../controllers/complete_package_detail_controller.dart';

class CompletePackageDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompletePackageDetailController>(
      () => CompletePackageDetailController(),
    );
  }
}
