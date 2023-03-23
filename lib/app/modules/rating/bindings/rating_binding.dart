import 'package:get/get.dart';
import 'package:tien_duong/app/modules/rating/tabs/creator_tab/creator_tab_controller.dart';
import 'package:tien_duong/app/modules/rating/tabs/receiver_tab/receiver_tab_controller.dart';

import '../controllers/rating_controller.dart';

class RatingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RatingController>(
      () => RatingController(),
    );
    Get.lazyPut<CreatorRatingTabController>(() => CreatorRatingTabController());
    Get.lazyPut<ReceiverRatingTabController>(
        () => ReceiverRatingTabController());
  }
}
