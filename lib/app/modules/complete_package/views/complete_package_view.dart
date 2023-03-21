import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tien_duong/app/core/widgets/custom_body_scaffold.dart';
import 'package:tien_duong/app/core/widgets/custom_footer_smart_refresh.dart';
import 'package:tien_duong/app/core/widgets/header_scaffold.dart';

import '../controllers/complete_package_controller.dart';
import '../widgets/complete_package_item.dart';

class CompletePackageView extends GetView<CompletePackageController> {
  const CompletePackageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBodyScaffold(header: _buildHeader(), body: _buildBody()),
    );
  }

  Widget _buildHeader() {
    return const HeaderScaffold(
      title: 'Các kiện hàng đã giao',
      isBack: true,
    );
  }

  Widget _buildBody() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
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
                        CompletePackageItem(
                          package: controller.dataApis[index],
                          onTapDetail: () => controller.gotoDetail(controller.dataApis[index]),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (_, index) => Gap(12.h),
                  itemCount: controller.dataApis.length),
            )));
  }
}
