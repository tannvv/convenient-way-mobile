import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/base/base_controller.dart';
import 'package:tien_duong/app/core/controllers/auth_controller.dart';
import 'package:tien_duong/app/core/utils/toast_service.dart';
import 'package:tien_duong/app/data/constants/user_config_name.dart';
import 'package:tien_duong/app/data/repository/account_req.dart';
import 'package:tien_duong/app/data/repository/request_model/account_model/update_user_config_model.dart';

class UserConfigController extends BaseController {
  final AuthController authController = Get.find<AuthController>();

  final AccountRep _accountRep = Get.find(tag: (AccountRep).toString());

  final CurrencyTextInputFormatter formatter = CurrencyTextInputFormatter(
    decimalDigits: 0,
    locale: 'vi',
    symbol: '',
  );

  var warningPriceField = ''.obs;
  var packageDistanceField = ''.obs;
  var directionSuggestField = ''.obs;
  var isActive = false.obs;

  RxString initWarningPriceOrigin = ''.obs;
  RxString initPackageDistanceOrigin = ''.obs;

  String get initWarningPrice =>
      formatter.format(authController.warningPriceConfig.toString());
  String get initPackageDistance =>
      authController.packageDistanceConfig.toString();
  String get initDirectionSuggest =>
      authController.directionSuggestConfig.toString();

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  void initData() {
    warningPriceField.value = initWarningPrice;
    packageDistanceField.value = initPackageDistance;
    directionSuggestField.value = initDirectionSuggest;
    isActive.value = authController.isActiveConfig ?? false;

    initWarningPriceOrigin.value = initWarningPrice;
    initPackageDistanceOrigin.value = initPackageDistance;
  }

  Future<void> updateWarningPrice() async {
    if (warningPriceField.value != initWarningPrice) {
      UpdateUserConfigModel model = UpdateUserConfigModel(
        accountId: authController.account?.id,
        configName: UserConfigName.WARNING_PRICE,
        configValue: warningPriceField.value.replaceAll('.', ''),
      );
      var future = _accountRep.updateUserConfig(model);
      callDataService(future, onSuccess: (data) {
        ToastService.showSuccess('Cập nhập thành công');
        initWarningPriceOrigin.value = warningPriceField.value;
        authController.reloadAccount();
      }, onError: showError, onStart: showOverlay, onComplete: hideOverlay);
    }
  }

  Future<void> updatePackageDistance() async {
    if (packageDistanceField.value != initPackageDistance) {
      UpdateUserConfigModel model = UpdateUserConfigModel(
        accountId: authController.account?.id,
        configName: UserConfigName.PACKAGE_DISTANCE,
        configValue: packageDistanceField.value,
      );
      var future = _accountRep.updateUserConfig(model);
      callDataService(future, onSuccess: (data) {
        ToastService.showSuccess('Cập nhập thành công');
        initPackageDistanceOrigin.value = packageDistanceField.value;
        authController.reloadAccount();
      }, onError: showError, onStart: showOverlay, onComplete: hideOverlay);
    }
  }

  Future<void> updateDirectionSuggest(String value) async {
    if (directionSuggestField.value == value) return;
    await authController.loadPackageCount();
    if (authController.packageCount!.selected! > 0 ||
        authController.packageCount!.pickupSuccess! > 0) {
      ToastService.showError('Bạn đang nhận kiện hàng, không thể đổi lộ trình');
      return;
    }

    UpdateUserConfigModel model = UpdateUserConfigModel(
      accountId: authController.account?.id,
      configName: UserConfigName.DIRECTION_SUGGEST,
      configValue: value,
    );
    var future = _accountRep.updateUserConfig(model);
    callDataService(future, onSuccess: (data) {
      ToastService.showSuccess('Cập nhập thành công');
      directionSuggestField.value = value;
      authController.reloadAccount();
    }, onError: showError, onStart: showOverlay, onComplete: hideOverlay);
  }

  Future<void> changeStatus() async {
    await authController.loadPackageCount();
    if (authController.packageCount!.selected! > 0 ||
        authController.packageCount!.pickupSuccess! > 0) {
      ToastService.showError(
          'Bạn đang nhận kiện hàng, không thể chuyển trạng thái');
      return;
    }

    UpdateUserConfigModel model = UpdateUserConfigModel(
      accountId: authController.account?.id,
      configName: UserConfigName.IS_ACTIVE,
      configValue: !isActive.value ? 'TRUE' : 'FALSE',
    );
    var future = _accountRep.updateUserConfig(model);
    callDataService(future, onSuccess: (data) {
      ToastService.showSuccess('Chuyển trạng thái thành công');
      authController.reloadAccount();
      isActive.value = !isActive.value;
    }, onError: showError, onStart: showOverlay, onComplete: hideOverlay);
  }
}
