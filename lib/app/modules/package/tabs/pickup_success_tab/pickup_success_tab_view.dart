import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tien_duong/app/core/widgets/custom_footer_smart_refresh.dart';
import 'package:tien_duong/app/modules/package/tabs/pickup_success_tab/pickup_success_tab_controller.dart';
import 'package:tien_duong/app/modules/package/tabs/pickup_success_tab/pickup_success_tab_item.dart';

class PickupSuccessTabView extends GetView<PickupSuccessTabController> {
  const PickupSuccessTabView({Key? key}) : super(key: key);
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
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PickupSuccessTabItem(
                            package: controller.dataApis[index],
                            onConfirmPackage: () =>
                                controller.accountConfirmPackage(
                                    controller.dataApis[index].id!),
                            onDeliveryFailedPackage: () => controller
                                .deliveredFailed(controller.dataApis[index]),
                            onShowQR: () => controller
                                .showQRCode(controller.dataApis[index].id!),
                            onCodeConfirm: () => controller.deliverConfirmCode(
                                controller.dataApis[index].id!)),
                      ],
                    );
                  },
                  separatorBuilder: (_, index) => Gap(12.h),
                  itemCount: controller.dataApis.length),
            )));
  }
}
