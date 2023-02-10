import 'package:get/get.dart';
import 'package:tien_duong/app/core/controllers/auth_controller.dart';
import 'package:tien_duong/app/core/model/payment_result.dart';
import 'package:tien_duong/app/modules/profile_page/controllers/profile_page_controller.dart';
import 'package:tien_duong/app/routes/app_pages.dart';

class PaymentStatusController extends GetxController {
  PaymentResult paymentResult = PaymentResult();

  @override
  void onInit() {
    if (Get.arguments != null) {
      paymentResult = Get.arguments['paymentResult'] as PaymentResult;
      if (paymentResult.status) {
        AuthController.reloadAccount();
      }
    }
    super.onInit();
  }

  void returnProfilePage() {
    ProfilePageController profileController = Get.find<ProfilePageController>();
    profileController.account.balance =
        AuthController.instance.account?.balance;
    Get.offAllNamed(Routes.HOME, arguments: {'initialPageIndex': '4'});
  }
}
