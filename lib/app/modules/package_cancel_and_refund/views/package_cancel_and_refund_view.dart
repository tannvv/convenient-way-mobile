import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:scroll_navigation/misc/navigation_helpers.dart';
import 'package:scroll_navigation/navigation/title_scroll_navigation.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/font_weight.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/core/widgets/header_scaffold.dart';

import '../controllers/package_cancel_and_refund_controller.dart';

class PackageCancelAndRefundView
    extends GetView<PackageCancelAndRefundController> {
  const PackageCancelAndRefundView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Expanded(flex: 1, child: _header()),
            Expanded(
              flex: 11,
              child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Obx(
                    () => TitleScrollNavigation(
                      identiferStyle: NavigationIdentiferStyle(
                          width: 10.w, color: AppColors.primary900),
                      showIdentifier: true,
                      barStyle: TitleNavigationBarStyle(
                        style: subtitle2.copyWith(
                            color: AppColors.primary800,
                            fontWeight: FontWeights.medium),
                        elevation: 2,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40.0, vertical: 12),
                        spaceBetween: 40,
                        background: AppColors.white,
                      ),
                      titles: controller.tabsTitle,
                      pages: controller.screens,
                    ),
                  )),
            )
          ],
        ),
      )),
    );
  }

  Widget _header() {
    return const HeaderScaffold(
      title: 'Đơn hàng bị hủy & hoàn trả',
      isBack: true,
    );
  }
}
