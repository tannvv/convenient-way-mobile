import 'package:tien_duong/app/core/widgets/custom_footer_smart_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:tien_duong/app/modules/package_cancel_and_refund/tabs/refund_failed_tab/refund_failed_tab_item.dart';
import 'package:tien_duong/app/modules/package_cancel_and_refund/tabs/sender_cancel_tab/sender_cancel_tab_controller.dart';

class SenderCancelTabView extends GetView<SenderCancelTabController> {
  const SenderCancelTabView({Key? key}) : super(key: key);

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
                        RefundFailedTabItem(
                          package: controller.dataApis[index],
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (_, index) => Gap(12.h),
                  itemCount: controller.dataApis.length),
            )));
  }
}
