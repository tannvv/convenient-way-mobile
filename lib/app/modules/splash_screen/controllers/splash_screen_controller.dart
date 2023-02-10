import 'package:tien_duong/app/core/controllers/auth_controller.dart';
import 'package:tien_duong/app/data/constants/account_status.dart';
import 'package:tien_duong/app/data/models/account_model.dart';
import 'package:tien_duong/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  Future<String> screenRouteFunction() async {
    Account? account = await AuthController.isLoginBefore();
    if (account != null) {
      AuthController.reloadAccount();
      return account.status == AccountStatus.noRoute
          ? Routes.CREATE_ROUTE
          : Routes.HOME;
    }
    return Routes.LOGIN;
  }
}
