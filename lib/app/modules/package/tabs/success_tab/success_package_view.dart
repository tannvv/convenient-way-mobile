import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/box_decorations.dart';
import 'package:tien_duong/app/core/values/shadow_styles.dart';
import 'package:tien_duong/app/core/widgets/custom_footer_smart_refresh.dart';
import 'package:tien_duong/app/modules/package/tabs/received_tab/received_package_controller.dart';
import 'package:tien_duong/app/modules/package/tabs/success_tab/success_package_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SuccessView extends GetView<ReceivedPackageController> {
  const SuccessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Obx(() => SmartRefresher(
              controller: controller.refreshController,
              onRefresh: () => controller.onRefresh(),
              onLoading: () => controller.onLoading(),
              footer: CustomFooterSmartRefresh.defaultCustom(),
              child: ListView.separated(
                  itemBuilder: (_, index) {
                    return Container(
                        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 24.w),
                    decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(6.w),
                    boxShadow: ShadowStyles.primary),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SuccessPackageItem(package: controller.dataApis[index]),
                      ],
                    ));
                  },
                  separatorBuilder: (_, index) => Gap(12.h),
                  itemCount: controller.dataApis.length),
            )));
  }
}
