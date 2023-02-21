import 'package:get/get.dart';

import '../controllers/tracking_package_controller.dart';

class TrackingPackageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrackingPackageController>(
      () => TrackingPackageController(),
    );
  }
}
