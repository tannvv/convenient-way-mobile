import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tien_duong/app/core/base/base_paging_controller.dart';
import 'package:tien_duong/app/core/utils/material_dialog_service.dart';
import 'package:tien_duong/app/core/utils/toast_service.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/font_weight.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/data/models/account_model.dart';
import 'package:tien_duong/app/data/models/account_rating_model.dart';
import 'package:tien_duong/app/data/repository/account_req.dart';
import 'package:tien_duong/app/modules/sender_package/widgets/user_info.dart';

abstract class DeliverTabBaseController<T> extends BasePagingController<T> {
  AccountRating? senderRating;

  final RxBool _isLoadingInfo = false.obs;

  final AccountRep _accountRepo = Get.find(tag: (AccountRep).toString());

  void showInfoSender(Account deliver) async {
    var future = _accountRepo.getRating(deliver.id!);
    callDataService<AccountRating>(
      future,
      onSuccess: (data) {
        senderRating = data;
        if (data.totalRatingDeliver == 0) {
          ToastService.showInfo('Chưa có đánh giá nào');
        }
      },
      onError: (exception) => showError(exception),
      onStart: () => _isLoadingInfo.value = true,
      onComplete: () => _isLoadingInfo.value = false,
    );
    MaterialDialogService.showEmptyDialog(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserInfo(info: deliver.infoUser!),
              Gap(24.h),
              RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: 'Số điện thoại: ',
                          style: subtitle2.copyWith(fontWeight: FontWeights.regular)),
                      TextSpan(text: deliver.infoUser!.phone, style: subtitle2),
                    ],
                  )),
              Gap(8.h),
              Obx(() => _isLoadingInfo.value
                  ? Shimmer.fromColors(
                baseColor: AppColors.shimmerBaseColor,
                highlightColor: AppColors.shimmerHighlightColor,
                child: Container(
                  width: 200.w,
                  height: 32.h,
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
              )
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RatingBar.builder(
                    initialRating: senderRating!.averageRatingDeliver!,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    ignoreGestures: true,
                    onRatingUpdate: (_) {},
                  ),
                ],
              ))
            ],
          ),
        ));
  }

  Future<void> showQRCode(String packageId) async {
    final svg = Barcode.qrCode().toSvg(packageId);
    await Dialogs.materialDialog(
        dialogWidth: 400.w,
        context: Get.context!,
        customView: _qrCodeWidget(svg));
  }

  Widget _qrCodeWidget(String svg) {
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
          )
        ],
      ),
    );
  }
}
