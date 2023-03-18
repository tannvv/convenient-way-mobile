import 'package:get/get.dart';

import '../controllers/route_detail_controller.dart';

class RouteDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RouteDetailController>(
      () => RouteDetailController(),
    );
  }
}
