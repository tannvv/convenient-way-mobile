import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/base/base_paging_controller.dart';
import 'package:tien_duong/app/core/controllers/auth_controller.dart';
import 'package:tien_duong/app/data/models/account_model.dart';
import 'package:tien_duong/app/data/models/suggest_package_model.dart';
import 'package:tien_duong/app/data/repository/package_req.dart';
import 'package:tien_duong/app/data/repository/request_model/suggest_package_request_model.dart';
import 'package:tien_duong/app/modules/suggest_package/model/header_state.dart';
import 'package:tien_duong/app/routes/app_pages.dart';

class SuggestPackageController extends BasePagingController<SuggestPackage> {
  final AuthController _authController = Get.find<AuthController>();
  final HeaderState headerState = HeaderState();

  Account? get account => _authController.account;
  bool get isLoadingBalance => _authController.isLoadingAvailableBalance;
  int get availableBalance => _authController.availableBalance;
  String get balanceAccountVND =>
      _authController.account?.balance.toVND() ?? '-';
  String get statusAccount => _authController.account?.status ?? '';

  final PackageReq _packageRepo = Get.find(tag: (PackageReq).toString());

  void gotoDetail(SuggestPackage suggest) async {
    if (account?.status == 'NO_ROUTE') {
      bool isExistedRoute = await _authController.requireCreateRoute();
      if (isExistedRoute) {
        refreshController.requestRefresh();
      }
    } else {
      dynamic result =
          await Get.toNamed(Routes.SUGGEST_PACKAGE_DETAIL, arguments: suggest);
      if (result == true) {
        refreshController.requestRefresh();
      }
    }
  }

  void toggleHeader() {
    headerState.toggle();
  }

  @override
  Future<void> fetchDataApi() async {
    String? accountId = _authController.account?.id;
    if (accountId != null) {
      SuggestPackageRequestModel model = SuggestPackageRequestModel(
        deliverId: accountId,
        pageSize: pageSize,
        pageIndex: pageIndex,
      );
      Future<List<SuggestPackage>> future =
          _packageRepo.getSuggestPackage(model);
      await callDataService<List<SuggestPackage>>(future,
          onSuccess: onSuccess, onError: onError);
    }
  }
}
