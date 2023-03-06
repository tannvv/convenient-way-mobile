import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:tien_duong/app/core/base/sender_tab_base_controller.dart';
import 'package:tien_duong/app/core/controllers/auth_controller.dart';
import 'package:tien_duong/app/core/controllers/pickup_file_controller.dart';
import 'package:tien_duong/app/core/utils/toast_service.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/font_weight.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/core/widgets/button_color.dart';
import 'package:tien_duong/app/data/constants/package_status.dart';
import 'package:tien_duong/app/data/models/package_model.dart';
import 'package:tien_duong/app/data/repository/package_req.dart';
import 'package:tien_duong/app/data/repository/request_model/package_list_model.dart';
import 'package:tien_duong/app/data/repository/response_model/simple_response_model.dart';
import 'package:tien_duong/app/network/exceptions/base_exception.dart';
import 'package:tien_duong/app/routes/app_pages.dart';

class DeliveryTabController extends SenderTabBaseController<Package>
    with GetSingleTickerProviderStateMixin {
  final AuthController _authController = Get.find<AuthController>();
  final PackageReq _packageRepo = Get.find(tag: (PackageReq).toString());

  @override
  Future<void> fetchDataApi() async {
    PackageListModel requestModel = PackageListModel(
        senderId: _authController.account!.id,
        status: PackageStatus.DELIVERY,
        pageIndex: pageIndex,
        pageSize: pageSize);
    Future<List<Package>> future = _packageRepo.getList(requestModel);
    await callDataService<List<Package>>(future,
        onSuccess: onSuccess, onError: onError);
  }

  Future<void> showMapTracking(Package package) async {
    await Get.toNamed(Routes.TRACKING_PACKAGE, arguments: package);
  }


  Future<void> senderConfirmCode(String packageId) async {
    confirmCode(() => {
      confirmCodeFromQR(packageId)
    });
  }

  Future<void> accountDeliveredPackage(String packageId) async {
    if (await PickUpFileController().scanQR() == packageId.split('-')[0]) {
      Future<SimpleResponseModel> future =
      _packageRepo.deliverySuccess(packageId);
      await callDataService<SimpleResponseModel>(future, onSuccess: (response) {
        ToastService.showSuccess(response.message ?? 'Thành công');
        refreshController.requestRefresh();
      }, onError: (exception) {
        if (exception is BaseException) {
          ToastService.showError(exception.message);
        }
      });
    } else {
      ToastService.showError('QR Code không đúng vui lòng kiểm tra lại!');
    }
  }

  Future<void> confirmPackage(String packageId) async {
    _packageRepo.senderConfirmDeliverySuccess(packageId).then((response) async {
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
      ToastService.showError('Mã số sai, vui lòng quét mã QR và kiểm tra lại!',seconds: 5);
      return;
    }
    if(code == packageId.split('-')[0]) {
      confirmPackage(packageId);
      ToastService.showSuccess('Xác nhận gói hàng đã đến tay!');
      refresh();
    };
    await Duration(seconds: 3);
  }

  Future<void> showQRCodee(String packageId) async {
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
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ColorButton(
                  'Xác nhận Mã',
                  icon: Icons.verified,
                  onPressed: () => senderConfirmCode(packageId),
                  backgroundColor: AppColors.green,
                  textColor: AppColors.green,
                  radius: 8.sp,
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
                ),
              ]
          ),
        ],
      ),
    );
  }
}
