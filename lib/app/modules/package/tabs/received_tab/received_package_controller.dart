import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/base/base_paging_controller.dart';
import 'package:tien_duong/app/core/controllers/auth_controller.dart';
import 'package:tien_duong/app/core/utils/alert_quick_service.dart';
import 'package:tien_duong/app/core/utils/material_dialog_service.dart';
import 'package:tien_duong/app/core/utils/motion_toast_service.dart';
import 'package:tien_duong/app/data/constants/package_status.dart';
import 'package:tien_duong/app/data/models/package_model.dart';
import 'package:tien_duong/app/data/repository/package_req.dart';
import 'package:tien_duong/app/data/repository/request_model/account_pickup_model.dart';
import 'package:tien_duong/app/data/repository/request_model/package_list_model.dart';
import 'package:tien_duong/app/routes/app_pages.dart';
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
import '../../../../core/controllers/pickup_file_controller.dart';

class ReceivedPackageController extends BasePagingController<Package>
    with GetSingleTickerProviderStateMixin {
  final AuthController _authController = Get.find<AuthController>();
  final PackageReq _packageRepo = Get.find(tag: (PackageReq).toString());
  RxList<String> packageIdsWarning = <String>[].obs;
  String? reason;
  Future<void> accountConfirmPackage(String packageId) async {
    if (await PickUpFileController().scanQR() == packageId) {
      MaterialDialogService.showConfirmDialog(
          msg: 'Bạn chắc chắn muốn nhận gói hàng này để đi giao?',
          closeOnFinish: false,
          onConfirmTap: () async {
            AccountPickUpModel model = AccountPickUpModel(
                deliverId: _authController.account!.id!,
                packageIds: [packageId]);
            _packageRepo.accountConfirmPackage(model).then((response) async {
              packageIdsWarning.value = getPackageIdsNearPackage(
                  dataApis.firstWhere((element) => element.id == packageId),
                  dataApis);
              Get.back();
              if (packageIdsWarning.isNotEmpty) {
                MotionToastService.showWarning(
                    'Còn ${packageIdsWarning.length} gói hàng cần lấy ở gần nơi này');
              } else {
                MotionToastService.showSuccess('Đã lấy hàng để đi giao');
              }
              onRefresh();
              _authController.reloadAccount();
            }).catchError((error) {
              Get.back();
              MotionToastService.showError(error.messages[0]);
            });
          });
    } else {
      MotionToastService.showWarning(
          'QR Code không đúng vui lòng kiểm tra lại!');
      // MaterialDialogService.showConfirmDialog(
      //   msg: 'QR Code không đúng vui lòng kiểm tra lại!',
      //   onConfirmTap: () async {
      //     Get.back();
      //     onRefresh();
      //     _authController.reloadAccount();
      //   }).catchError((error) {
      //     Get.back();
      //     MotionToastService.showError(error.messages[0]);
      //   }
      // );
    }
  }

  @override
  Future<void> fetchDataApi() async {
    PackageListModel requestModel = PackageListModel(
        deliverId: _authController.account!.id,
        status: PackageStatus.DELIVER_PICKUP,
        pageSize: pageSize,
        pageIndex: pageIndex);
    Future<List<Package>> future = _packageRepo.getList(requestModel);
    await callDataService<List<Package>>(future,
        onSuccess: onSuccess, onError: onError);
  }

  Future<void> reportPackage(String packageId) async {
    await MaterialDialogService.showDeleteDialog(
        title: 'Báo xấu',
        msg: 'Bạn chắc chắn muốn báo xấu và hủy gói hàng này?',
        confirmIconData: Icons.check,
        onConfirmTap: () async {
          dynamic result = await Get.toNamed(Routes.CANCEL_PACKAGE,
              arguments: {'packageId': packageId});
          if (result != null && result == true) {
            await QuickAlertService.showSuccess('Huỷ gói hàng thành công',
                duration: 3);
            onRefresh();
          }
        });
  }

  List<String> getPackageIdsNearPackage(Package package, List<Package> list) {
    List<String> packageIds = [];
    List<Package> packages =
        list.where((element) => element.id != package.id).toList();
    for (int i = 0; i < packages.length; i++) {
      double distance = Geolocator.distanceBetween(
          package.startLatitude!,
          package.startLongitude!,
          packages[i].startLatitude!,
          packages[i].startLongitude!);
      debugPrint(
          'Distance package 1: ${package.startLatitude!} - ${package.startLongitude!} ');
      debugPrint(
          'Distance package 2: ${packages[i].startLatitude!} - ${packages[i].startLongitude!} ');
      debugPrint(
          'Distance packageIds:  ${package.id} - ${packages[i].id} : $distance');
      if (distance < 50) {
        packageIds.add(packages[i].id!);
      }
    }
    return packageIds;
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
            text: 'Hủy đơn',
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
        _packageRepo.deliverCancel(requestModel);
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
