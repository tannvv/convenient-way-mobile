import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/core/widgets/custom_body_scaffold.dart';
import 'package:tien_duong/app/core/widgets/custom_footer_smart_refresh.dart';
import 'package:tien_duong/app/core/widgets/header_scaffold.dart';
import 'package:tien_duong/app/data/models/notification_model.dart';
import 'package:tien_duong/app/modules/notification_page/controllers/notification_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../widgets/notification_item.dart';

class NotificationPageView extends GetView<NotificationPageController> {
  const NotificationPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBodyScaffold(
        header: _header(),
        body: Obx(
          () => SmartRefresher(
            controller: controller.refreshController,
            enablePullUp: true,
            onRefresh: () => controller.onRefresh(),
            onLoading: () => controller.onLoading(),
            footer: CustomFooterSmartRefresh.defaultCustom(),
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              itemBuilder: (_, index) {
                NotificationModel item = controller.dataApis[index];
                if (item.filter == 0) {
                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 18.w, right: 18.w, top: 10.h, bottom: 6.h),
                        child: Row(
                          children: [
                            Text(
                              'Hôm nay',
                              style: h6.copyWith(
                                  color: AppColors.softBlack, fontSize: 18.sp),
                            ),
                          ],
                        ),
                      ),
                      NotificationItem(
                        index: index,
                        model: item,
                      ),
                    ],
                  );
                } else if (item.filter == 1) {
                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 18.w, right: 18.w, top: 10.h, bottom: 6.h),
                        child: Row(
                          children: [
                            Text(
                              'Trước đó',
                              style: h6.copyWith(
                                  color: AppColors.softBlack, fontSize: 18.sp),
                            ),
                          ],
                        ),
                      ),
                      NotificationItem(
                        index: index,
                        model: item,
                      ),
                    ],
                  );
                }
                return NotificationItem(
                  index: index,
                  model: controller.dataApis[index],
                );
              },
              itemCount: controller.dataApis.length,
              separatorBuilder: (BuildContext context, int index) => Gap(10.h),
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return const HeaderScaffold(title: 'Thông báo');
  }
}
