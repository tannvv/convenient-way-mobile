import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tien_duong/app/core/values/app_assets.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/box_decorations.dart';
import 'package:tien_duong/app/core/values/font_weight.dart';
import 'package:tien_duong/app/core/values/shadow_styles.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/core/widgets/button_color.dart';
import 'package:tien_duong/app/core/widgets/custom_footer_smart_refresh.dart';
import 'package:tien_duong/app/modules/suggest_package/widgets/show_wallet.dart';
import 'package:tien_duong/app/modules/suggest_package/widgets/suggest_item.dart';
import 'package:tien_duong/app/modules/suggest_package/widgets/user_avatar.dart';
import 'package:tien_duong/app/routes/app_pages.dart';
import '../controllers/suggest_package_controller.dart';

class SuggestPackageView extends GetView<SuggestPackageController> {
  SuggestPackageView({Key? key}) : super(key: key);
  final GlobalKey _refresherKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => Stack(
        children: [
          _headerBackground(),
          AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: EdgeInsets.only(top: controller.headerState.height),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20.w, top: 28.h),
                        child: Text(
                            controller.statusAccount == 'NO_ROUTE'
                                ? 'Các gói hàng hiện có trong hệ thống,\nvui lòng tạo lộ trình để có các gói\nhàng phù hợp'
                                : 'Các gói hàng phù hợp',
                            style: subtitle1.copyWith(
                                color: AppColors.gray,
                                fontWeight: FontWeights.bold)),
                      )
                    ],
                  ),
                  Expanded(
                    child: SmartRefresher(
                      enablePullUp: true,
                      key: _refresherKey,
                      controller: controller.refreshController,
                      onRefresh: () => controller.onRefresh(),
                      onLoading: () => controller.onLoading(),
                      footer: CustomFooterSmartRefresh.defaultCustom(),
                      child: ListView.separated(
                          itemBuilder: (_, index) => GestureDetector(
                                onTap: () => controller
                                    .gotoDetail(controller.dataApis[index]),
                                child: SuggestPackageItem(
                                    suggestPackage: controller.dataApis[index]),
                              ),
                          padding: const EdgeInsets.all(20),
                          separatorBuilder: (_, index) => Gap(15.h),
                          itemCount: controller.dataApis.length),
                    ),
                  )
                ],
              ))
        ],
      ),
    ));
  }

  Container _wallet() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(5.r),
        boxShadow: ShadowStyles.surface,
      ),
      width: 324.w,
      height: 120.h,
      padding: EdgeInsets.symmetric(
        vertical: 10.h,
        horizontal: 14.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Số dư', style: body2.copyWith(color: AppColors.floatLabel)),
              Gap(6.w),
              _balanceAvailable(),
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          Obx(
            () => Text(controller.balanceAccountVND,
                style: subtitle1.copyWith(
                  fontSize: 18.sp,
                  color: AppColors.softBlack,
                  fontWeight: FontWeights.medium,
                )),
          ),
          SizedBox(
            height: 3.h,
          ),
          Row(
            children: [
              ColorButton(
                'Nạp tiền',
                onPressed: () {
                  Get.toNamed(Routes.PAYMENT);
                },
                icon: Icons.payments_outlined,
              ),
              SizedBox(
                width: 10.w,
                height: 2.h,
              ),
              ColorButton(
                'Giao dịch',
                onPressed: () => {
                  Get.toNamed(Routes.TRANSACTION),
                },
                icon: Icons.summarize_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row _appBar() {
    return Row(
      children: [
        const Expanded(
          child: UserAvatar(),
        ),
        ShowWallet(
          onPressed: () {
            controller.toggleHeader();
          },
          state: controller.headerState.walletUiState,
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.NOTIFICATION_PAGE);
          },
          child: SizedBox(
            height: 36.r,
            width: 36.r,
            child: Icon(
              Icons.notifications_outlined,
              color: AppColors.white,
              size: 24.r,
            ),
          ),
        ),
      ],
    );
  }

  AnimatedContainer _headerBackground() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecorations.header(),
      height: controller.headerState.height + 20.h,
      child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(5.r),
            bottomRight: Radius.circular(5.r),
          ),
          child: Stack(
            children: [
              SvgPicture.asset(
                AppAssets.homeBg,
                fit: BoxFit.cover,
              ),
              SafeArea(child: _header())
            ],
          )),
    );
  }

  Container _header() {
    return Container(
      padding: EdgeInsets.only(left: 18.w, top: 2.h, right: 18.w),
      height: controller.headerState.height,
      child: Obx(
        () => Column(
          children: [
            _appBar(),
            !controller.headerState.walletUiState
                ? Column(
                    children: [
                      SizedBox(
                        height: 18.h,
                      ),
                      _wallet(),
                      SizedBox(
                        height: 18.h,
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Obx _balanceAvailable() {
    return Obx(() => controller.isLoadingBalance
        ? Shimmer.fromColors(
            baseColor: AppColors.shimmerBaseColor,
            highlightColor: AppColors.shimmerHighlightColor,
            child: Container(
              width: 50.w,
              height: 14.h,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
          )
        : controller.isNewAccount
            ? Container()
            : Text(
                '(khả dụng: ${controller.availableBalance.toVND()})',
                style: caption.copyWith(
                  color: AppColors.softBlack,
                  fontWeight: FontWeights.medium,
                ),
              ));
  }
}
