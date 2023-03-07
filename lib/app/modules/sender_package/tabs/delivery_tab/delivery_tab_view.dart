import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tien_duong/app/core/widgets/custom_footer_smart_refresh.dart';
import 'package:tien_duong/app/modules/sender_package/tabs/delivery_tab/delivery_tab_controller.dart';

import 'delivery_tab_item.dart';

class DeliveryTabView extends GetView<DeliveryTabController> {
  const DeliveryTabView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
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
                        DeliveryTabItem(
                          package: controller.dataApis[index],
                          onConfirmPackage: () => controller.accountDeliveredPackage(
                              controller.dataApis[index].id!),
                          onCodeConfirm: () => controller.senderConfirmCode(
                              controller.dataApis[index].id!),
                          onShowQR: () => controller.showQRCode(
                              controller.dataApis[index].id!),
                          showMapTracking: () => controller.showMapTracking(
                              controller.dataApis[index]),
                          onShowDeliverInfo: () => controller.showInfoDeliver(
                              controller.dataApis[index].deliver!)
                        )
                      ],
                    );
                  },
                  separatorBuilder: (_, index) => Gap(12.h),
                  itemCount: controller.dataApis.length),
            )));
  }
}
