import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:tien_duong/app/core/base/base_paging_controller.dart';
import 'package:tien_duong/app/core/controllers/auth_controller.dart';
import 'package:tien_duong/app/core/utils/toast_service.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/data/constants/package_status.dart';
import 'package:tien_duong/app/data/models/package_model.dart';
import 'package:tien_duong/app/data/repository/package_req.dart';
import 'package:tien_duong/app/data/repository/request_model/cancel_package_model.dart';
import 'package:tien_duong/app/data/repository/request_model/package_list_model.dart';
import 'package:tien_duong/app/data/repository/response_model/simple_response_model.dart';
import 'package:tien_duong/app/network/exceptions/base_exception.dart';

class CancelController extends BasePagingController<Package>
    with GetSingleTickerProviderStateMixin {
  final AuthController _authController = Get.find<AuthController>();
  final PackageReq _packageRepo = Get.find(tag: (PackageReq).toString());

  String? reason;

  @override
  Future<void> fetchDataApi() async {
    PackageListModel requestModel = PackageListModel(
        senderId: _authController.account!.id,
        status: PackageStatus.WAITING,
        pageIndex: pageIndex,
        pageSize: pageSize);
    Future<List<Package>> future = _packageRepo.getList(requestModel);
    await callDataService<List<Package>>(future,
        onSuccess: onSuccess, onError: onError);
  }

  Future<void> cancelPackageDialog(String packageId) async {
    await Dialogs.materialDialog(
        context: Get.context!,
        customView: _cancelWidget(),
        actions: [
          IconsButton(
            onPressed: () {
              Get.back();
            },
            text: 'Thoát',
            iconData: Icons.arrow_back_ios_new,
            color: const Color.fromARGB(255, 204, 203, 203),
            textStyle: const TextStyle(color: Colors.black38),
            iconColor: Colors.black38,
          ),
          IconsButton(
            onPressed: () {
              deliverCancelPackage(packageId);
            },
            text: 'Xác nhận hủy đơn',
            iconData: Icons.check,
            color: Colors.red,
            textStyle: const TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ]);
  }

  Future<void> deliverCancelPackage(String packageId) async {
    if (reason == null || reason!.isEmpty) {
      ToastService.showError('Vui lòng nhập lý do hủy đơn hàng');
      return;
    }

    CancelPackageModel requestModel = CancelPackageModel(
      packageId: packageId,
      reason: reason!,
    );
    Future<SimpleResponseModel> future =
    _packageRepo.senderCancel(requestModel);
    await callDataService<SimpleResponseModel>(future, onSuccess: (data) {
      ToastService.showSuccess('Hủy gói hàng thành công!');
      Get.back();
      refresh();
    }, onError: (error) {
      if (error is BaseException) {
        ToastService.showError(error.message);
      } else {
        ToastService.showError('Có lỗi xảy ra!');
      }
    });
  }

  Widget _cancelWidget() {
    return Container(
      padding: EdgeInsets.only(top: 20.h),
      height: 100.h,
      width: 220.w,
      child: Column(
        children: [
          Text(
            'Lý do hủy',
            style: subtitle2.copyWith(fontSize: 16.sp),
          ),
          const SizedBox(height: 10),
          TextField(
            onChanged: (value) {
              reason = value;
            },
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 20.w)),
          ),
        ],
      ),
    );
  }
}
