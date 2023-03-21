import 'package:get/get.dart';

import '../controllers/complete_package_controller.dart';

class CompletePackageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompletePackageController>(
      () => CompletePackageController(),
    );
  }
}
