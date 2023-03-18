import 'package:tien_duong/app/core/widgets/custom_footer_smart_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:tien_duong/app/modules/package/tabs/selected_tab/selected__package_tab_item.dart';
import 'package:tien_duong/app/modules/package/tabs/selected_tab/selected_package_tab_controller.dart';

class SelectedPackageTabView extends GetView<SelectedPackageTabController> {
  const SelectedPackageTabView({Key? key}) : super(key: key);

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
                        SelectedPackageTabItem(
                          package: controller.dataApis[index],
                          onCancelPackage: () => controller.cancelPackageDialog(
                              controller.dataApis[index].id!),
                          onConfirmPackage: () =>
                              controller.deliverConfirmPackage(
                                  controller.dataApis[index].id!),
                          onCodeConfirm: () => controller.deliverConfirmCode(
                              controller.dataApis[index].id!),
                          onShowQR: () {
                            controller
                                .showQRCode(controller.dataApis[index].id!);
                          },
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (_, index) => Gap(12.h),
                  itemCount: controller.dataApis.length),
            )));
  }
}
