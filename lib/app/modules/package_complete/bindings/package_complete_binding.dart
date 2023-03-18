import 'package:get/get.dart';

import '../controllers/package_complete_controller.dart';

class PackageCompleteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PackageCompleteController>(
      () => PackageCompleteController(),
    );
  }
}
