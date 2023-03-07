import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/base/base_paging_controller.dart';
import 'package:tien_duong/app/core/controllers/auth_controller.dart';
import 'package:tien_duong/app/core/utils/alert_quick_service.dart';
import 'package:tien_duong/app/core/utils/material_dialog_service.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/input_styles.dart';
import 'package:tien_duong/app/core/widgets/button_color.dart';
import 'package:tien_duong/app/data/constants/package_status.dart';
import 'package:tien_duong/app/data/models/package_model.dart';
import 'package:tien_duong/app/data/repository/package_req.dart';
import 'package:tien_duong/app/data/repository/request_model/check_code_model.dart';
import 'package:tien_duong/app/data/repository/request_model/package_list_model.dart';
import 'package:tien_duong/app/modules/location_package/controllers/location_package_controller.dart';
import 'package:tien_duong/app/routes/app_pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:tien_duong/app/core/utils/toast_service.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/data/repository/request_model/cancel_package_model.dart';
import 'package:tien_duong/app/data/repository/response_model/simple_response_model.dart';
import 'package:tien_duong/app/network/exceptions/base_exception.dart';
import '../../../../core/controllers/pickup_file_controller.dart';
import 'package:barcode/barcode.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:material_dialogs/dialogs.dart';
import '../../../../core/values/font_weight.dart';

