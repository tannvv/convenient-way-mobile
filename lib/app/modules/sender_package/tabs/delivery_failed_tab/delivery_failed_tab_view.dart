import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tien_duong/app/core/widgets/custom_footer_smart_refresh.dart';
import 'package:tien_duong/app/modules/sender_package/tabs/delivery_failed_tab/delivery_failed_tab_controller.dart';
import 'package:tien_duong/app/modules/sender_package/tabs/delivery_failed_tab/delivery_failed_tab_item.dart';

class DeliveryFailedTabView extends GetView<DeliveryFailedTabController> {
  const DeliveryFailedTabView({Key? key}) : super(key: key);
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
                        DeliveryFailedTabItem(
                            package: controller.dataApis[index],
                            showInfoDeliver: () => controller.showInfoDeliver(
                                controller.dataApis[index].deliver!)),
                      ],
                    );
                  },
                  separatorBuilder: (_, index) => Gap(12.h),
                  itemCount: controller.dataApis.length),
            )));
  }
}
