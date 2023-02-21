import 'package:get/get.dart';

import '../controllers/create_package_page_controller.dart';

class CreatePackagePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatePackagePageController>(
      () => CreatePackagePageController(),
    );
  }
}