class ReceivedPackageController extends BasePagingController<Package>
    with GetSingleTickerProviderStateMixin {
  final AuthController _authController = Get.find<AuthController>();
  final LocationPackageController _locationPackageController =
      Get.find<LocationPackageController>();
  final PackageReq _packageRepo = Get.find(tag: (PackageReq).toString());
  RxList<String> packageIdsWarning = <String>[].obs;
  String? reason;
  String? code;

  Future<void> acceptDeliveryPackage(String packageId) async {
    _packageRepo.confirmPackage(packageId).then((response) async {
      packageIdsWarning.value = getPackageIdsNearPackage(
          dataApis.firstWhere((element) => element.id == packageId), dataApis);
      Get.back();
      if (packageIdsWarning.isNotEmpty) {
        ToastService.showInfo(
            'Còn ${packageIdsWarning.length} gói hàng cần lấy ở gần nơi này');
      } else {
        ToastService.showSuccess('Đã lấy hàng để đi giao');
      }
      onRefresh();
      _authController.reloadAccount();
    }).catchError((error) {
      Get.back();
      ToastService.showError(error.messages[0]);
    });
  }

  Future<void> accountScanQr(String packageId) async {
    await showQRCode(packageId).then(
      (value) => {
        MaterialDialogService.showConfirmDialog(
          msg: 'Bạn chắc chắn muốn nhận gói hàng này để đi giao?',
          closeOnFinish: false,
          onConfirmTap: () async {
            _packageRepo.confirmPackage(packageId).then((response) async {
              packageIdsWarning.value = getPackageIdsNearPackage(
                  dataApis.firstWhere((element) => element.id == packageId),
                  dataApis);
              Get.back();
              if (packageIdsWarning.isNotEmpty) {
                ToastService.showInfo(
                    'Còn ${packageIdsWarning.length} gói hàng cần lấy ở gần nơi này');
              } else {
                ToastService.showSuccess('Đã lấy hàng để đi giao');
              }
              onRefresh();
              _authController.reloadAccount();
            }).catchError((error) {
              Get.back();
              ToastService.showError(error.messages[0]);
            });
          },
        ),
      },
    );
  }

  Future<void> deliverConfirmPackage(String packageId) async {
    if (await PickUpFileController().scanQR() == packageId.split('-')[0]) {
      MaterialDialogService.showConfirmDialog(
          msg: 'Bạn chắc chắn muốn nhận gói hàng này để đi giao?',
          closeOnFinish: false,
          onConfirmTap: () async {
            // _packageRepo.confirmPackage(packageId).then((response) async {
            //   packageIdsWarning.value = getPackageIdsNearPackage(
            //       dataApis.firstWhere((element) => element.id == packageId),
            //       dataApis);
            //   Get.back();
            //   Get.back();
            //   if (packageIdsWarning.isNotEmpty) {
            //     ToastService.showInfo(
            //         'Còn ${packageIdsWarning.length} gói hàng cần lấy ở gần nơi này');
            //   } else {
            //     ToastService.showSuccess('Đã lấy hàng để đi giao');
            //     Get.back();
            //   }
            //   hideOverlay();
            //   onRefresh();
            //   _authController.reloadAccount();
            // }).catchError((error) {
            //   hideOverlay();
            //   Get.back();
            //   ToastService.showError(error.messages[0]);
            // });
            var future = _packageRepo.confirmPackage(packageId);
            await callDataService(future,
                onStart: showOverlay,
                onComplete: hideOverlay, onSuccess: (response) {
              packageIdsWarning.value = getPackageIdsNearPackage(
                  dataApis.firstWhere((element) => element.id == packageId),
                  dataApis);
              Get.back();
              Get.back();
              if (packageIdsWarning.isNotEmpty) {
                ToastService.showInfo(
                    'Còn ${packageIdsWarning.length} gói hàng cần lấy ở gần nơi này');
              } else {
                ToastService.showSuccess('Đã lấy hàng để đi giao');
                Get.back();
              }
              hideOverlay();
              onRefresh();
              _authController.reloadAccount();
              _locationPackageController.fetchPackages();
            }, onError: ((exception) {
              showError(exception);
              Get.back();
            }));
          });
    } else {
      ToastService.showError('QR Code không đúng vui lòng kiểm tra lại!');
      // MaterialDialogService.showConfirmDialog(
      //   msg: 'QR Code không đúng vui lòng kiểm tra lại!',
      //   onConfirmTap: () async {
      //     Get.back();
      //     onRefresh();
      //     _authController.reloadAccount();
      //   }).catchError((error) {
      //     Get.back();
      //    ToastService.showError(error.messages[0]);
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

  Future<void> deliverConfirmCode(String packageId) async {
    confirmCode(() => {confirmCodeFromQR(packageId)});
  }

  Widget _confirmCodeWidget() {
    return Container(
      padding: EdgeInsets.only(top: 40.h),
      height: 100.h,
      width: 220.w,
      child: TextField(
        onChanged: (value) {
          code = value;
        },
        autofocus: true,
        decoration: InputStyles.reasonCancel(labelText: 'Nhập mã xác nhận'),
      ),
    );
  }

  Future<void> confirmCode(Function() callback) async {
    await Dialogs.materialDialog(
        context: Get.context!,
        customView: _confirmCodeWidget(),
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
              callback();
              Get.back();
            },
            text: 'Xác nhận',
            iconData: Icons.check,
            color: Colors.blue,
            textStyle: const TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ]);
  }

  Future<void> accountConfirmPackage(String packageId) async {
    _packageRepo.confirmPackage(packageId).then((response) async {
      Get.back();
      onRefresh();
      _authController.reloadAccount();
    }).catchError((error) {
      Get.back();
      ToastService.showError(error.messages[0]);
    });
  }

  Future<void> confirmCodeFromQR(String packageId) async {
    if (code == null || code != packageId.split('-')[0]) {
      ToastService.showError('Mã số sai, vui lòng quét mã QR và kiểm tra lại!',
          seconds: 5);
      return;
    }
    CodeModel requestModel = CodeModel(
      packageId: packageId,
      code: code!,
    );
    if (code == packageId.split('-')[0]) {
      accountConfirmPackage(packageId);
      ToastService.showSuccess('Xác nhận gói hàng đã đến tay!');
      refresh();
    }
    ;
    await Duration(seconds: 3);
  }

  Future<void> showQRCode(String packageId) async {
    final svg = Barcode.qrCode().toSvg(packageId.split('-')[0]);
    await Dialogs.materialDialog(
        dialogWidth: 400.w,
        context: Get.context!,
        customView: _qrCodeWidget(svg, packageId));
  }

  Widget _qrCodeWidget(String svg, String packageId) {
    return Container(
      padding: EdgeInsets.only(top: 40.h, right: 40.w, left: 40.w),
      child: Column(
        children: [
          Text(
            'Dùng mã này để xác nhận người giao hàng',
            style: subtitle2,
          ),
          Gap(4.h),
          RichText(
              text: TextSpan(
                  text: 'Chú ý:',
                  style: caption.copyWith(
                      color: Colors.red[600],
                      fontWeight: FontWeights.medium,
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline),
                  children: [
                TextSpan(
                    text:
                        ' tuyệt đối không chia sẽ mã này với người không liên quan',
                    style: caption.copyWith(decoration: TextDecoration.none))
              ])),
          Gap(20.h),
          SizedBox(
            height: 200.h,
            width: 200.w,
            child: SvgPicture.string(
              svg,
              fit: BoxFit.cover,
            ),
          ),
          Gap(20.h),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ColorButton(
              'Xác nhận Mã',
              icon: Icons.verified,
              onPressed: () => deliverConfirmCode(packageId),
              backgroundColor: AppColors.green,
              textColor: AppColors.green,
              radius: 8.sp,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
            ),
          ]),
        ],
      ),
    );
  }
}
